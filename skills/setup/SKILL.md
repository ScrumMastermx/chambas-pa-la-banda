---
name: setup
description: First-time setup for Chambas. Interviews the user (in English or Spanish) and creates their private job-hunt folder with profile, master CV and tracker. Use when the user says "setup", "start", "empezar", "configurar", "I just got laid off", "me corrieron", "me despidieron", or when any other Chambas skill finds no profile.md.
---

# Chambas — setup

Before anything else, read `${CLAUDE_PLUGIN_ROOT}/shared/ground-rules.md`
(the `shared/` folder two levels up from this skill's base directory). Follow it for the whole session.

## Goal
Leave the user with a working folder:
`profile.md`, `cv-master.md`, `tracker.md`, `CLAUDE.md`, and empty `scans/`,
`applications/`, `interviews/`, `practice/` folders. Then tell them what to do next.

This user may not be technical. Ask one thing at a time, in plain words.
Never show them a wall of questions.

## Step 0 — Language and folder
1. Greet in BOTH languages, one line each, and ask which one they prefer:
   "Hi! I'll help you find your next job. English or Spanish?" /
   "¡Hola! Te ayudo a encontrar tu siguiente chamba. ¿Inglés o español?"
   From here on, use only the chosen language.
2. Check the current working directory:
   - If it already has `profile.md`, say setup was done before and ask whether
     they want to update the profile or start over. Never overwrite without a yes.
   - If the folder looks like a code project or contains unrelated files (e.g.
     `package.json`, `.git`, `src/`), warn them: this kit works best in its own
     empty folder. Explain how: create a folder named `Chambas` in Documents and
     open that folder in Claude Code. Stop and let them do it.
   - Otherwise, continue here.

## Step 1 — Their CV (the source of truth)
Ask for their current CV. Accept any of:
- a file in the folder (PDF, TXT, MD): read it. A Word file: ask them to
  save it as PDF (File → Save as → PDF) or paste the text;
- pasted text;
- nothing yet: then build it with them by asking role by role
  (company, title, dates, 2-4 things they did, any numbers they know).

Write `cv-master.md` in clean Markdown with this order:
name, one-line headline, location, contact line; Summary; Experience
(newest first, `### Title · Company` then `*City · Mon YYYY – Mon YYYY*` then bullets);
Skills; Education; Languages; optional Certifications/Projects.

Rules for this step:
- Keep their facts exactly. Fix spelling and formatting only.
- Where a bullet is vague ("worked on backend"), DON'T rewrite it into something
  bigger. Mark it with `<!-- ask: what was the result? -->` and collect up to
  5 such questions to ask at the end of setup.
- Keep `cv-master.md` long and complete. Tailoring cuts it down later; it never adds.

## Step 2 — Profile
Ask briefly (skip anything the CV already answers):
1. What role do you want next? (titles, 1-3)
2. Seniority you're aiming for, and are you open to one level up or down?
3. Where can you work? Country/city, remote/hybrid/onsite, willing to relocate?
   Work authorization (e.g. citizen of X, needs visa for Y).
4. Salary: what were you making, and what's your minimum? (They can skip.)
   Currency and gross/net.
5. Industries you like or want to avoid. Companies you'd love to work for.
6. Languages and level.
7. Anything that makes the search urgent (savings runway, severance, notice).
   Only ask this gently and accept "skip".

Write `profile.md`:

```markdown
---
language: es            # or en
name: ""
location: ""            # city, country
work_authorization: ""  # where they can legally work
remote: "remote | hybrid | onsite | any"
relocate: false
target_titles: []
seniority: ""
industries_like: []
industries_avoid: []
companies_watch: []
companies_exclude: []
salary_currency: ""
salary_min: ""          # leave empty if skipped
salary_last: ""
salary_basis: "gross | net"
languages: []
created: "YYYY-MM-DD"
---

# Profile
## What I want next
## Strengths (from the CV, in my words)
## Constraints and notes
```

Get today's date as described in the ground rules.

## Step 3 — Tracker and folder files
Create `tracker.md`:

```markdown
# Tracker

| # | Date | Company | Role | Link | Status | Next step | Next date | Notes |
|---|------|---------|------|------|--------|-----------|-----------|-------|

Status values: saved · applied · screen · interview · offer · rejected · withdrawn · ghosted
```

Create the empty folders `scans/`, `applications/`, `interviews/`, `practice/`
(put a `.gitkeep` in each).

Create `CLAUDE.md` in the folder so every future session remembers:

```markdown
# My job hunt (Chambas)
- Language: <en|es>. Always answer me in it.
- My facts live in cv-master.md and profile.md. Never invent experience.
- Tracker: tracker.md. Log every application there.
- Commands: /chambas:find-jobs · /chambas:tailor · /chambas:apply · /chambas:interview-review · /chambas:coach · /chambas:tracker
```

## Step 4 — Close
1. Ask the collected `<!-- ask: -->` questions (max 5). Update `cv-master.md`
   with real answers only; delete the marker if they don't know.
2. Summarize in 3-5 lines what you set up.
3. Tell them the next step, in this order of usefulness:
   - "Paste a job post you like and run `/chambas:tailor`" (if they have one), or
   - "Run `/chambas:find-jobs` and I'll look for roles that fit you."
   - "Got an interview coming? `/chambas:coach` lets you practice."
4. One warm, short line. No speeches.
