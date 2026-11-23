# 🎬 EDOCENTIA EN VÍDEO · IA para Docentes

**Curso de Inteligencia Artificial para docentes**  
Formación práctica con videotutoriales y espacio de pruebas en Aules.

✨ **Materiales creados por Ana H. Iranzo**

---

## 🌐 Ver la Web en Vivo

Puedes acceder a la plataforma web directamente a través de GitHub Pages:  
👉 **[https://curiousminds123.github.io/AULAFLIX-/](https://curiousminds123.github.io/AULAFLIX-/)**

O incrustada en tu curso de Aules (Moodle) mediante iframe.

---

## 🔒 Contraseña de Administración

Para proteger los enlaces y evitar modificaciones accidentales o por parte del alumnado en Aules, la edición de enlaces está protegida por contraseña:

🔑 **Contraseña:** `1234`

---

## 📚 Estructura de Contenidos

El curso se compone de **4 temporadas** y **24 episodios**:

1. **Temporada 1: Fundamentos de IA y uso responsable** (Episodios 1 al 6)
   - *Episodio 6:* **Reglas del juego: ética de la IA en clase** (`https://youtu.be/UWp1jk_GTFk`)
2. **Temporada 2: Herramientas de IA para crear materiales** (Episodios 7 al 12)
   - *Episodio 12:* **NotebookLM: tus apuntes hechos podcast** (`https://youtu.be/xxamZXiNTuU`)
3. **Temporada 3: Recursos interactivos con vibe coding** (Episodios 13 al 18)
   - *Episodio 13:* **Apps en minutos: vibe coding sin programar** (`https://youtube.com/shorts/igV3GowwOdc`)
4. **Temporada 4: Inteligencia artificial y Aules** (Episodios 19 al 24)
   - *Episodio 24:* **Evaluación con IA: evaluar mejor en menos tiempo** (`https://youtu.be/HVgvkiFPsgc`)

---

## ⚡ Modificar automáticamente el `index.html` del repositorio de GitHub

Los vídeos de YouTube (incluidos enlaces `youtu.be`, Shorts y enlaces normales) y Vimeo se reproducen **en un popup dentro de la misma página**, sin abrir otra pestaña.

### Desde la propia Web
1. Pulsa **"⚙️ Gestionar enlaces"** o abre la ficha de un episodio e introduce la contraseña docente.
2. La primera vez, introduce un Personal Access Token de GitHub con permiso de escritura solo para el contenido de este repositorio. El token se conserva en la sesión de la pestaña y desaparece al cerrarla; no lo compartas ni lo guardes en un equipo público.
3. Pulsa **"Reproducir vídeo aquí"** para abrir el reproductor emergente. Al guardar un enlace individual, procesar una lista o guardar el gestor, se actualiza `index.html` directamente en [Curiousminds123/AULAFLIX-](https://github.com/Curiousminds123/AULAFLIX-). GitHub Pages publica el cambio automáticamente.

Si GitHub no está disponible o el token no tiene permisos, los enlaces permanecen guardados en el navegador y la página mostrará el error; puedes volver a intentar la sincronización o descargar `index.html`.

### Actualización desde PowerShell
1. Edita `Lista de videos para el catalogo de AULAXLIX.txt`.
2. Ejecuta:
   ```powershell
   .\actualizar_enlaces.ps1
   ```
3. Introduce la contraseña y elige la opción 1 o 2. El script actualiza `index.html` y hace `git commit` y `git push`.

---

## 👤 Créditos y Autoría

- **Autora:** Ana H. Iranzo
- **Repositorio:** [Curiousminds123/AULAFLIX-](https://github.com/Curiousminds123/AULAFLIX-)
