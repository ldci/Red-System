#!/usr/local/bin/red
Red[
	Author: "ldci"
	needs: 	view
]

;--Only for macOS 

voice: 		[]
language: 	[]
sentence:	[]
flag: 1

loadVoices:  does [
	voices: read/lines %voices.txt
	foreach v voices [
		tmp: split v "#" 
		append sentence tmp/2
		trim/lines tmp/1
		append voice first split tmp/1 space
		append language second split tmp/1 space
	]
	a/text: sentence/1
	f/text: language/1
]

generate: does [
	prog: rejoin ["say --voice=" #"^"" 
				 voice/:flag #"^"" " " 
				 #"^"" a/text #"^""
	]
	call prog
]

mainWin: layout [
	title "Voices"
	dp1: drop-down data voice
		select 1
		on-change [
			flag: face/selected
			f/text: language/(face/selected)
			a/text: sentence/(face/selected)
			generate
		]
	f: field center
	button "Talk"	[generate] 
	pad 100x0 
	button  "Quit"	[quit]
	return
	a: area 450x50
	do [loadVoices]
]

view mainWin

