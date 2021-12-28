Red [
	Title:   "Call"
	Author:  "ldci"
]

;--How to use R/S #call with Red

print ["Red Version : " system/version]
print ["Compiled    : " system/build/config/OS system/build/config/OS-version]

print "Random Tests"

random/seed now/time/precise			;--generate Random/seed
rand: function [n [integer!]][random n] ;--returns an integer

;--first solution with #system
#system [
   v: 1000 			;--Red/S word to be used with routines 
   #call [rand v]
   int: as red-integer! stack/arguments
   print ["System Call :  " int/value lf]
]

;--Second solution with Red routine
alea: routine [][
	#call [rand v]		;--Use Red/S variable
	int: as red-integer! stack/arguments
	int/value
]

v: 1000 ;--this a Red word, not the Red/S word
;--Classical Red Function
print ["Red Function: " rand v]
print ["Red Function: " rand v]
print ["Red Function: " rand v]

;--Red Routine which calls Red Function
print ["Red Routine : " alea]
print ["Red Routine : " alea]
print ["Red Routine : " alea]


