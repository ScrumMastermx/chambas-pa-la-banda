---
name: apply
description: Assisted job application. Opens the application form in Chrome, fills it from the user's profile and tailored CV, uploads the CV PDF and drafts the free-text answers, then STOPS so the user reviews and clicks Submit themselves. Without Chrome, prepares a copy-paste answer sheet. Use when the user says "apply", "help me apply", "fill the application", "aplica", "ayúdame a aplicar", "llena la solicitud".
---

# Chambas — assisted apply

Before anything else, read `${CLAUDE_PLUGIN_ROOT}/shared/ground-rules.md` and
`${CLAUDE_PLUGIN_ROOT}/shared/chrome.md` (the `shared/` folder two levels up
from this skill's base directory). The chrome.md hard limits are absolute here:
**you never press the final Submit.**

## 1. Pick the application
- Use the `applications/<company>-<role>-<date>/` folder the user names, or the
  most recent one. If there's no tailored CV for this job yet, run the tailor
  flow first (`/chambas:tailor`): never apply with an untailored CV unless the
  user explicitly says so.
- Read `profile.md`, `cv-master.md`, and from the folder: `job-post.md`,
  `cv.md`, `notes.md`.
- Find the apply link: from `job-post.md`, or ask for it. If it's a LinkedIn
  Easy Apply, say Chambas doesn't fill LinkedIn forms (their terms forbid it)
  and look for the same role on the company's own careers page.

## 2. The CV as a PDF
Forms need a PDF. Look for a `.pdf` in the application folder.
If there isn't one, ask the user to create it (Chambas can't print to PDF):
"Open `cv.html` from the folder in your browser, press Ctrl+P (Cmd+P on Mac),
Save as PDF, name it `cv.pdf`, and save it in that same folder. Tell me when
it's done." Wait. Use the absolute path of that file for uploading.

## 3. Without Chrome: the answer sheet
If Chrome tools aren't available (see chrome.md), do this instead and stop:
- Fetch the form if you can (WebFetch) to learn its questions; otherwise use
  the usual ones (contact, links, work authorization, sponsorship, salary,
  notice period/start date, relocation, "why this company", "why you").
- Write `apply-kit.md` in the application folder: every field with the answer
  to copy-paste, the sensitive questions answered per step 5 (asking the user
  first), and the free-text answers per step 6.
- Tell the user: open the form, copy each answer, attach `cv.pdf`, review,
  Submit. Then offer to log it in the tracker.

## 4. With Chrome: read the form first
- New tab, open the apply link, read the page. If it needs a login or account,
  or shows a CAPTCHA, stop and let the user handle it, then continue when they
  say so.
- List every field on the current page before typing anything.
- Multi-page forms: you may press **Next / Continue / Save and continue**.
  Never press anything that sends the application (**Submit, Apply, Send,
  Enviar, Postularme, Finish**). If you're not sure what a button does, don't
  press it; ask.

## 5. Sort the fields
**A. Plain facts → fill directly** from `profile.md`/`cv-master.md`: name,
email, phone, city/country, LinkedIn/GitHub/portfolio URLs, current/last
employer and title, education.

**B. Sensitive → ask the user first, all in ONE message**, with a suggested
answer for each:
- Work authorization and visa sponsorship: from `profile.md`
  `work_authorization`. Never guess. A wrong answer here can cost the job later.
- Salary expectations: ground rule 7. Suggest "open/negotiable" or a
  researched range if the field forces a number; never volunteer their last
  salary unless they choose to.
- Start date / notice period, relocation, willingness to travel.
- Voluntary self-identification (gender, ethnicity, disability, veteran
  status): the user's choice only. "Prefer not to say" is always a valid answer.
  Never pick for them.
- Anything legal-sounding (background check consent, non-compete, "I certify
  that..."): show it to the user and let them tick it themselves.

**C. Free text** (cover letter, "why this company", "why you", "tell us about
a project"): draft from `notes.md`, `cv.md` and the job post, plain voice,
ground rules 1 and 3. Show all drafts in ONE message and ask for OK or edits.
Respect each field's character limit.

## 6. Fill
- Fill A, then B with the user's answers, then C after approval.
- Upload `cv.pdf` into the resume/CV field. If there's a separate cover letter
  upload and the user wants one, write `cover-letter.html`, ask them to save it
  as PDF too (same as step 2), then upload it.
- If the form re-parses the CV into fields (common on Workday), check the
  parsed values against the CV and fix mistakes; parsers often scramble dates.
- After each page, read it back to confirm what's actually in the fields.

## 7. Stop and hand over
Stop on the last page, BEFORE Submit. In chat:
- "Everything is filled. Review it in the Chrome tab and click Submit yourself."
- What you filled, any field left blank and why, anything that looked odd.
Save `apply-kit.md` in the application folder with every answer used (handy
for the next application and the interview).

When the user says they submitted: add or update the row in `tracker.md`
(`applied`, today's date, next step "follow up" in 7-10 days). Suggest
`/chambas:coach` if they want to start preparing.
