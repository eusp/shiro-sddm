# Shiro-SDDM

Tema de SDDM (Qt 6) del escritorio Shiro. Es un fork simplificado de
[SilentSDDM](https://github.com/uiriansan/SilentSDDM): se quitó el sistema de
configuración por archivos `.conf`, los idiomas y el selector de layout, y los
valores quedaron fijos en el código.

Proyectos Shiro: [shiro-theme](https://github.com/eusp/shiro-theme) ·
[shiro-ags](https://github.com/eusp/shiro-ags) ·
[shiro-hyprland](https://github.com/eusp/shiro-hyprland) ·
**shiro-sddm** ·
[shiro-grub](https://github.com/eusp/shiro-grub) ·
[shiro-limine](https://github.com/eusp/shiro-limine)

Los colores (`components/Colors.qml`) y el fondo (`backgrounds/background.mp4`
y `background.png`) los genera [shiro-theme](https://github.com/eusp/shiro-theme)
con `builders/sddm.js`, así que no conviene editarlos a mano.

## Estructura

```
Main.qml                  Punto de entrada: fondo (video/imagen), blur y transición lock → login
components/
  Colors.qml              Paleta (generada por shiro-theme)
  LockScreen.qml          Reloj y fecha
  LoginScreen.qml         Avatar, contraseña y botón de login
  MenuArea.qml            Botones de sesión, apagado y teclado virtual
  SessionSelector.qml     Popup de sesiones
  PowerMenu.qml           Popup de suspender / reiniciar / apagar
  UserSelector.qml        Lista de usuarios
  VirtualKeyboard.qml     Teclado en pantalla (QtQuick.VirtualKeyboard)
  Avatar.qml, IconButton.qml, Input.qml, Spinner.qml
backgrounds/              Fondo actual y default.jpg de respaldo
icons/                    Iconos SVG (icons/sessions/ se elige por nombre de sesión)
fonts/                    Red Hat Display (install.sh las copia a /usr/share/fonts)
```

## Instalación

Lo normal es instalarlo desde shiro-theme (`install.sh`), que clona este repo directamente en
`/usr/share/sddm/themes/shiro-sddm` y lo deja a nombre del usuario para que el builder pueda
actualizar colores y fondo sin root. A mano:

```sh
./install.sh
```

Instala dependencias, copia el tema a `/usr/share/sddm/themes/shiro-sddm/`,
instala las fuentes y escribe `/etc/sddm.conf.d/shiro-sddm.conf`.

## Probar

```sh
./test.sh          # abre el greeter en modo prueba
./test.sh --debug  # igual, mostrando los logs
```

## Otros scripts

- `change_avatar.sh <usuario> <imagen>` — recorta y copia el avatar a `/usr/share/sddm/faces/` (requiere ImageMagick).
- `backgrounds/extract_first_frame.sh <video>` — saca un frame del video para usarlo como `background.png`.

## Licencia

GPL-3.0-or-later, igual que el proyecto original. Ver [LICENSE](LICENSE).
Las fuentes Red Hat usan la licencia OFL ([fonts/OFL.txt](fonts/OFL.txt)).
