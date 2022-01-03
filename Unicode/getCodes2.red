#!/usr/local/bin/red
Red [
	Title: "getCodes2"
	Author: "LDCI"
	Version: 2.0
	Notes: {This code allows to visualize emojis V14.0}
	Needs: view
]

;--https://unicode.org/emoji/charts/full-emoji-modifiers.html


getCodes: does [
	f1/text: "Loading..."
	do-events/no-wait
	codesValues: 	copy []		;--code values	hexa form
	codesChar: 		copy []		;--unicode chars
	codesLabel: 	copy []		;--labels
	version: 		""			;--unicode version
	unless exists? %codesv14.txt [
		f: read https://www.unicode.org/emoji/charts/emoji-list.html
		write %codesV14.txt f
	]
	f: read %codesV14.txt
	parse f [thru "<h1>" copy version to  "</h1>"]
	idx: index? find f "Show your support of Unicode" 
	idx: idx + 28
	f: skip f idx
	parse f [any [thru "title='" copy text to "'" 
			(
				count: 0
				trim/with text ":" c: split text " "
				n: length? c
				s: copy ""
				;--make Red  hexadecimal values
				foreach v c [
					if (find v  "U+") [
						trim/with v "U+"
						append v "h "
						count: count + 1 append s rejoin [v " "]
					]
				]
				append codesValues s 					;--append hexadecimal values
				count: count + 1
				append codesChar  c/:count				;--append unicode char
				c: skip c count
				n: length? c
				s: copy ""
				foreach v c [append s rejoin [" " v]]
				append codesLabel s						;--append code label
			)
		]
	]
	append clear list/data codesChar					;--make list
	f1/text: rejoin [form length? codesChar " entries"]
	win/text: version
	list/selected: 1
]

win: layout [
	title "Emojis 2021"
	button  "Load Emojis" 120 [getCodes]
	f1: field 100 base 80x24 snow middle center  "Symbol N°"  f2: field 60 ""
	base 80x24 snow middle center "Font Size"
	sl: slider 100 [cc/font/size: to-integer 1 + (face/data * 199)
		f3/text: form cc/font/size
	]
	f3: field 40 "100"
	pad 15x0 button "Quit" [Quit] return 
	list: text-list 120x300 font-size 18 data []
	on-change [
		cc/text: trim face/data/(face/selected)				;--draw symbol as text
		f2/text: form face/selected							;--symbol number
		f4/text: form codesValues/(face/selected)			;--hexadecimal value
		f5/text: form lowercase codesLabel/(face/selected)	;--symbol label
	]
	cc: area 600x300 white middle center font-size 100
	space 10x2
	return text 120 "Hexadecimal" f4: field 600 ""
	return text 120 "Label" f5: field 600 ""
	do [sl/data: 0.5 cc/font/size: 100]
]
view win 



