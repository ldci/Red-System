Red/System [
	Title:   "Binary Arrays"
	Author:  "ldci"
]

;--basically binary arrays are similar to c-strings and can be considered  as pointers
 		
binArray: #{48656C6C6F20576F726C64}	
print ["String address: " binArray lf]
n: size? binArray  
print ["String Size:    " n lf]								 ;--size? for pointer  
print ["String Length:  " length? as c-string! binArray lf]  ;--length? for string

print ["Integer Representation:  "]
i: 1 
while [i <= n][
	print [as integer! binArray/i]
	i: i + 1
]
print lf

print ["Char Representation:     "]
i: 1 
while [i <= n][
	print [binArray/i " "]
	i: i + 1
]
print lf

print ["C-String Representation: "] 
until [
     print binArray/1                   
     binArray: binArray + 1
     binArray/1 = null-byte
]
print  lf


