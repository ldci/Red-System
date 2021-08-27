Red/System [
	Title:   "size"
	Author:  "ldci"
]

;--3 Red programming rules: Readability, Reliability and Reusability.

;--size? returns the memory storage size in bytes required by a value of given type. 
;--When passed a c-string literal value, it will return the number of bytes in the c-string, 
;--including the ending null byte.
;--knowing the size of value type is very important when values must be padded in memory!

;--2 samples structures as aliases
;--An alias is not a real value, it does not take any space in memory.
;--It can be seen as a virtual datatype. 
;--By convention, alias names should end with an exclamation mark, 
;--in order to distinguish them more easily from variables in the source code.

aStruct!: alias struct! [
    f       [float!]
    i       [integer!]
    str     [c-string!]
]

rcvRect!:  alias struct! [
	x				[integer!]
	y				[integer!]
	width 			[integer!]
	height			[integer!]
	weight			[float!]
]

print ["size? tests (bytes)" lf]
print ["Byte!:    	" size? byte! lf]
print ["Integer!: 	" size? integer! lf]
print ["Float32!: 	" size? float32! lf]
print ["Float!:   	" size? float! lf]
print ["Logic!:   	" size? logic! lf]
print ["Byte-ptr!:      " size? byte-ptr! lf]
print ["Int-ptr!:       " size? int-ptr! lf]
print ["Float32-ptr!:   " size? float32-ptr! lf]
print ["Float-ptr!:     " size? float-ptr! lf]
print ["Structure 1:    " size? aStruct! lf]
print ["Structure 2:    " size? rcvRect! lf]

;--Do not confuse the length? function with the size? function. 
;--Size? function will return the number of bytes in the c-string, 
;--including the ending null byte.

print ["String 1:       " length? "Hello" lf]
print ["String 2;       " length? "Hello Red World" lf]
print ["String 2;       " size?   "Hello Red World" lf]   ;--length? + 1
