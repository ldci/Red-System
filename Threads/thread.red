#! /usr/local/bin/red
Red [
	Title:   "Thread tests "
	Author:  "ldci"
	File: 	 %thread.red
	Needs:	 View
]

;--concurent tasks with scheduler and no timer
;--code must be compiled with -e option (encap option) ???
;--e.g. red -r -e thread.red or red -t target -e thread.red

random/seed now/time/precise
img: make image! reduce [640x480 black]
plot: [line-width 1 pen green line 0x240]
x: y: 0
height: 400
t1: t2: none
stop: false

scheduler: make object! [
	threadCount: 0
	threadList: []
	delay: 0.0
	appendThread: func [
		athread	[object!]
	][
		append threadList athread 
		threadCount: threadCount + 1
	]
		
	startMessageLoop: function [] [
		i: 1
		while [i <= threadCount] [
			cthread: threadList/:i
			cthread/tTrigger: cthread/tCount % cthread/tPriority
			cthread/tExecute
			cthread/tCount: cthread/tCount + 1
			i: i + 1
		]
	]
]


rThread: make object! [
	tNumber: 		0 ; thread number
	tPriority: 		1 ; thread priority  [1 to N (high to low)]
	tCount: 		0 ; thread calls counter
	tTrigger: 		0 ; trigger for special events such as data visualization	
	tExecute:    none ; func as code pointer 
]

clearScreen: does [
	x: 0 
	canvas/image/rgb: 0.0.0
	clear plot
	compose/into [line-width 1 pen green line 0x240] plot
]

showImage: does [
	x: x + 1
	if x > 640 [clearScreen]
	y:  40 + multiply height / 2 1 + sin 0.05 * x
	append plot as-pair x y
	;show points according to the thread priority
	if t1/tTrigger = 0 [canvas/image: draw img plot do-events/no-wait]
]

showTime: does [
	ct: now/time
	if t2/tTrigger = 0 [fT2/text: form ct do-events/no-wait] 
]


initThreads: does [
	; create threads 1 and 2 (make required)
	t1: make rThread [tNumber: 1 tPriority: 10 tExecute: :showImage]
	t2: make rThread [tNumber: 2 tPriority: 30 tExecute: :showTime]
	;register threads
	scheduler/AppendThread t1
	scheduler/AppendThread t2
]


;************ test program *****************
view win: layout [ 
	title "Threads Demo"
	base 640x1 blue
	return
	canvas: base 640x480 img
	return
	base 640x1 blue
	return
	ft2: field 100 center
	f: field 30 "10"
	text 30 "High"
	sl: slider 120 [
		v: 1 + to-integer (sl/data * 19)
		t1/TPriority: 21 - v 
		f/text: form v 
	]
	text 30 "Low"
	button "Clear" [clearScreen]		
	button "Start" [
		stop: false 
		until [scheduler/StartMessageLoop stop]
	]
	button "Stop" [stop: true]
	button "Quit" [quit]
	do [initThreads sl/data: 50%]
]





