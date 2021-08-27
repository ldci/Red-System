Red/System [
	Title:   "Pointers"
	Author:  "ldci"
]
;--3 Red programming rules: Readability, Reliability and Reusability.
print ["Let's play with structures and pointers" lf]
print ["Create structure and pointer" lf]
;--First we create a structure as an alias (no memory allocation)
union: alias struct! [
    f       [float!]
    i       [integer!]
    str     [c-string!]
]

;--then a pointer to the structure
p-struct!: declare struct! [ptr [union]] ;--memory allocation 

;--now we have to allocate the structure
un: declare union
un/f: pi
un/i: 255
un/str: "Hello Red world"

;--and to create a pointer to the structure
p-struct!/ptr: un

;--verify structure initialization
print ["Structure address: " un lf]
print ["Pointer value:     " p-struct! lf]
print ["Nice, we are pointing to the structure!" lf]
print [p-struct!/ptr/f " " p-struct!/ptr/i " " p-struct!/ptr/str lf]

print ["Now, let's modify the pointer values" lf]
p-struct!/ptr/f: 0.0
p-struct!/ptr/i: 0
p-struct!/ptr/str: "Bye bye crual world!"

print ["Pointer values are changed" lf]
print [p-struct!/ptr/f " " p-struct!/ptr/i " " p-struct!/ptr/str  lf]
print ["And the structure too! " lf]
print [un/f " " un/i " " un/str lf]
    