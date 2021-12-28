#!/usr/local/bin/red
Red [
	Title: "morse"
	Author: "ldci"
	Version: 1.0
	Notes: {Plays map}
	Needs: view
]

;--since sound is not yet supported we need sox (http://sox.sourceforge.net)  

mCode: make map! [
#"A"	".-"
#"B"	"-..."
#"C"	"-.-."
#"D"	"-.."
#"E"	"."
#"F"	"..-."
#"G"	"--."
#"H"	"...."
#"I"	".."
#"J"	".---"
#"K"	"-.-"
#"L"	".-.."
#"M"	"--"
#"N"	"-."
#"O"	"---"
#"P"	".--."
#"Q"	"--.-"
#"R"	".-."
#"S"	"..."
#"T"	"-"
#"U"	"..-"
#"V"	"...-"
#"W"	".--"
#"X"	"-..-"
#"Y"	"-.--"
#"Z"	"--.."
#"0"	"-----"
#"1"	"·----"
#"2" 	"··---"
#"3"	"···--"
#"4"	"····-"
#"5"	"·····"
#"6"	"-····"
#"7"	"--···"
#"8"	"---··"
#"9"	"----·"
#"."	".−.−.−"
#"," 	"−−..−−"
#":" 	"−−−..."
#"'"	".−−−−."
#"("	"−.−−."
#")" 	"−.−−.−"
#"?"	"..−−.."
#"@"	".−−.−."
#"^""	"−.−−.−"
#"=" 	"−.−−.−"
#"+" 	".−.−."
#"-"	"−....−"
#"/"	"−..−."
#"x"	"−..−"
]

;--for abreviations strings
mShortCuts: make map! [
"BOT"	"−.−.−"			;--begin transmissin
"EOT"	"...−.−"		;--end transmission 
"I2T"	"−.−"			;--invitation to transmit
"WFT"	".−..."			;--waiting for response
"VVV"	"···—···—···—"	;--transmission test
"ERR" 	"........"		;--transmission error
"OK"	"...−.-"		;--understood 
]

shortB: 	0.1 		;--for dot
longB: 		shortB * 3	;--for dash

plot: compose [pen green fill-pen black circle 150x150 100]

light: func [
	b	[float!]
][
	plot/4: yellow wait b plot/4: black
]
;--we need sox: http://sox.sourceforge.net  
;--and http://sox.sourceforge.net/sox.html
;--eg: play -n synth 0.2 sine 700

beep: func [
	b	[float!]
][
	call/wait rejoin ["play -n synth " form b " sine 700"]
]

;--send code for each letter
sendCode: func [
	str	[string!]
][
	foreach c uppercase str [
		cc: select mCode c	;--select morse string with n characters
		canvas/text: rejoin [c " [" cc "]"]
		foreach v cc [
			append f2/text v
			either v = #"." [light shortB beep shortB][light longB beep longB]
			wait shortB 	;--delay between codes inside a letter
		]
		canvas/text: ""
		append f2/text " "
		wait shortB * 3		;--delay between letters in word
	]
]

win: layout [
	title "Morse Tests"
	space 5x5
	f1: field 160 "SOS RED TEAM"
	button "Send" [	
		clear canvas/text clear f2/text
		blk: split f1/text " " 		;--get words in string with spaces
		repeat i length? blk [		;--for each word
			sendCode blk/:i			;--translate word to morse
			append f2/text " "		;--add space in morse string
			wait shortB * 7 		;--delay between words
		]
		canvas/text: rejoin ["Sent: " uppercase f1/text]
	]
	button "Quit" [Quit]
	return 
	canvas: base 300x300 black font-color green font-size 16
	return
	f2: area 300x100 black "" font-color green font-size 20
	do [canvas/para: make para! [align: 'center v-align: 'top]
		canvas/draw: reduce [plot] canvas/text: "Waiting"
	]
]
view win
