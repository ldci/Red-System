Red [
	Title:   "Arrays"
	Author:  "ldci"
]

;-- Basic Red Code
arr1: [1 2 3 4 5 6 7 8 9 10]
arr2: [512.0 255.0 127.0 64.0 32.0 16.0 8.0 4.0 2.0 1.0]

Print  "Red Array"
n: length? arr1
i: 1
while [i <= n][
    print [i ": " arr1/:i]
    i: i + 1
]

;--Now with routines for integer array

readIntegerArray: routine [ 
		array [block!] 
		/local 
		i 			[integer!] 
		int 		[red-integer!] 
		value tail 	[red-value!]
][
	print ["size: " block/rs-length? array lf]
	value: block/rs-head array
	tail: block/rs-tail array
	print ["Value: " value lf]
    print ["Tail : " tail lf]
	i: 1
	while [value < tail][
		int: as red-integer! value
		print [i ": " int " " int/value lf]
		value: value + 1
		i: i + 1
	]
]

;--and float array

readFArray: routine [
	array [block!] 
	/local 
	i 			[integer!] 
	f 			[red-float!] 
	value tail 	[red-value!]
][
	print ["size: " block/rs-length? array lf]
	value: block/rs-head array
	tail: block/rs-tail array
    print ["Value: " value lf]
    print ["Tail : " tail lf]
	i: 1
    while [value < tail][
		f: as red-float! value
		print [i ": " f " "  f/value lf]
		value: value + 1
		i: i + 1
	]
]
print newline
print ["Integer array"]
readIntegerArray arr1
print newline
print ["Float array"]
readFArray arr2 




   
