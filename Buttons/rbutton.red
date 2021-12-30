#! /usr/local/bin/red
Red[
	Title:   "Rotary button Like"
	Author:  "ldci"
	File: 	 %rbutton.red
	needs: 	 view
	Tabs:	 4
]

bsize1: 100x100; 50X50 
bSize2: bsize1 / 10 * 2  
angle: 0
center1: bsize1 / 2
center2: bSize2 / 2
radius1: to-integer bsize1/x / 2
radius2: to-integer bsize2/x / 2
dMin: radius1 - radius2

;--basically these 3 functions are included in redCV :)

degree2xy: function [
"Returns XY coordinates from angle and distance between 2 points"
	radius [number!]	; distance
	angle  [number!]	; angle in degree
][
	as-pair (radius * cosine angle) (radius * sine angle) 
]


getAngle: function [
"Gets angle in degrees from points coordinates"
	p 	[pair!] 
	cg 	[pair!]
][		
	rho: getRho p cg		; euclidian distance
	;rho: distance? p cg	; same with Red utils
	uY: to-float p/y - cg/y	; uY vector
	uX: to-float p/x - cg/x	; uX vector
	theta: arccosine uX / rho; costheta
	if p/y < cg/y [theta: 360 - theta]
	theta
]


getRho: function [
	pt		[pair!]
	cx		[pair!]
	return: [float!]
][
	dx: to-float (pt/x - cx/x)
    dy: to-float (pt/y - cx/y)
    square-root ((dx * dx) + (dy * dy))
]


coord: center1 + degree2xy dMin angle

;--Draw rotatory face
blk1: compose [
	line-width 3 pen silver
	fill-pen snow circle (center1) (radius1)
	;line (center1) (coord)
]

;--loose face draw
blk2: compose [
    pen silver fill-pen gray circle (center2) (radius2)
]


win: layout [
	title " "
	b: base 104x104 snow draw blk1 
	return
	f: field 104 center
	at coord + b/offset - center2 bb: base bSize2 glass draw blk2 loose 
	on-drag [
		angle: getAngle bb/offset - b/offset center1
		f/text: form round angle
		d: round getRho bb/offset - b/offset center1  
		if d <> dMin [coord: center1 + degree2xy dMin angle]
		;blk1/12: coord
		bb/offset: b/offset + coord - center2	
	]
	do [f/text: form angle]
]

view win