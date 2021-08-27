Red [
	Title:   "Strings"
	Author:  "ldci"
]

;--the way to share global Red words with Red/System code

s: "Hello Red"				;--string variable
b: #{48656C6C6F20526564}	;--same string as binary

;--Red/System routines
getString: routine [return: [string!]][
	as red-string! #get 's
]

getBinary: routine [return: [binary!]][
	as red-binary! #get 'b
]

;--Red code

print ["Test String: " getString]
append s " is amazing"
print ["Test String: " getString]
print ["Test Binary: " getBinary]
