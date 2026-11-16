#Requires AutoHotkey v2.0
#SingleInstance Force
; =====================================================================
;  León · tecla para hablar desde cualquier programa (D23)
;
;  Mantén apretada la tecla a la izquierda del 1 (º / |):
;    -> trae la ventana de León al frente y empieza a escuchar.
;  Suéltala:
;    -> León responde.
;
;  Si León NO está abierto, la tecla funciona normal en todos los programas.
;  Para que corra solo al iniciar sesión: poner este archivo (o el .exe
;  compilado) en la carpeta de Inicio  (Windows + R  ->  shell:startup).
; =====================================================================

SetTitleMatchMode 2   ; el título puede contener el texto en cualquier parte

; Ventana de León (app instalada desde Chrome). Se aceptan los dos títulos posibles.
GroupAdd "Leon", "Voz Stock D23 ahk_exe chrome.exe"
GroupAdd "Leon", "León · Stock D23 ahk_exe chrome.exe"

TECLA := "SC029"      ; código físico de la tecla a la izquierda del 1 (sirve en teclados español y latinoamericano)

#HotIf WinExist("ahk_group Leon")
$SC029:: {
    if !WinActive("ahk_group Leon") {
        WinActivate "ahk_group Leon"
        if !WinWaitActive("ahk_group Leon", , 1) {
            ToolTip "No pude traer León al frente"
            SetTimer () => ToolTip(), -2000
            return
        }
        Sleep 100      ; da tiempo a Chrome para tomar el foco del teclado
    }
    Send "{" TECLA " down}"
    KeyWait TECLA      ; espera a que el vendedor suelte la tecla
    Send "{" TECLA " up}"
}
#HotIf
