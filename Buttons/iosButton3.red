#! /usr/local/bin/red
Red[
	Title:   "IOS button Like"
	Author:  "ldci"
	File: 	 %iosButton3.red
	needs: 	 view
	Tabs:	 4
]

;--inspired by switch-btn. Author: Greg Irvin?

bits: [0 0 0 0];--for test

win: layout [
	title "iOS"
    style iosBtn: base 48x24 
    	on-create [
            face/extra: object [
            	fColor:  snow
            	bColor:  face/color
            	bSize:   face/size
            	radius:  to-integer bSize/y / 2
				lCenter: as-pair radius radius				
				rCenter: as-pair bSize/x - radius radius
				;--make default image (off)
				blk: compose [
                	line-join round 
                	fill-pen fColor box 0x0 (bSize) (radius)
                	fill-pen fColor circle (lCenter) (radius)
                ]
                bDraw: draw bSize blk ;--call draw method
                ;--click event 
                bClick: func [face][     
                    either face/data = 0 [
                    	face/data: 1 blk/4: bColor blk/12: rCenter
                    	][face/data: 0 blk/4: fColor blk/12: lCenter]
                    ;--update face image with draw
                	bDraw: draw bSize blk
            		face/image: face/extra/bDraw
                ]
        	]
        ;--init values
        face/color: face/extra/fColor
        face/data: 0
        face/image: face/extra/bDraw
    ]
    
    space 10x10
    below
    iosBtn blue  24x12	[face/extra/bClick face bits/1: face/data f/text: form bits]
    iosBtn sky 	 32x16	[face/extra/bClick face bits/2: face/data f/text: form bits]
    iosBtn green 40x20	[face/extra/bClick face bits/3: face/data f/text: form bits]    
    iosBtn gold  48x24	[face/extra/bClick face bits/4: face/data f/text: form bits]
    across
    f: field 100 center disabled no-border 
    return 
    button 100 "Quit" [Quit]
    do [f/text: form bits]
]

view win