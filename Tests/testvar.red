Red [
	Title:   "Red variables"
	Author:  "ldci"
]

;--3 Red programming rules: Readability, Reliability and Reusability.
;--the way to access and modify global Red variables

i: 100 			;--integer!
f: 0.0		 	;--float!
s: "Hello Red" 	;--string!

getInt: routine [/local int][
	int: as red-integer! #get 'i
	int/value: int/value + 100
	int/value
]

getFloat: routine [/local fl][
	fl: as red-float! #get 'f
	fl/value: fl/value + pi
	fl/value
]

getString: routine [/local st ptr][
	st: as red-string! #get 's
	ptr: " and Red/System"				;--just a c-string! considered as pointer
	string/concatenate-literal st ptr	;--append ptr values to string
	as c-string! string/rs-head st		
]


;--Some Red scalars can use boxing to return a Red value
getIntBoxing: routine [/local int][
	int: as red-integer! #get 'i
	integer/box int/value + 250
]

getFloatBoxing: routine [/local fl][
	fl: as red-float! #get 'f
	float/box fl/value + pi / 2.0
]


print ["Red words values: " i f s]
print ["Routines can modify Red words values"]
print ["Test Integer:" getInt]
print ["Test Boxing: " getIntBoxing]
print ["Test Float:  " getFloat]
print ["Test Boxing: " getFloatBoxing]
print ["Test String: " getString]




