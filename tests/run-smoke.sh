#!/usr/bin/env bash
# End-to-end smoke test: runs the real skills headless against a fictional
# persona and checks the outputs. Needs a logged-in `claude` CLI.
# Usage: tests/run-smoke.sh [tailor|review|setup|all]
set -uo pipefail   # no -e: a failed check must not abort the run
REPO="$(cd "$(dirname "$0")/.." && pwd)"
FIX="$REPO/tests/fixtures"
# Run outside the repo: real users work in their own folder, never inside a clone.
OUT="${CHAMBAS_TEST_OUT:-$(mktemp -d "${TMPDIR:-/tmp}/chambas-smoke.XXXXXX")}"
WHICH="${1:-all}"
TOOLS=(Read Write Edit Glob Grep Skill WebFetch WebSearch "Bash(date:*)" "Bash(mkdir:*)" "Bash(ls:*)" "Bash(cp:*)" "Bash(cat:*)")
fail=0
check() { if eval "$2"; then echo "  PASS $1"; else echo "  FAIL $1"; fail=1; fi; }

run() { # dir prompt
  ( cd "$1" && claude -p --plugin-dir "$REPO" --permission-mode acceptEdits \
      --output-format json --allowedTools "${TOOLS[@]}" -- "$2" < /dev/null > "$1/_claude-output.json" 2> "$1/_claude-stderr.txt" ) || true
  python3 -c 'import json,sys; d=json.load(open(sys.argv[1])).get("permission_denials") or []; print("  WARN permission denials: %s" % d) if d else None' "$1/_claude-output.json" 2>/dev/null || true
}

user_folder() { # name -> path of a ready folder
  local d="$OUT/$1"; mkdir -p "$d"/{scans,applications,interviews,practice}
  cp "$FIX/profile-laura.md" "$d/profile.md"; cp "$FIX/cv-laura.md" "$d/cv-master.md"
  printf '# Tracker\n\n| # | Date | Company | Role | Link | Status | Next step | Next date | Notes |\n|---|---|---|---|---|---|---|---|---|\n' > "$d/tracker.md"
  echo "$d"
}

if [[ "$WHICH" == tailor || "$WHICH" == all ]]; then
  echo "== tailor"
  d=$(user_folder tailor); cp "$FIX/job-post-nimbus.md" "$d/job.md"
  run "$d" "/chambas:tailor Tailor my CV for the job in job.md. I have no answers to gap questions and nothing to add: skip the questions, proceed with what's true, and save all files."
  app=$(ls -d "$d"/applications/*/ 2>/dev/null | head -1)
  check "application folder created" '[[ -n "$app" ]]'
  check "cv.md exists"                '[[ -f "$app/cv.md" ]]'
  check "cv.html exists"              '[[ -f "$app/cv.html" ]]'
  check "no unfilled placeholders"    '! grep -q "{{" "$app/cv.html"'
  check "notes.md exists"             '[[ -f "$app/notes.md" ]]'
  # Laura has never used Kubernetes, Kafka or Terraform: the CV must not claim them.
  check "no invented Kubernetes"      '! grep -qi "kubernetes" "$app/cv.md"'
  check "no invented Kafka"           '! grep -qi "kafka" "$app/cv.md"'
  check "no invented Terraform"       '! grep -qi "terraform" "$app/cv.md"'
  check "real metric kept"            'grep -q "0.5%\|0,5 %\|0.5 %\|0,5%" "$app/cv.md"'
  check "Kubernetes flagged as gap"   'grep -qi "kubernetes" "$app/notes.md"'
fi

if [[ "$WHICH" == review || "$WHICH" == all ]]; then
  echo "== interview-review"
  d=$(user_folder review); cp "$FIX/transcript-nimbus-screen.txt" "$d/transcript.txt"
  run "$d" "/chambas:interview-review Review transcript.txt. Company: Nimbus Freight, role: Senior Backend Engineer, round: recruiter screen, I am Laura. Don't ask anything else, save the review."
  rev=$(ls "$d"/interviews/*review*.md 2>/dev/null | head -1)
  check "review saved"                       '[[ -n "$rev" ]]'
  check "flags the layoff answer"            'grep -qiE "despid|layoff|recorte|corrieron|salida" "$rev"'
  check "flags salary answer"                'grep -qiE "salari|sueldo|expectativ" "$rev"'
  check "has a questions-to-ask section"     'grep -iE "^##.*pregunt" "$rev" | grep -viq "por pregunta"'
  check "headings translated to Spanish"     '! grep -qE "^## (Top 3|Question by question|Patterns|Follow-up)" "$rev"'
  check "written in Spanish (profile=es)"    'grep -qiE "entrevista|respuesta" "$rev"'
fi

if [[ "$WHICH" == apply || "$WHICH" == all ]]; then
  echo "== apply (no Chrome: answer sheet)"
  d=$(user_folder apply); app="$d/applications/nimbus-freight-senior-backend-engineer-2026-10-06"
  mkdir -p "$app"; cp "$FIX/job-post-nimbus.md" "$app/job-post.md"; cp "$FIX/cv-laura.md" "$app/cv.md"
  printf '# Notes\nFit 7/10. Gap: Kubernetes.\n' > "$app/notes.md"; printf '%%PDF-1.4 test\n' > "$app/cv.pdf"
  run "$d" "/chambas:apply Prepare my application for the Nimbus Freight job in applications/. Answers to the sensitive questions: I'm authorized to work in Mexico only, I need no sponsorship for remote-from-Mexico, salary: say it's negotiable, start in 2 weeks, prefer not to answer demographic questions. Free-text drafts are approved as you write them. Don't ask anything else; save the answer sheet."
  kit="$app/apply-kit.md"
  check "apply-kit.md written"           '[[ -f "$kit" ]]'
  check "no invented Kubernetes claim"   '! grep -qiE "(experience|experiencia|used|usé|worked) [^.]*kubernetes" "$kit"'
  check "salary kept negotiable"         'grep -qiE "negociable|negotiable" "$kit"'
  check "last salary not leaked"         '! grep -q "62,\?000" "$kit"'
  check "tracker not marked applied yet" '! grep -qi "applied\|aplicad" "$d/tracker.md"'
fi

if [[ "$WHICH" == find || "$WHICH" == all ]]; then
  echo "== find-jobs (live web)"
  d=$(user_folder find)
  run "$d" "/chambas:find-jobs Run the search now and save the scan. Don't ask me anything."
  scan=$(ls "$d"/scans/scan-*.md 2>/dev/null | head -1)
  check "scan saved"                      '[[ -n "$scan" ]]'
  check "has job links"                   'grep -q "https\?://" "$scan"'
  check "every shown job labelled"        'grep -qE "✅|⚠️" "$scan"'
  check "no aggregator marked verified"   '! grep -iE "linkedin\.com|ladders|bebee|indeed\.com" "$scan" | grep -q "✅"'
  check "eligibility tagged"              'grep -qE "OK|Ask|Preguntar|Pregunta" "$scan"'
  check "no shell commands attempted"     'python3 -c "import json,sys;d=json.load(open(sys.argv[1])).get(\"permission_denials\") or [];sys.exit(1 if any(x[\"tool_name\"]==\"Bash\" and \"date\" not in x[\"tool_input\"].get(\"command\",\"\") for x in d) else 0)" "$d/_claude-output.json"'
fi

if [[ "$WHICH" == setup || "$WHICH" == all ]]; then
  echo "== setup"
  d="$OUT/setup"; mkdir -p "$d"; cp "$FIX/cv-laura.md" "$d/mi-cv.md"
  run "$d" "/chambas:setup Español. Mi CV está en mi-cv.md. Respuestas: quiero Backend Developer o Senior Backend Engineer; nivel mid a senior; vivo en Guadalajara, México, autorizada solo en México, solo remoto, no me mudo; ganaba 62000 MXN netos, mínimo 55000; me gusta e-commerce y logística; español nativo, inglés B2; tengo 4 meses de ahorro. No sé más métricas. No me hagas más preguntas: crea todo ya."
  check "profile.md"          '[[ -f "$d/profile.md" ]]'
  check "language es"         'grep -q "language: es" "$d/profile.md"'
  check "cv-master.md"        '[[ -f "$d/cv-master.md" ]]'
  check "cv facts kept"       'grep -q "RabbitMQ" "$d/cv-master.md"'
  check "tracker.md"          '[[ -f "$d/tracker.md" ]]'
  check "CLAUDE.md"           '[[ -f "$d/CLAUDE.md" ]]'
  check "folders"             '[[ -d "$d/applications" && -d "$d/interviews" && -d "$d/scans" && -d "$d/practice" ]]'
  check "no invented Kubernetes" '! grep -qi "kubernetes" "$d/cv-master.md"'
fi

echo "Outputs in $OUT"
exit $fail
