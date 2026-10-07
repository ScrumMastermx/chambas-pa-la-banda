# Guía de inicio (sin experiencia técnica)

[English](GETTING-STARTED.md)

Toma unos 10 minutos, incluyendo tu primera conversación de configuración.

## 1. Consigue Claude con Claude Code
1. Regístrate en [claude.ai](https://claude.ai) y elige un plan de pago que
   incluya Claude Code (con Pro alcanza para empezar).
2. Descarga la **app de escritorio de Claude** para Mac o Windows desde
   [claude.com/download](https://claude.com/download) e inicia sesión.
3. En la app, abre la pestaña **Code**. Eso es Claude Code.
4. En Windows, instala también [Git for Windows](https://git-scm.com/download/win)
   (solo dale Siguiente en el instalador). Claude Code lo usa para correr comandos pequeños.

> ¿Ya usas terminal? También puedes instalar Claude Code desde
> [claude.com/claude-code](https://claude.com/claude-code) y correr `claude`
> dentro de tu carpeta. Los pasos son los mismos.

## 2. Crea tu carpeta de búsqueda
1. Crea una carpeta nueva y vacía, por ejemplo **Documentos → Chambas**.
2. Si tienes tu CV, ponlo adentro en **PDF** o texto. (¿Lo tienes en Word?
   Ábrelo y usa Archivo → Guardar como → PDF primero.)
   ¿No tienes CV? No pasa nada; Claude lo arma contigo.
3. En la pestaña Code, elige **esa carpeta** como carpeta de trabajo.

¿Por qué una carpeta aparte? Todo lo que Chambas escribe (tu perfil, CVs
adaptados, notas de entrevistas) se guarda ahí, y solo ahí.

## 3. Instala Chambas
En el chat, escribe esta línea y presiona Enter:

```
/plugin marketplace add ScrumMastermx/chambas-pa-la-banda
```

Luego esta:

```
/plugin install chambas@chambas-pa-la-banda
```

Si Claude te pide confirmar o confiar en el plugin, di que sí. Si los comandos
no funcionan, busca **Plugins** en el menú de la app (el botón **+** junto al
chat) y agrega `ScrumMastermx/chambas-pa-la-banda` desde ahí.

Puede que necesites abrir una sesión nueva (o reiniciar la app) después de instalar.

## 4. Corre el setup
Escribe:

```
/chambas:setup
```

Claude te preguntará si prefieres español o inglés, leerá tu CV y te hará unas
preguntas, una por una. Contesta con naturalidad; "sáltala" siempre se vale.

Cuando te pida permiso para crear o editar archivos en tu carpeta, di que sí: así
guarda tu perfil y tu CV. Puedes elegir "permitir en esta sesión" para que no te
pregunte cada vez.

## 5. Uso diario
No necesitas memorizar comandos; puedes decir lo que quieres ("búscame chamba",
"ayúdame con esta vacante", "¿cómo me fue en la entrevista?").
Los comandos están por si los quieres:

- `/chambas:find-jobs`: busca vacantes que te queden
- `/chambas:tailor`: pega una vacante y recibe tu CV adaptado + PDF
- `/chambas:apply`: llena una solicitud (tú das clic en Enviar)
- `/chambas:interview-review`: pasa la transcripción de una entrevista y recibe retroalimentación
- `/chambas:coach`: practica una entrevista
- `/chambas:tracker`: "¿qué hago hoy?", "apliqué a X", "me ofrecieron"

**Para sacar el PDF de tu CV:** abre en tu navegador el archivo `cv.html` que
crea (en la carpeta `applications`), presiona **Ctrl+P** (**Cmd+P** en Mac),
elige **Guardar como PDF** y desactiva "encabezados y pies de página".

**Para conseguir la transcripción de una entrevista:**
- Lo más fácil: justo después de la llamada, apunta cada pregunta y más o menos
  lo que contestaste. Con eso basta para una buena revisión.
- ¿Quieres la transcripción completa? **Pide permiso primero** ("¿Le molesta si
  grabo para tomar notas?"). Como candidato normalmente no puedes activar la
  transcripción de Zoom, Meet o Teams, pero quien te entrevista sí puede compartirla.
- Nunca grabes a nadie sin su permiso.

## Opcional: conecta Chrome
Permite que Chambas abra páginas de vacantes que necesitan un navegador real y
llene solicitudes (siempre se detiene antes de Enviar).
1. Instala la extensión **Claude in Chrome** desde [claude.com/chrome](https://claude.com/chrome)
   en Chrome (o Edge) e inicia sesión con la misma cuenta de Claude.
2. En Claude Code, escribe `/chrome` y sigue los pasos para conectarla.
3. Cuando Chambas quiera abrir una página, Chrome puede pedirte permiso para ese sitio.

Para aplicar: corre `/chambas:apply` después de `/chambas:tailor`. Te pedirá
guardar tu CV como `cv.pdf` en la carpeta de la vacante primero.

## Actualizar
Escribe `/plugin`, ve a **Installed**, elige **chambas** y dale **Update**.

## ¿Algo no funciona?
- "Unknown command /chambas:setup": el plugin aún no está instalado o necesitas
  una sesión nueva. Repite el paso 3.
- Te contesta en el idioma equivocado: dile "contéstame en español".
- ¿Sigues atorado? Abre un issue en
  https://github.com/ScrumMastermx/chambas-pa-la-banda/issues
