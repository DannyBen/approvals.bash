; --------------------------------------------------
; This script generates the demo svg
; --------------------------------------------------
#SingleInstance Force
SetkeyDelay 0, 50

; NOTE: This should be executed in the demo folder

Outfile := "cast.svg"
Template := "window_frame"

Return

Type(Command, Delay=2000) {
  Send % Command
  Sleep 500
  Send {Enter}
  Sleep Delay
}

F12::
  Type("cd demo")
  Type("rm new-file {;} mkdir approvals {;} rm -rf test.sh {;} rm -rf approvals/*")
  Type("rm -rf cast.json {;} asciinema rec cast.json", 4000)

  Type("vi test.sh")
  Type("i{#}{!}/usr/bin/env bash`n", 300)
  Type("source ""approvals.bash""`n", 300)
  Type("approve ""ls""", 300)
  Type("approve ""git --version""")
  Type("{Escape}:exit")
  Type("./test.sh", 4000)
  Send a
  Sleep 2000
  Send a
  Sleep 2000
  
  Type("./test.sh")
  Type("touch new-file")
  Type("./test.sh", 4000)
  Send a
  Sleep 2000

  Type("exit")
  Type("svg-term --in cast.json --out cast.svg --window")
Return

^F12::
  Reload
return

F11::
  ExitApp
return
