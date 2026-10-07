---
name: interview-review
description: Reviews a real interview transcript (Zoom, Meet, Teams, phone voice memo, or notes from memory) and gives specific feedback per question with better answers built only from the user's real experience. Use when the user shares a transcript or says "review my interview", "how did I do", "revisa mi entrevista", "cómo me fue", "feedback de entrevista".
---

# Chambas — interview review

The transcript-processing approach is inspired by the meeting-transcript skill
from COG Second Brain by Huy Tieu (MIT). See CREDITS.md.

Before anything else, read `${CLAUDE_PLUGIN_ROOT}/shared/ground-rules.md`
(the `shared/` folder two levels up from this skill's base directory).

## Inputs
1. The transcript: a file in the folder (TXT, VTT, SRT, PDF, MD) or pasted
   text. Word files: ask them to save as PDF or paste the text. Audio/video
   can't be processed. If they have no transcript, the easiest path is notes
   from memory: right after the call, write down each question and roughly what
   they answered. That works well. If they want to record future interviews:
   ASK THE INTERVIEWER FIRST ("Do you mind if I record so I can take notes?").
   Interviewees usually can't turn on Zoom/Meet/Teams transcripts themselves;
   the host can share them. Never suggest recording anyone without consent.
2. `cv-master.md` and `profile.md` (missing → `/chambas:setup`).
3. Ask, in one message, only what you can't infer: company, role, round
   (recruiter screen / technical / hiring manager / panel / final), and which
   speaker is the user if the transcript doesn't say.
   If there's an `applications/<company>-…/` folder, read its `job-post.md`.

## 1. Clean up
- Identify speakers. Transcripts mislabel people; fix obvious errors.
- Split into question → answer pairs. Ignore small talk except the opening and
  closing (they count).
- Don't "fix" what the user said. Quote it.

## 2. Score each answer
For each question, rate 1-5 on:
- **Answered the question** (did they answer what was asked?)
- **Specific** (a real example, their own role, a result; STAR shape for
  behavioral questions: situation, task, action, result)
- **Concise** (stopped when done; under ~2 minutes for most answers)
- **Relevant to the job** (connected to what this role needs)
For technical questions, also: **correct** and **reasoning shown out loud**.
Flag only what matters: one strength, one fix per answer.

## 3. Better answer, from their real life
For the 3-5 weakest answers, write an improved version:
- Built ONLY from facts in the transcript, `cv-master.md`, or `profile.md`.
- If a great answer needs a story you don't have, don't invent one. Write the
  structure and ask: "Do you have an example where you…? Tell me and I'll shape it."
- Plain spoken language, as they'd actually say it. 60-150 words.

## 4. Patterns and signals
- Recurring habits (filler, rambling, underselling, "we" with no "I",
  badmouthing a past employer, apologizing).
- Questions they asked the interviewer (or didn't). Suggest 2-3 strong ones.
- How they handled the layoff question, if it came up. A good answer is short,
  factual and forward-looking ("My role was cut in a company-wide layoff. Here's
  what I'm looking for next…"). No bitterness, no over-explaining.
- Interviewer signals in the transcript (interest, concerns, next steps
  mentioned). Label these as reads, not facts.
- Salary: if it came up early, check the answer against ground rule 7.

## 5. Save and report
Save `interviews/<company>-<round>-YYYY-MM-DD-review.md` (today's date; see ground rules); also save the transcript next to it as `…-transcript.md` if
it was pasted.

Structure:
```markdown
# Interview review — <Company>, <Role>, <Round> (YYYY-MM-DD)
## Overall: X/10 — one sentence
## Top 3 strengths
## Top 3 fixes before the next round
## Question by question
### Q1: "<question>"
- Scores: answered x/5 · specific x/5 · concise x/5 · relevant x/5
- Worked: …
- Fix: …
- Better answer: … (only for the weakest ones)
## Patterns
## Questions to ask next time
## Interviewer signals (my read)
## Follow-up
<thank-you note draft, 3-5 lines, plain voice, mentions one specific thing from the conversation>
```

In chat: overall score, top 3 fixes, and "want to practice the weak ones?
Run `/chambas:coach`." Offer to update the tracker row (status + next step).
