

INCLUDE Irvine32.inc

.386
.model flat,stdcall
.stack 4096			;SS register
ExitProcess proto,dwExitCode:dword

;creating variables here
.data				;DS register
	intro1			BYTE	"Hello I am Joon Yuan!",0
	instructions	BYTE	"Please enter a number between the range of [1,46] and we will display that number of fibbonachi terms",0
	errorMessage	BYTE	"The number you entered is not in the range of [1,46]! Please try again",0
	getName			BYTE	"Please enter your name below!",0
	userName		BYTE	20 DUP(?)
	userNumber		DWORD	?
	nameLength		DWORD	?
	displayName1	BYTE	"Welcome to my program ",0
	displayName2	BYTE	"!",0
	prompt1			BYTE	"Please enter the first number.",0
	prompt2			BYTE	"Please enter the second number.",0
	outro1			BYTE	"Hi ",0
	num1			DWORD	?
	bye1			BYTE	"Thanks for using the program! Have a nice day!",0
	loopnum			DWORD	?


.code				;CS register
main proc

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

	displayUserHello:
		mov EDX, OFFSET displayName1	;display hello message and greet user
		call WriteString
		mov EDX, OFFSET userName
		call WriteString
		mov EDX, OFFSET displayName2
		call WriteString
		call Crlf
		jmp userInstructions		;jump to userInstructions

	userInstructionsError:
		mov EDX, OFFSET errorMessage	;display error message
		call WriteString
		call Crlf

	userInstructions:
		mov EDX, OFFSET instructions	;display instructions to user
		call WriteString
		call Crlf


	firstCompare:					;check the number to see if it is less than 1
		call ReadInt
		cmp EAX, 1
		mov userNumber, EAX
		jl  userInstructionsError
					
	secondCompare:					;check the number to see if it is more than 46
		mov EAX, userNumber
		cmp EAX, 46
		jg userInstructionsError

	ifNumIsOne:						;check if userNumber is 1 and jump to displayOne if it is
		mov EAX, userNumber
		cmp EAX, 1
		je displayOne

	ifNumIsTwo:						;check if userNumber is 1 and jump to displayTwo if it is
		mov EAX, userNumber
		cmp EAX, 2
		je displayTwo

	ifNumIsMoreThanTwo:				;check if the number is more than two then subtract 2 from the number if it is more than two
		mov EAX, userNumber
		cmp EAX, 2
		mov EAX, userNumber
		sub EAX, 2
		mov userNumber, EAX
		jmp displayFibs				;jump to displayFibs

	displayOne:						;display first term from fibbonachi sequence
		mov EAX,0
		call WriteInt
		call Crlf
		jmp farewell

	displayTwo:						;display first two terms from fibbonachi sequence
		mov EAX,0
		call WriteInt
		call Crlf
		mov EAX, 1
		call WriteInt
		call Crlf
		mov EAX, 0
		mov EBX, 1
		mov EDX, 1
		jmp farewell

	displayFibs:					;display first two terms from fibbonachi sequence then add loop counter
		mov EAX,0
		call WriteInt
		call Crlf
		mov EAX, 1
		call WriteInt
		call Crlf
		mov EAX, 0
		mov EBX, 1
		mov EDX, 1
		mov ECX, userNumber

		
	loopFibs:						;display next terms for fibbonachi sequence until counter reaches zero
		add EBX, EDX
		mov EAX, EBX
		call WriteInt
		call Crlf
		mov EBX, EDX
		mov EDX, EAX
		loop loopFibs

	farewell:
		mov	EDX, OFFSET bye1			;display goodbye message
		call WriteString
		call Crlf



	invoke ExitProcess,0
main endp
end main