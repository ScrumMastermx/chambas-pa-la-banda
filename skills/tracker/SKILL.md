---
name: tracker
description: Keeps the user's application tracker up to date and tells them what to do today — follow-ups due, stale applications, weekly progress, and offer comparison/negotiation help. Use when the user says "tracker", "status", "what should I do today", "I applied to", "me rechazaron", "me llamaron", "got an offer", "me ofrecieron", "seguimiento", "pendientes".
---

# Chambas — tracker

Before anything else, read `${CLAUDE_PLUGIN_ROOT}/shared/ground-rules.md`
(the `shared/` folder two levels up from this skill's base directory).

Read `tracker.md` and `profile.md` (missing → `/chambas:setup`). Get today's
date as described in the ground rules.

## What the user wants → what you do

**They report news** ("applied to X", "rejected by Y", "screen with Z Thursday"):
- Update or add the row. Set Status, Next step, Next date. Keep the table valid
  Markdown. Confirm in one line. Log EVERY application, even small ones, right
  away; the tracker only works if it's complete.
- Rejected: one kind line, then: ask if they got feedback; offer to note what
  to try differently. Move on fast.
- Screen/interview booked: suggest `/chambas:coach` for that company and round.

**They ask "what now?" / "status"** — the daily view:
1. **Due today or overdue**: rows whose Next date ≤ today.
2. **Follow-ups**: `applied` with no reply after 7-10 days → draft a 2-3 line
   follow-up. After ~3 weeks with nothing, suggest marking `ghosted` (it's not
   personal; it's normal).
3. **This week**: applications sent, screens, interviews. Compare with last week
   if the data is there. A healthy pace for most people is 5-15 quality
   applications a week; fewer but well-tailored beats spraying.
4. **One recommendation** for today.

**They got an offer:**
- Collect: base, bonus (target % and what it depends on), equity, benefits,
  start date, location/remote, contract type (employee vs contractor), deadline.
- Compute a TOTAL package view, yearly, gross, in their currency. Show net only
  if the user gives the net numbers; never estimate taxes. If gross vs net is
  unclear, ask. If several offers, compare side by side, including
  their previous job from `profile.md`.
- Negotiation (ground rule 7): now is the time. Help them pick ONE clear ask
  (base, sign-on, or start-date/remote), with a short reason, and draft the
  message in plain voice. Remind them the employer expects some negotiation and
  that a polite ask rarely loses an offer, but don't promise outcomes.
- Contractor vs employee: point out what a contractor pays for themselves
  (benefits, taxes, time off). Suggest confirming tax details with an accountant.

Never delete rows. Never change rows the user didn't mention, except to fix
the table format.
