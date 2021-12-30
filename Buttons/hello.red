#! /usr/local/bin/red
Red[
	Title:   "IOS button Like"
	Author:  "ldci"
	File: 	 %hello.red
	needs: 	 view
	Tabs:	 4
]

bsize1: 50X50
bSize2: bsize1 / 10 * 2 
angle: 0
center1: bsize1 / 2
center2: bSize2 / 2
radius1:  to-integer bsize1/x / 2
radius2:  to-integer bsize2/x / 2
dMin: radius1 - radius2
img: load %red-logo.png;%red-poster.png
iSize: img/size
scale: 0.625
centerXY: iSize / 2
translation: (iSize * scale) / 2 - 8
active?: 0

;--basically these 3 functions are included in redCV :)

degree2xy: function [
"Returns XY coordinates from angle and distance between 2 points"
	radius [number!]	;--distance
	angle  [number!]	;--angle in degree
][
	as-pair (radius * cosine angle) (radius * sine angle) 
]

getAngle: function [
"Gets angle in degrees from points coordinates"
	p 	[pair!] 
	cg 	[pair!]
][		
	rho: getRho p cg					;--euclidian distance
	uY: to-float p/y - cg/y				;--uY vector
	uX: to-float p/x - cg/x				;--uX vector
	theta: arccosine uX / rho			;--angle
	if p/y < cg/y [theta: 360 - theta]	;--0..359 range
	theta
]

getRho: function [
"Get Euclidian distance"
	pt		[pair!]
	cx		[pair!]
	return: [float!]
][
	dx: to-float (pt/x - cx/x)
    dy: to-float (pt/y - cx/y)
    square-root ((dx * dx) + (dy * dy))
]


coord: center1 + degree2xy dMin angle		;--coordinates  initialization

;--draw rotatory face
blk1: compose [
	line-width 3 pen silver
	fill-pen snow circle (center1) (radius1)
]

;--loose face draw
blk2: compose [
    pen silver
	fill-pen gray circle (center2) (radius2)
]

;--canvas draw
blk3: compose [
	scale (scale) (scale) 
	translate (translation) 
	rotate (angle) (centerXY) 
	image (img)
]


win: layout [
	title "Rotary Test"
	style iosBtn: base 48x24 
    	on-create [
            face/extra: object [
            	bColor:  face/color
            	bsize:   face/size
            	radius:  to-integer bsize/y / 2
				lcenter: as-pair radius radius				
				rcenter: as-pair bsize/x - radius radius
				;--off state
                bOff: draw bsize compose [
                	line-join round 
                	fill-pen snow box 0x0 (bsize) (radius)
                	fill-pen snow circle (lcenter) (radius)
                ]
                ;--on state
                bOn: draw bsize compose [
                	line-join round 
                	fill-pen bColor box 0x0 (bsize) (radius)
                    fill-pen snow circle (rcenter) (radius)
                ]
                ;--click event
                bClick: func [face][     
                    either face/data = 0 [
                    	face/data: 1 face/image: face/extra/bOn
                    	][face/data: 0 face/image: face/extra/bOff]
                ]
        	]
        	face/color: snow
            face/data: 0
            face/image: face/extra/bOff
    ]
	
	field 100 "Hello Red World"
	f: field 54 center
	iosBtn green  40x20	[face/extra/bClick face active?: face/data 
		either active? = 1 [bb/visible?: true] [bb/visible?: false]
	]
	button "Quit" [quit]
	return
	pad 45x0
	canvas: base iSize white 
	return
	pad 120x0
	b: base 54x54 snow draw blk1 
	at coord + b/offset - center2 bb: base bSize2 glass draw blk2 loose 
	on-drag [
		angle: getAngle bb/offset - b/offset center1
		f/text: form round angle
		d: round getRho bb/offset - b/offset center1 
		if d <> dMin [coord: center1 + degree2xy dMin angle]
		blk3/7: angle
		bb/offset: b/offset + coord - center2		
	]
	do [f/text: form angle canvas/draw: blk3 bb/visible?: false]
]

view win