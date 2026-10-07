---
name: find-jobs
description: Searches the web for open jobs that match the user's Chambas profile, checks the links, filters by eligibility for the user's country, ranks them and saves a scan report. Use when the user says "find jobs", "job search", "busca chamba", "buscar trabajo", "vacantes", "what's hiring".
---

# Chambas — find jobs

Based on the job-search skill from COG Second Brain by Huy Tieu (MIT).
See CREDITS.md.

Before anything else, read `${CLAUDE_PLUGIN_ROOT}/shared/ground-rules.md`
(the `shared/` folder two levels up from this skill's base directory). Rules 4 and 5 matter most here.

## Pre-flight (no questions unless something is missing)
1. Read `profile.md` and `cv-master.md` from the current folder. If `profile.md`
   is missing, tell the user to run `/chambas:setup` and stop.
2. If the user gave extra direction in their message ("only remote", "solo en
   Monterrey", "fintech"), apply it on top of the profile for this run only.
3. Get today's date as described in the ground rules.
4. Read the 2-3 most recent files in `scans/` (if any) and `tracker.md`.
   Company + role is the dedup key. Don't re-surface jobs already in the tracker.

## 1. Build searches
Write 8-12 WebSearch queries from the profile. Mix:
- title + location: `"<title>" remote <country>`, `"<title>" <city>`
- title + industry: `"<title>" <industry> hiring`
- watched companies: `<company> careers <title>`
- boards (pick the ones that fit the user's country and field):
  `site:linkedin.com/jobs`, `site:wellfound.com`, `site:weworkremotely.com`,
  `site:remoteok.com`, `site:getonbrd.com` (LATAM tech),
  `site:occ.com.mx` / `site:computrabajo.com` (Mexico/LATAM),
  `site:boards.greenhouse.io`, `site:jobs.lever.co`, `site:jobs.ashbyhq.com`
  (these three are company-owned ATS pages, the best sources)
- Use the user's language for local boards and English for international ones.
Vary queries between runs.

If the Agent tool is available, you may run query groups in parallel subagents;
otherwise run them yourself. Either way, keep going without asking the user.

## 2. Collect
For each result, capture: company, title, location/remote rule, link, source,
salary if shown, posting date if shown.
Skip companies in `companies_exclude`.

## 3. Verify (the step that makes this worth using)
For each candidate you plan to show (aim for the best 10-20):
- Prefer the company's own careers/ATS page over aggregators; if you found it on
  an aggregator, search for the same role on the company site.
- Try WebFetch first (fast). If the page is empty or JavaScript-only (Workday,
  Phenom, iCIMS, SuccessFactors...), and Chrome is available, open it in Chrome
  and read it there. Follow `${CLAUDE_PLUGIN_ROOT}/shared/chrome.md` (the
  `shared/` folder two levels up from this skill's base directory).
- On careers sites that show a job page AND an Apply button, the Apply flow is
  the real signal: a job page can say "no longer available" while the apply
  link still works, and the other way around. With Chrome, check the Apply
  button leads to an open form (open it, read it, don't fill anything).
- Mark:
  - **✅ verified**: you opened the company's OWN careers/ATS page for this role
    in this session (WebFetch or Chrome) and it shows the role as open. An
    aggregator page never counts as verified, even if it loads.
  - **⚠️ unverified** — couldn't open it (JavaScript-only and no Chrome, login
    wall, CAPTCHA). Say "open it yourself to confirm".
  - Drop it if the page says closed / no longer available, or it's an aggregator
    page older than ~60 days with no company-site match.
- Never mark something verified that you did not open in this session.

## 4. Eligibility
Tag each job for the user's location and work authorization:
- **OK** — clearly open to them (their country, or worldwide/LATAM explicitly)
- **No** — requires authorization they don't have. Drop it unless it's a
  standout, then show it under "Not eligible, FYI".
- **Ask** — unclear. Give a one-line question to send the recruiter.

## 5. Rank
Sort into:
- **Strong match** — title, seniority, skills and location fit.
- **Stretch** — one step up, or adjacent field where the CV transfers.
- **Worth a look** — unusual but plausibly great.
Inside each tier, order by: eligibility OK first, then verified, then fit.
For each job write 1-2 lines of "why it fits" that point at real lines of the CV.
Call out traps plainly (PMO seat disguised as tech lead, title inflation,
hard domain gate) per ground rule 5.

## 6. Save and report
Save `scans/scan-YYYY-MM-DD.md` (add `-2`, `-3` if it exists):

```markdown
---
date: YYYY-MM-DD
found: N
new: N
verified: N
---
# Job scan — YYYY-MM-DD

## Strong match
### <Company> — <Title>
- Where: <remote rule / city> · Eligible: OK|Ask (<question>)
- Link: <url> · ✅ verified | ⚠️ unverified
- Pay: <if listed, else "not listed">
- Why: <1-2 lines tied to the CV>
- Watch out: <only if there's a trap>

## Stretch
## Worth a look
## Not eligible, FYI
## Searches I ran
<the queries, so the user can rerun them by hand>
```

Then in chat (short):
- "Found N, M new, K verified. Saved to scans/…"
- The top 3 with one line each.
- Next step: "Want me to tailor your CV for #1? Paste or say the number and run
  `/chambas:tailor`." Offer to add any to the tracker as `saved`.

Be honest if results are thin: say which searches came up empty and suggest
widening titles, location or seniority.
