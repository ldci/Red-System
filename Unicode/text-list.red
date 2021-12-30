#! /usr/local/bin/red
Red [
	Title: "unicode4"
	Author: "LDCI"
	Version: 1.0
	Notes: {This code allows to use unicode characters in Red text-list object}
	Needs: view
] 

;--initialize  base text objects
init: [
	s: to-char 2587h
	r/text: copy rejoin [form s " Red"]
	g/text: copy rejoin [form s " Green"]
	b/text: copy rejoin [form s " Blue"]
]

;--update the color viewer according to selected object
update: func [face [object!]] [
	f/font/color: 0.0.0 + f/color
	f/color: face/font/color  
	f/text: form face/font/color
]

view win: layout [
	title "Color Selection"
	space 5x5	
	r: base snow 80x24 left middle font-color red   [update r]
	g: base snow 80x24 left middle font-color green [update g]
	b: base snow 80x24 left middle font-color blue	[update b] 	 
	pad 55x0 button  50 "Quit"[quit]
	return
	
	t: text-list 100x120 white black font-size 11 data []
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
	f: base 260x120 white black font-size 16 
	do [reduce init]
]



