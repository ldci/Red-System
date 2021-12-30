#! /usr/local/bin/red
Red [
	Title: "Pascal triangles"
	Author: "ldci"
	Notes: {Plays with Pascal triangles}
]
;--each element of each row is either 1 
;--or the sum of the two elements right above it

;--very elegant solution with vector! sum
;--from Rosetta Code: author???

pascal-triangle: function [
    n [ integer! ] "number of rows"
 ][
    row: make vector! [ 1 ]
    loop n [
        print row
        left: copy row
        right: copy row
        insert left 0
        append right 0
        row: left + right
    ]
]

;--modified by ldci for centered values
pascal-triangle-center: function [
    n [integer!] "number of rows"
 ][
    row: make vector! [1]
    i: 1
    loop n [
    	repeat j n - i - 1 [prin " "]
        print row
        left: copy row
        right: copy row
        insert left 0
        append right 0
        row: left + right
        i: i  + 1
    ]
]


pascal-triangle 9
pascal-triangle-center 9

print  lf 

;--A more classical 

pascalTriangle: function [
    n [integer!] 
    /center
 ][
	i: 0
	while [i < n] [
		v: 1
		k: j: 0
		if center [repeat j n - i - 1 [prin " "]]
		while [k <= i][
			prin [v ""]
			v:  v * (i - k) / (k + 1)
			k: k + 1
		]
		print ""
		i: i + 1
	]
]

pascalTriangle 9
pascalTriangle/center 9


