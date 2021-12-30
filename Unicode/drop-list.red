#! /usr/local/bin/red
Red [
	Title: "unicode4"
	Author: "LDCI"
	Version: 1.0
	Notes: {This code allows to use unicode characters in Red dro-down object}
	Needs: view
] 

;--update the color viewer according to selected object
update: func [face [object!]] [
	f/color: face/font/color  
	cf/text: form face/font/color
]

view win: layout [
	title "Color Selection: drop-list"
	space 5x5	
	t: drop-list 150 white black font-size 11 data []
	on-create [
		append face/data rejoin [form to-char 2764h form to-char FE0Fh " Red"]
		append face/data rejoin [form to-char 1F49Ah " Green"]
		append face/data rejoin [form to-char 1F499h " Blue"]
		append face/data rejoin [form to-char 1F49Ch " Magenta"]
		append face/data rejoin [form to-char 1F9E1h " Orange" ]
		append face/data rejoin [form to-char 1F49Bh " Yellow"]
		append face/data rejoin [form to-char 1F5A4h " Black"]
		face/extra: [red green blue magenta orange yellow black]
	]
	on-change [ 
		face/font/color: do face/extra/(face/selected)
		update face				;--update color viewer
		face/font/color: black	;--restore default font color 
	]
	select 1
	cf: field 90 center
	pad 5x0 button  50 "Quit"[quit]
	return
	f: base 310x120 white black font-size 16 
	do[f/color:red cf/text: "255.0.0"]
]
