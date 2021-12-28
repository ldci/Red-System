#!/usr/local/bin/red
Red [
	Title: "makeUnicode"
	Author: "LDCI"
	Version: 1.0
	Notes: {This code allows to generate emojis or unicode characters}
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

;--uncomment for console tests
{
print makeUnicodeSymbols "Emoticom 1		" [1F62Eh]
print makeUnicodeSymbols "Emoticom 2		" [1F62Eh 200Dh 1F4A8h]
print makeUnicodeSymbols "Medical			" [1F9D1h 200Dh 2695h FE0Fh]
print makeUnicodeSymbols "Scientific		" [1F9D1h 1F3FBh 200Dh 1F52Ch]
print makeUnicodeSymbols "Friends			" [1F9D1h 200Dh 1F91Dh 200Dh 1F9D1h]
print makeUnicodeSymbols "Couple 			" [1F469h 1F3FCh 200Dh 2764h FE0Fh 200Dh 1F468h 1F3FCh]
}

;--view test
s1: makeUnicodeSymbols "Change Color " 	[23FAh FE0Fh] ;[2705h]
s2: makeUnicodeSymbols "" 				[23F9h]
s3: makeUnicodeSymbols "" 				[274Eh]

view win: layout [
	title "View Test"
	canvas: base 320x240 red font-size 80 return
	button 150x48 font-size 13 s1	[canvas/color: random 255.255.255]
	button 54x48  font-size 13 s2	[canvas/color: black]	
	button 85x48  font-size 16 s3	[quit]
	do [canvas/text: makeUnicodeSymbols "" [128125]]
]



