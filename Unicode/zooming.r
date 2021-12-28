#!/usr/local/bin/red
Red [
	Title: "zooming"
	Author: "ldci"
	Version: 1.0
	Notes: {Plays with unicode  zoom}
	Needs: view
]

makeUnicodeSymbols: func [
"Generates unicode symbols from charcodes"
	s 		[string!]	;--string can be empty 
	b 		[block!]	;--block of hexadecimal or integer values
	return: [string!]	;--result
][
	repeat i length? b [append s to-char b/:i]
]


;--view test
s0: makeUnicodeSymbols "" [1F537h]
s1: makeUnicodeSymbols " Quit Robot's Game " [1F537h]
s: rejoin [s0 s1]
view win: layout [
	title "Zooming Test"
	button 320x48  font-size 20 center s [quit] return
	canvas: area 320x320 white center font-size 50 return
	sl: slider 270 [
		canvas/font/size: to-integer 1 + (face/data * 199)
		f/text: form to-percent round/to sl/data 0.01
	]
	f: field 40
	do [canvas/text: makeUnicodeSymbols "" [1F916h] 
		sl/data: 0.25 f/text: form to-percent round/to sl/data 0.01
	]
]



