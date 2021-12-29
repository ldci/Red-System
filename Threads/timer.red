#! /usr/local/bin/red
Red [
	Title:   "Thread tests "
	Author:  "ldci"
	File: 	 %timer.red
	Needs:	 View
]
;--concurrent tasks with timer
random/seed now/time/precise
img: make image! reduce [640x480 black]
plot: [line-width 1 pen green line 0x240]
x: 1
y: 0
height: 400
stop: false

showTime: does [fT2/text: form now/time]

clearScreen: does [
	x: 0 
	canvas/image/rgb: black
	clear plot
	append plot [line-width 1 pen green line 0x240]
]


showImage: does [
	x: x + 1
	if x >= 640 [clearScreen]
	y:  40 + multiply height / 2 1 + sin 0.05 * x
	append plot as-pair x y
	trigger: round canvas/rate / 8
	if trigger < 1 [trigger: 1]
	if x % trigger = 0 [canvas/image: draw img plot]
]

;************ test program *****************
view win: layout [ 
	title "Timer Demo"
	base 640x1 blue
	return
	canvas: base 640x480 img 
		on-time [showImage]
	return
	base 640x1 blue
	return
	ft2: field 100 center 
		on-time [showTime]
	sl: slider 170 [
		v: 1 + to-integer (sl/data * 511)
		canvas/rate: v
		f/text: rejoin [v  " Hz"]
	]
	f: field 60 "250 Hz"
	
	button "Clear" [clearScreen]
	button "Start" [canvas/rate: 256 ft2/rate: 1]
	button "Stop"  [canvas/rate: none ft2/rate: none]
	button "Quit"  [quit]
	do [canvas/rate: none ft2/rate: none sl/data: 50%]
]
