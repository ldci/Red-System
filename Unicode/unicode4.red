#! /usr/local/bin/red
Red [
	Title: "unicode4"
	Author: "LDCI"
	Version: 4.0
	Notes: {This code allows to visualize basic UFT-8 unicode characters and most of emojis}
	Needs: view
]

margins: 5x5
start: 0
end: 255

;--from https://www.w3schools.com/charsets/ref_utf_basic_latin.asp
codes: [
"0x0000-0x007F 0-127 Latin Basic"
"0x0080-0x00FF 128-255 Latin-1 Supplement"
"0x0100-0x017F 256-383 Latin Extended-A"
"0x0180-0x024F 384-591 Latin Extended-B"
"0x02B0-0x02FF 688-767 Spacing Modifier Letters"
"0x0300-0x036F 768-879 Combining Diacritical Marks"
"0x0370-0x03FF 880-1023 Greek and Copte"
"0x0400-0x04FF 1024-1279 Cyrillic Basic"
"0x0500-0x052F 1280-1327 Cyrillic Supplement" 
"0x2000-0x206F 8192-8303 General Punctuation"
"0x20A0-0x20CF 8352-8399 Currency Symbols"
"0x20D0-0x20FF 8400-8447 Combining Marks for Symbols"
"0x2100-0x214F 8448-8527 Letterlike Symbols"
"0x2150-0x218F 8528-8591 Number Forms"
"0x2190-0x21FF 8592-8703 Arrows"
"0x2200-0x22FF 8704-8959 Mathematical Operators"
"0x2300-0x23FF 8960-9215 Miscellaneous Technical"
"0x2400-0x243F 9216-9279 Control Pictures"
"0x2440-0x244A 9280-9290 Optical Character Recognition" 
"0x2460-0x24FF 9312-9471 Enclosed Alphanumerics"
"0x2500-0x257F 9472-9599 Box Drawing"
"0x2580-0x259F 9600-9631 Block Elements"
"0x25A0-0x25FF 9632-9727 Geometric Shapes"
"0x2600-0x26FF 9728-9983 Miscellaneous Symbols"
"0x2700-0x27BF 9984-10175 Dingbats"
"0x1F300-0x1F3C0 127744-127936 Miscellaneous Pictograms 1"
"0x1F3C0-0x1F483 127937-128129 Miscellaneous Pictograms 2"
"0x1F3C1-0x1F542 128130-128322 Miscellaneous Pictograms 3"
"0x1F543-0x1F5FF 128323-128511 Miscellaneous Pictograms 4"
"0x1F600-0x1F64F 128512-128591 Emoticons"
"0x1F680-0x1F6FF 128640-128767 Transport/Map"
"0x1F900-0X1F9FF 129280-129535 Supplemental Symbols and Pictographs" 
]

getUnicode: does [
	clear list/data
	clear f3/text
	clear sb2/text
	clear cc/text
	p/data: 0%
	if error?  try [start: to-integer f1/text][start: 0]
	if error?  try [end: to-integer f2/text][start: 255]
	i: start
	while [i <= end ] [
		append list/data rejoin [form i " : " form to-char i]
		p/data: to-percent (i / end)
		sb11/text: form to-percent round/to p/data 0.01
		do-events/no-wait
		i: i + 1
	]
	f3/text: rejoin [form end - start + 1 " Symbols"]
	cc/text: ""
	p/data: 0%
	list/selected: 2
]
view win: layout [
	title "Unicode Chart [UTF-8 and emojis]"
	origin margins space margins
	text "Start" f1: field "0" [if error?  try [start: to-integer f1/text][start: 0]]
	text "End" f2: field "255" [if error?  try [end: to-integer f2/text][start: 255]]
	button "Codes" 80 [getUnicode]
	pad 75x0
	f3: field 120 center
	pad 120x0  
	button "Quit" 80 [Quit]
	return
	text-list 500x350 font-size 13 data codes
	on-change [
		item: face/data/(face/selected)
		b: split item " "
		range: split second b "-"
		n: length? b
		if n = 3 [sb1/text: b/3]
		i: 3
		;--more strings
		if n > 3 [
			str: copy ""
			while [i <= n][
				append  str  rejoin [b/:i " "]
				i: i + 1
			] 
			sb1/text:  str
		]
		f1/text: form start: to-integer range/1
		f2/text: form end: to-integer range/2 
		getUnicode
	]
	
	list: text-list 120x350 font-size 13 data []
	on-change [
		_item: face/data/(face/selected)
		;--if index = 0 set the index to 2 (pbs avec selected)
		if  none? _item [
			face/selected: face/selected + 2
			_item: face/data/(face/selected)
		]

		unless none? _item[
			_b: split _item " : "
			v:  to-integer _b/1
			;--for UFT-8 and other  format hex value
			either v > FFFFh [len: 6] [len: 4]
			sb2/text: form to-hex/size to-integer _b/1 len
			append sb2/text "h"
			cc/text: _b/2
		]
	]
	pad 2x0
	cc: base 200x150 white middle center font-size 70
	return
	sb1: field 300
	p: progress 140 sb11: field 50 ""
	sb2: field 120 center
]