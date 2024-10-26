#! /usr/local/bin/red
Red [
	Title: "morse"
	Author: "ldci"
	Version: 1.0
	Notes: {Plays with System Fonts}
	Needs: view
]
txt: {A key problem of software development today is software bloat, where huge toolchains and development environments are needed in software coding and deployment. 
Red significantly reduces this bloat by offering a minimalist but complete toolchain. 
This is the first introductory book about it, and it will get you up and running with Red as quickly as possible (Ivo Balbaert).}

win: layout [title "System Fonts" 
	button "Fonts"[
		ft: request-font
		ar/font/name: ft/name
		ar/font/size: ft/size
		ar/font/style: ft/style
		sb/text: ft/name
		f/text: form ft/size
		sl/data: to-percent (ft/size / 100.0)
	]
	
	text 40 "Size"
	sl: slider 70 [sz: to-integer 1 + (face/data * 99) f/text: form sz
			ar/font/size: sz]
	f: field 40 
	drop-list 70
		data  ["black" "blue" "green" "yellow" "red"]
		react [ar/font/color: reduce to-word pick face/data any [face/selected 1]]
		select 1

	button "Quit" [Quit] return
	ar: area white 400x400 txt wrap
	font [name: "Arial" size: 12 color: black] return
	sb: base 400x20 white "Arial"
	do [sl/data: 0.12 f/text: "12"]
] 
view win
