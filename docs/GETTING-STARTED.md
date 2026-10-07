# Getting started (no technical experience needed)

[Español](GUIA-INICIO.md)

This takes about 10 minutes, including your first setup conversation.

## 1. Get Claude with Claude Code
1. Sign up at [claude.ai](https://claude.ai) and choose a paid plan that
   includes Claude Code (Pro is enough to start).
2. Download the **Claude desktop app** for Mac or Windows from
   [claude.com/download](https://claude.com/download) and sign in.
3. In the app, open the **Code** tab. That's Claude Code.
4. On Windows, also install [Git for Windows](https://git-scm.com/download/win)
   (just click Next through the installer). Claude Code uses it to run small commands.

> Using a terminal already? You can also install Claude Code from
> [claude.com/claude-code](https://claude.com/claude-code) and run `claude`
> inside your folder. The steps below are the same.

## 2. Make your job-hunt folder
1. Create a new, empty folder, for example **Documents → Chambas**.
2. Put your current CV inside it if you have one, as **PDF** or text. (Word file?
   Open it and use File → Save As → PDF first.)
   No CV? That's ok; Claude will build one with you.
3. In the Code tab, choose **that folder** as the folder to work in.

Why a separate folder: everything Chambas writes (your profile, tailored CVs,
interview notes) goes there, and only there.

## 3. Install Chambas
In the chat box, type this line and press Enter:

```
/plugin marketplace add ScrumMastermx/chambas-pa-la-banda
```

Then this one:

```
/plugin install chambas@chambas-pa-la-banda
```

If Claude asks you to confirm or trust the plugin, say yes. If the commands
don't seem to work, look for **Plugins** in the app's menu (the **+** button
next to the chat box) and add `ScrumMastermx/chambas-pa-la-banda` from there.

You may need to start a new session (or restart the app) after installing.

## 4. Run setup
Type:

```
/chambas:setup
```

Claude will ask whether you want English or Spanish, read your CV, and ask you
a few questions, one at a time. Answer naturally; "skip" is always fine.

When it asks permission to create or edit files in your folder, say yes. That's
how it saves your profile and CV. You can choose "allow for this session" so it
doesn't ask every time.

## 5. Everyday use
You don't need to remember commands; you can just say what you want
("find me jobs", "help me with this job post", "how did my interview go?").
The commands are there if you want them:

- `/chambas:find-jobs`: find jobs that fit you
- `/chambas:tailor`: paste a job post and get a tailored CV + PDF
- `/chambas:apply`: fill an application form (you click Submit)
- `/chambas:interview-review`: drop in an interview transcript and get feedback
- `/chambas:coach`: practice an interview
- `/chambas:tracker`: "what should I do today?", "I applied to X", "I got an offer"

**Getting the PDF of your CV:** open the `cv.html` file it creates (in the
`applications` folder) in your browser, press **Ctrl+P** (**Cmd+P** on Mac),
choose **Save as PDF**, and turn off "headers and footers".

**Getting an interview transcript:**
- Easiest: right after the call, write down each question and roughly what you
  answered. That's enough for a good review.
- Want a full transcript? **Ask the interviewer first** ("Do you mind if I record
  so I can take notes?"). As a candidate you usually can't turn on Zoom, Meet or
  Teams transcripts yourself, but the interviewer can share one.
- Never record anyone without their permission.

## Optional: connect Chrome
Lets Chambas open job pages that need a real browser, and fill application
forms (it always stops before Submit).
1. Install the **Claude in Chrome** extension from [claude.com/chrome](https://claude.com/chrome)
   in Chrome (or Edge) and sign in with the same Claude account.
2. In Claude Code, type `/chrome` and follow the steps to connect it.
3. When Chambas wants to open a page, Chrome may ask you to allow the site.

To apply: run `/chambas:apply` after `/chambas:tailor`. It will ask you to save
your CV as `cv.pdf` in the job's folder first.

## Updating
Type `/plugin`, go to **Installed**, pick **chambas** and choose **Update**.

## Something not working?
- "Unknown command /chambas:setup": the plugin isn't installed yet, or you need
  a new session. Repeat step 3.
- It's answering in the wrong language: tell it "answer in Spanish" (or English).
- Still stuck: open an issue at
  https://github.com/ScrumMastermx/chambas-pa-la-banda/issues
