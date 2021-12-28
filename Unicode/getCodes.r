#!/usr/local/bin/red
Red [
	Title: "getCodes"
	Author: "LDCI"
	Version: 1.0
	Notes: {This code allows to visualize most of emojis}
	Needs: view
]


getCodes: does [
	blk:  copy[]			;--html block of strings
	codesChars: copy []		;--char values
	codesValues: copy[]		;--code values	hexa form
	codesLabels: copy []	;--code labels string
	
	unless exists? %codes.txt [
		f: read https://emojiterra.com/fr/points-de-code/#top
		write %codes.txt f
	]
	f: read %codes.txt
	;--parsing must be updated if you use another Website
	parse f [
		any [thru "<td>" copy data to "</td>" (append blk data)]
	] 

	;--blk/(i) contains an integer count: we do not use
	n: (length? blk) - 2
	i: 1
	while [i <= n][
		;--code char value
		parse blk/(i + 1) [
			any [thru "<span>" copy data to "</span>" (append codesChars data)]
		]
		;--code char label (in french) 
		parse blk/(i + 1) [
			any [thru "</span>" copy data to "</a>" (append  codesLabels data)]
		]
		;--we transform hexadecimal values to red format
		c: trim/with blk/(i + 2) "U+" 
		replace/all c " " "h "
		append c "h"		;--for the last value
		append codesValues c
		i: i + 3
	]
	n: (length? blk) / 3
	f1/text: rejoin [form n " entries"]
	list/data: codesChars list/selected: 1
]

win: layout [
	title "Emojis 2021"
	button  "Load Emojis" 120 [getCodes]
	f1: field 100 text "Symbol N°"  80 f2: field 60 ""
	pad 150x0 button "Quit" [Quit] return 
	list: text-list 120x300 font-size 18 data []
	on-change [
		cc/text: trim face/data/(face/selected)				;--draw symbol as text
		f2/text: form face/selected							;--symbol number
		f3/text: form codesValues/(face/selected)			;--hexadecimal value
		f4/text: form lowercase codesLabels/(face/selected)	;--symbol label
		
	]
	at 140x125 cc: base 450x110 snow middle center font-size 80
	return text 110 "Hexadecimal" f3: field 500 ""
	return text 110 "Label" f4: field 500 ""
]
view win 


