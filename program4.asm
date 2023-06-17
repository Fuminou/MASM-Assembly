

INCLUDE Irvine32.inc

.386
.model flat,stdcall
.stack 4096			;SS register
ExitProcess proto,dwExitCode:dword

;Name:Joon Yuan Chong
;StudentId: 934416826

;creating variables here
.data				;DS register
	intro1			BYTE	"Hello I am Joon Yuan!",0
	instructions	BYTE	"Please enter a number and my program will convert those numbers in miles to kilometers, farenheit to celcius, seconds to minutes, inches to feet, weeks to days, and mililiters to liters",0
	getName			BYTE	"Please enter your name below!",0
	userName		BYTE	20 DUP(?)
	nameLength		DWORD	?
	getMiles		BYTE	"Enter the distance in miles that you want to convert in kilometers:",0
	getFahrenheit	BYTE	"Now enter the temperature in Fahrenheit that you want to convert in Celsius:",0
	getExtraCredit	BYTE	"Next enter the time in seconds that you want to convert to minutes:",0
	getInches		BYTE	"Next enter the length in inches that you want to convert to feet:",0
	getWeeks		BYTE	"Next enter the number of weeks that you want to convert to days:",0
	getMililiter		BYTE	"Lastly enter the number of mililiters that you want to convert to liters:",0
	displayKilometer1	BYTE	"The conversion for ",0
	displayKilometer2	BYTE	" miles in kilometer is ",0
	displayCelcius1	BYTE	"The conversion for ",0
	displayCelcius2	BYTE	" farenheit in celcius is ",0
	displayExtraCredit1	BYTE	"The conversion for ",0
	displayExtraCredit2	BYTE	" seconds to minutes is ",0
	displayFeet1	BYTE	"The conversion for ",0
	displayFeet2	BYTE	" inches to feet is ",0
	displayDays1	BYTE	"The conversion for ",0
	displayDays2	BYTE	" weeks in days is ",0
	displayLiter1	BYTE	"The conversion for ",0
	displayLiter2	BYTE	" mililiters in liters is ",0
	userMiles		REAL8	?
	userFahrenheit	REAL8	?
	userExtraCredit	REAL8	?
	userInches		REAL8	?
	userWeeks		REAL8	?
	userMililiter	REAL8	?
	answerKilometer	REAL8	?
	answerCelsius	REAL8	?
	answerExtraCredit	REAL8	?
	answerFeet		REAL8	?
	answerDays		REAL8	?
	answerLiter		REAL8	?
	milesToKmNumber	REAL8	1.60934
	seven			REAL8	7.0
	five			REAL8	5.0
	nine			REAL8	9.0
	thirtytwo		REAL8	32.0
	sixty			REAL8	60.0
	feetConvert		REAL8	0.083
	thousand		REAL8	1000.0
	displayName1	BYTE	"Welcome to my program ",0
	displayName2	BYTE	"!",0
	bye1			BYTE	"Thanks for using the program ",0
	bye2			BYTE	" ! Have a nice day!",0



.code				;CS register
main proc
	FINIT

	introduction:
		mov	EDX, OFFSET intro1		;display welcome message		
		call WriteString
		call Crlf

	getUserData:
		mov EDX, OFFSET getName		;ask user to enter name
		call WriteString
		call Crlf

		mov EDX, OFFSET userName	;get users name
		mov ECX, 20
		call ReadString

	displayUserOutput:
		mov EDX, OFFSET displayName1	;display hello message and greet user
		call WriteString
		mov EDX, OFFSET userName
		call WriteString
		mov EDX, OFFSET displayName2
		call WriteString
		call Crlf
		mov EDX, OFFSET instructions
		call WriteString
		call Crlf

	getUserMiles:						;get users input in miles
		mov EDX, OFFSET getMiles
		call WriteString
		call Crlf
	
		call ReadFloat
		FSTP userMiles

	getUserFahrenheit:					;get users input in fahrenheit
		mov EDX, OFFSET getFahrenheit
		call WriteString
		call Crlf
	
		call ReadFloat
		FSTP userFahrenheit

	getUserExtraCredit:					;get users input in seconds
		mov EDX, OFFSET getExtraCredit
		call WriteString
		call Crlf
	
		call ReadFloat
		FSTP userExtraCredit

	getUserInches:						;get users input in inches
		mov EDX, OFFSET getInches
		call WriteString
		call Crlf
	
		call ReadFloat
		FSTP userInches

	getUserWeeks:						;get users input in weeks
		mov EDX, OFFSET getWeeks
		call WriteString
		call Crlf
	
		call ReadFloat
		FSTP userWeeks

	getUserMililiter:						;get users input in mililiters
		mov EDX, OFFSET getMililiter
		call WriteString
		call Crlf
	
		call ReadFloat
		FSTP userMililiter


	convertToKm:					;convert miles to kilometer
		FLD userMiles
		FLD	milesToKmNumber
		FMUL
		FSTP answerKilometer
		

	convertToCelsius:				;converting fahrenheit to celsius
		FLD five
		FLD	nine
		FDIV
		FLD userFahrenheit
		FLD thirtytwo
		FSUB
		FMUL
		FSTP answerCelsius

	convertToExtraCredit1:			;converting seconds to minutes
		FNINIT
		FLD	userExtraCredit
		FLD	sixty
		FDIV
		FST	answerExtraCredit

	convertToInches:				;converting inches to feet
		FNINIT
		FLD	userInches
		FLD	feetConvert
		FMUL
		FST	answerFeet

	convertToWeeks:				;converting weeks to days
		FNINIT
		FLD	userWeeks
		FLD	seven
		FMUL
		FST	answerDays

	convertToLiter:				;converting mililiters to liters
		FNINIT
		FLD	userMililiter
		FLD	thousand
		FDiv
		FST	answerLiter
		
		

	displayConvertedData:
		FNINIT
		mov EDX, OFFSET displayKilometer1	
		call WriteString
	
		FLD userMiles
		call WriteFloat						

		mov EDX, OFFSET displayKilometer2
		call WriteString

		FLD answerKilometer					;this section displays the kilometer output
		call WriteFloat
		call Crlf

		FNINIT
		mov EDX, OFFSET displayCelcius1
		call WriteString

		FLD userFahrenheit
		call WriteFloat

		mov EDX, OFFSET displayCelcius2
		call WriteString

		FLD answerCelsius					;this section displays the celcius output
		call WriteFloat
		call Crlf

		FNINIT
		mov EDX, OFFSET displayExtraCredit1
		call WriteString

		FLD userExtraCredit
		call WriteFloat

		mov EDX, OFFSET displayExtraCredit2	;this section displays the minutes output
		call WriteString

		FLD answerExtraCredit
		call WriteFloat
		call Crlf

		FNINIT
		mov EDX, OFFSET displayFeet1
		call WriteString

		FLD userInches
		call WriteFloat

		mov EDX, OFFSET displayFeet2	;this section displays the feet output
		call WriteString

		FLD answerFeet
		call WriteFloat
		call Crlf

		FNINIT
		mov EDX, OFFSET displayDays1
		call WriteString

		FLD userWeeks
		call WriteFloat

		mov EDX, OFFSET displayDays2	;this section displays the days output
		call WriteString

		FLD answerDays
		call WriteFloat
		call Crlf

		FNINIT
		mov EDX, OFFSET displayLiter1
		call WriteString

		FLD userMililiter
		call WriteFloat

		mov EDX, OFFSET displayLiter2	;this section displays the liters output
		call WriteString

		FLD answerLiter
		call WriteFloat
		call Crlf


	farewell:
		mov	EDX, OFFSET bye1			;display goodbye message
		call WriteString

		mov EDX, OFFSET userName		;display users name
		call WriteString

		mov EDX, OFFSET bye2
		call WriteString
		call Crlf



	invoke ExitProcess,0
main endp
end main