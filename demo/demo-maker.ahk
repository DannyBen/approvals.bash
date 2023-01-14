; --------------------------------------------------
; This script generates the demo svg
; --------------------------------------------------
#SingleInstance Force
SetkeyDelay 0, 50

; NOTE: This should be executed in the demo folder

Return

Type(Command, Delay=2000) {
  Send % Command
  Sleep 500
  Send {Enter}
  Sleep Delay
}

F12::
  Type("{#} Press F11 to abort at any time")
  Type("cd ./demo")
  Type("cp ../approvals.bash .")
  Type("rm new-file {;} mkdir -p approvals {;} rm -rf test.sh {;} rm -rf approvals/*")
  Type("rm -rf cast.json {;} asciinema rec cast.json", 4000)

  Type("vi test.sh")
  Type("i{#}{!}/usr/bin/env bash", 300)
  Type("", 50)
  Type("source ""approvals.bash""", 300)
  Type("", 50)
  Type("describe ""basic operation""", 300)
  Type("  approve ""ls""", 300)
  Type("  approve ""git --version""")
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
  ; Type("svg-term --in cast.json --out cast.svg --window")
  Type("agg --font-size 20 cast.json cast.gif")
  Sleep 400
  Type("rm new-file {;} rm -rf test.sh")
  Type("cd ..")
  Type("{#} Done")

Return

^F12::
  Reload
return

F11::
  ExitApp
return
