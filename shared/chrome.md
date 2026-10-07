# Using Chrome (optional) — rules for every Chambas skill

Chrome is OPTIONAL. Chambas works without it. With the Claude in Chrome
extension connected, skills can open real career pages (Workday, Phenom,
iCIMS, Greenhouse...) and help fill application forms.

## Is Chrome available?
- Chrome tools are named `mcp__claude-in-chrome__*` (for example `navigate`,
  `get_page_text`, `find`, `form_input`, `file_upload`, `tabs_create_mcp`).
- If they're listed only as deferred tools, load the ones you need with ONE
  ToolSearch call, e.g.
  `select:mcp__claude-in-chrome__tabs_context_mcp,mcp__claude-in-chrome__tabs_create_mcp,mcp__claude-in-chrome__navigate,mcp__claude-in-chrome__get_page_text,mcp__claude-in-chrome__find,mcp__claude-in-chrome__read_page`
  (add `form_input`, `file_upload` and `computer` when filling forms).
- If no such tools exist, Chrome isn't connected. Don't nag. Mention once,
  briefly, that connecting Chrome lets you check more links (see the README),
  and continue without it.

## How to use it politely
- Call `tabs_context_mcp` first. Work in a NEW tab (`tabs_create_mcp`); never
  take over a tab the user already has open.
- Read pages with `get_page_text` or `read_page` before clicking anything.
- One page at a time; don't hammer a site. A few seconds per page is fine.
- Never click anything that triggers a browser alert/confirm dialog; it freezes
  the session.
- If a page needs a login, a CAPTCHA, or a "verify you're human" check: STOP
  on that site, tell the user, and let them do it themselves. Never try to get
  around them.
- If the same action fails 2-3 times, stop and tell the user what happened.
- Close tabs you opened when you're done.

## Hard limits (never break these)
- **Never press a final Submit / Apply / Send button.** The user always does
  that themselves after reviewing.
- Never create accounts, accept terms, or enter passwords for the user.
- LinkedIn and some job sites forbid automated use in their terms. On LinkedIn,
  only read pages the user asks about; never fill or submit Easy Apply forms for
  them. Prefer the company's own careers page.
- Only type information that comes from `profile.md`, `cv-master.md`, the
  tailored CV, or what the user told you in this session.
