# Chambas pa la Banda

**English** · [Español](#español)

> **About the name:** in Mexican Spanish, *chamba* means "a job" and *la banda*
> means "the crew, your people". *Chambas pa la banda* is roughly **"jobs for the
> crew"**. It started when a friend was laid off along with a whole team of
> developers, and we wanted something that would help all of them at once, and
> anyone else who needs it.

A free job-hunt kit that runs inside [Claude Code](https://claude.com/claude-code).
It helps you:

| Command | What it does |
|---|---|
| `/chambas:setup` | Asks you a few questions and builds your private job-hunt folder from your current CV. Start here. |
| `/chambas:find-jobs` | Searches the web for jobs that fit you, checks that the links are real and still open, and tells you whether you're eligible from your country. |
| `/chambas:tailor` | Adapts your CV to one specific job, tells you honestly how well you fit, and gives you a ready-to-print PDF and a short note for the recruiter. **It never invents experience.** |
| `/chambas:apply` | Helps you fill the application form: with Chrome connected it fills the fields and attaches your CV, then **stops so you review and click Submit yourself**. Without Chrome it gives you a copy-paste answer sheet. |
| `/chambas:interview-review` | Reads a transcript of a real interview and gives you feedback per question, with better answers built from your own experience. |
| `/chambas:coach` | Practice interviews: it plays the interviewer for the role and round you choose, then tells you what to fix. |
| `/chambas:tracker` | Keeps track of every application, tells you what to follow up on today, and helps you compare and negotiate offers. |

It works in **English and Spanish**. Pick one during setup.

## What you need
- A paid Claude plan that includes Claude Code (Pro, Max, Team or Enterprise).
- The **Claude desktop app** (Mac or Windows) or Claude Code in a terminal.
  It does **not** work on claude.ai in the browser (web sessions can't install plugins).
- Nothing else: no API keys, no coding, nothing else to install.
- **Optional:** the [Claude in Chrome](https://claude.com/chrome) extension (Chrome,
  Edge or another Chromium browser). With it, Chambas can check more job links
  and fill application forms for you to review.

## Install (2 minutes)
**Not technical? Follow the step-by-step guide with explanations:
[docs/GETTING-STARTED.md](docs/GETTING-STARTED.md).**

The short version: create an empty folder (for example `Documents/Chambas`),
open it in Claude Code, and type these two lines in the chat box, one at a time:

```
/plugin marketplace add ScrumMastermx/chambas-pa-la-banda
/plugin install chambas@chambas-pa-la-banda
```

Then type:

```
/chambas:setup
```

## Your data stays yours
- Your CV, salary, tracker and interview notes are saved **only in the folder you
  chose, on your computer**. Nothing is uploaded to this project.
- Like anything you do in Claude Code, your conversation is processed by Claude.
  See Anthropic's privacy policy if you have questions about that.
- Don't run Chambas inside a copy of this repository. Use your own folder.

## Why it never clicks Submit for you
Auto-applying to hundreds of jobs gets filtered as spam, can get your LinkedIn
account banned, and may answer questions like work authorization or salary
wrongly in your name. Chambas does the boring 90% and leaves the final click to you.

## Honest limits
- **Job search sees part of the market, not all of it.** Some company career
  sites can't be read automatically; those links are marked *unverified*, so
  open them yourself before applying.
- **Interviews need text, not audio.** Notes written right after the call work
  well. For a full transcript, ask the interviewer for permission first.
- It's a helper, not a recruiter, lawyer or accountant. Check severance, labor
  rights and taxes with a professional.

## Credits
Built on [COG Second Brain](https://github.com/huytieu/COG-second-brain) by Huy
Tieu (MIT), for the job-search and transcript skills, and on Claude Code by
Anthropic. Full details: [CREDITS.md](CREDITS.md). Not affiliated with Anthropic.

## License
MIT, see [LICENSE](LICENSE). Use it, share it, improve it.

## Contributing
Found a bug, or have an idea that would have helped your job search? Open an
issue. Suggestions in Spanish are welcome.

**Tests** (need a logged-in `claude` CLI; they use a fictional persona):
- `tests/run-smoke.sh [tailor|review|apply|find|setup|all]`: runs the real skills headless and checks the outputs (e.g. the tailored CV must not claim tools the persona never used).
- `tests/chrome/run-chrome-test.sh`: drives your Chrome through `/chambas:apply` on a fake local form; fails if the final Submit is ever pressed.

---

## Español

> **Sobre el nombre:** *Chambas pa la Banda*: chambas para la raza. Nació cuando
> a un amigo lo corrieron junto con todo un equipo de desarrolladores, y quisimos
> algo que les sirviera a todos de una vez, y a quien lo necesite.

Un kit gratuito para buscar trabajo que corre dentro de
[Claude Code](https://claude.com/claude-code). Te ayuda a:

| Comando | Qué hace |
|---|---|
| `/chambas:setup` | Te hace unas preguntas y arma tu carpeta privada de búsqueda a partir de tu CV actual. Empieza aquí. |
| `/chambas:find-jobs` | Busca vacantes que te queden, revisa que los links sean reales y sigan abiertos, y te dice si puedes aplicar desde tu país. |
| `/chambas:tailor` | Adapta tu CV a una vacante específica, te dice con honestidad qué tan bien encajas, y te da un PDF listo y un mensaje corto para el reclutador. **Nunca inventa experiencia.** |
| `/chambas:apply` | Te ayuda a llenar la solicitud: con Chrome conectado llena los campos y adjunta tu CV, y **se detiene para que revises y tú des clic en Enviar**. Sin Chrome te da una hoja de respuestas para copiar y pegar. |
| `/chambas:interview-review` | Lee la transcripción de una entrevista real y te da retroalimentación por pregunta, con mejores respuestas construidas con tu propia experiencia. |
| `/chambas:coach` | Simulacros de entrevista: hace de entrevistador para el puesto y la ronda que elijas, y luego te dice qué mejorar. |
| `/chambas:tracker` | Lleva el control de todas tus aplicaciones, te dice a quién dar seguimiento hoy, y te ayuda a comparar y negociar ofertas. |

Funciona en **español e inglés**. Lo eliges en el setup.

## Qué necesitas
- Un plan de pago de Claude que incluya Claude Code (Pro, Max, Team o Enterprise).
- La **app de escritorio de Claude** (Mac o Windows) o Claude Code en terminal.
  **No** funciona en claude.ai desde el navegador (ahí no se pueden instalar plugins).
- Nada más: ni API keys, ni programar, ni instalar otras cosas.
- **Opcional:** la extensión [Claude in Chrome](https://claude.com/chrome) (Chrome,
  Edge u otro navegador Chromium). Con ella, Chambas revisa más links de vacantes
  y llena solicitudes para que tú las revises.

## Instalación (2 minutos)
**¿No eres técnico? Sigue la guía paso a paso: [docs/GUIA-INICIO.md](docs/GUIA-INICIO.md).**

Versión corta: crea una carpeta vacía (por ejemplo `Documentos/Chambas`), ábrela
en Claude Code y escribe estas dos líneas en el chat, una por una:

```
/plugin marketplace add ScrumMastermx/chambas-pa-la-banda
/plugin install chambas@chambas-pa-la-banda
```

Luego escribe:

```
/chambas:setup
```

## Tus datos son tuyos
- Tu CV, sueldo, tracker y notas de entrevistas se guardan **solo en la carpeta
  que elegiste, en tu computadora**. Nada se sube a este proyecto.
- Como todo lo que haces en Claude Code, tu conversación la procesa Claude.
  Revisa la política de privacidad de Anthropic si tienes dudas.
- No uses Chambas dentro de una copia de este repositorio. Usa tu propia carpeta.

## Por qué nunca da clic en Enviar por ti
Aplicar automáticamente a cientos de vacantes se filtra como spam, puede hacer
que bloqueen tu cuenta de LinkedIn, y puede contestar mal en tu nombre preguntas
como permiso de trabajo o sueldo. Chambas hace el 90% aburrido y el último clic es tuyo.

## Límites honestos
- **La búsqueda ve una parte del mercado, no todo.** Algunos portales de empleo
  de empresas no se pueden leer automáticamente; esos links salen como
  *sin verificar* y tienes que abrirlos tú antes de aplicar.
- **Para entrevistas necesitas texto, no audio.** Tus notas justo después de la
  llamada funcionan bien. Para una transcripción completa, pide permiso primero.
- Es una ayuda, no un reclutador, abogado ni contador. Liquidación, derechos
  laborales e impuestos: confírmalos con un profesional.

## Créditos
Hecho sobre [COG Second Brain](https://github.com/huytieu/COG-second-brain) de Huy
Tieu (MIT), para las skills de búsqueda de empleo y de transcripciones, y sobre
Claude Code de Anthropic. Detalle completo: [CREDITS.md](CREDITS.md). No está
afiliado a Anthropic.

## Licencia
MIT, ver [LICENSE](LICENSE). Úsalo, compártelo, mejóralo.
