---
name: tailor
description: Tailors the user's CV to one specific job post without inventing anything — fit score, gaps, a tailored CV ready to save as PDF, and a short note to the recruiter. Use when the user pastes a job post or link and says "tailor", "adapt my CV", "adapta mi CV", "ajusta mi currículum", "should I apply", "me conviene".
---

# Chambas — tailor CV to a job

Before anything else, read `${CLAUDE_PLUGIN_ROOT}/shared/ground-rules.md`
(the `shared/` folder two levels up from this skill's base directory). Rule 1 (never invent) is absolute here.

## Inputs
1. `cv-master.md` and `profile.md` from the current folder. Missing → tell the
   user to run `/chambas:setup` and stop.
2. The job post: pasted text, a file, a link, or a number from the latest
   `scans/` file. For a link, try WebFetch; if it fails (JS-only page), ask the
   user to paste the text. Never tailor from a job title alone.

## 1. Read the job honestly
Extract: real title and level, must-haves, nice-to-haves, location/eligibility
rule, salary if listed, and what the job ACTUALLY is (ground rule 5: read the
noun, check title inflation, spot hard domain gates).

## 2. Fit check (show this first, before writing anything long)
In chat:
- **Fit: X/10** with one sentence why.
- **You have:** 3-6 must-haves, each pointing to the real CV line that proves it.
- **Gaps:** must-haves the CV doesn't show. For each: is it truly missing, or
  likely something they did but didn't write down? Ask about the second kind.
- **Blockers:** eligibility, hard domain gate, level mismatch. Be direct.
- **Recommendation:** apply / apply after answering my questions / skip, and why.
  If it's a cold application, say light effort is fine (ground rule 6).

If you asked gap questions, wait for answers. Add ONLY what the user confirms.
If the user says "skip it, just do it", proceed with what's true.

## 3. Tailor
Start from `cv-master.md` (never from a previous tailored version) and:
- **Headline + Summary**: rewrite for this job, using the job's own words where
  they are TRUE of the user. This is where most of the tailoring happens.
- **Order**: lead each role with the bullets most relevant to this job.
- **Cut**: drop bullets and older roles that don't help; aim for 1-2 pages
  (up to 3 for very senior people). Never cut leadership of people/teams just
  because the role is hands-on: "led the team AND built it" beats "solo builder".
- **Wording**: mirror the job's terms only where they truthfully describe the
  same thing (e.g. CV says "AWS Lambda", job says "serverless" → ok to say
  "serverless (AWS Lambda)").
- **Numbers**: keep deltas and percentages ("cut response time 40%"). Raw
  volumes that look tiny to a big company can hurt; ask before keeping them.
  Never create a number.
- **Skills**: list only skills in `cv-master.md`, ordered by relevance.
- **Language**: CV in the job post's language unless the user says otherwise.

Every bullet in the output must map to something in `cv-master.md` or a fact
the user confirmed in this session. Before saving, re-check each bullet against
the source. If any bullet can't be traced, remove it.

## 4. Save
Folder: `applications/<company>-<role>-YYYY-MM-DD/` (lowercase, hyphens; today's date). Write:
- `job-post.md` — the job text and link.
- `cv.md` — the tailored CV in Markdown.
- `cv.html` — the same CV filled into `${CLAUDE_SKILL_DIR}/assets/cv-template.html`
  (the `assets/` folder inside this skill's base directory). Replace every `{{...}}` placeholder; repeat the role
  block per role; translate section labels to the CV's language; set
  `{{PRINT_TIP}}` to: EN "Open this file in your browser, press Ctrl+P (Cmd+P on
  Mac), choose Save as PDF, and turn off headers and footers." / ES "Abre este
  archivo en tu navegador, presiona Ctrl+P (Cmd+P en Mac), elige Guardar como PDF
  y desactiva encabezados y pies de página." Escape `&`, `<`, `>` in text.
  Leave no `{{` in the final file.
- `notes.md` — fit score, gaps, the questions you asked and the answers, and a
  short message to the recruiter or hiring manager (3-5 lines, plain voice,
  ground rule 3), plus a 1-line cover note if the form asks for one.

## 5. Close
In chat:
- What changed vs the master (3-5 bullets).
- How to get the PDF (the print tip).
- Offer: "Add it to your tracker as applied once you send it?" If yes, append a
  row to `tracker.md`.
- If a human is engaged (screen booked, recruiter reached out), suggest
  `/chambas:coach` to practice for this exact job.
