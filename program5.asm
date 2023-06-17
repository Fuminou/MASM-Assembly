

INCLUDE Irvine32.inc

MAX=200
MIN=10
HI=999
LO=100

.386
.model flat,stdcall
.stack 4096			;SS register
ExitProcess proto,dwExitCode:dword

;Name:Joon Yuan Chong
;StudentId: 934416826

;creating variables here
.data				;DS register
	intro1			BYTE	"Hello I am Joon Yuan!",0
	intro2			BYTE	"My program will generate random numbers in the range of [100-900].",0
	intro3			BYTE	"It will then display the original list and then the median value then sorts it in decending order",0
	prompt			BYTE	"Please enter a number between [10-200] and my program will generate that amount of random numbers",0
	getName			BYTE	"Please enter your name below!",0
	smallNumError	BYTE	"The number you entered is too small please try again within the range",0
	bigNumError		BYTE	"The number you entered is too big please try again within the range",0
	unsortedNum		BYTE	"These are the unsorted numbers",0
	sortedNum		BYTE	"These are the sorted numbers",0
	userNumber		DWORD	?
	count			DWORD	1
	tempNumber		DWORD	?
	writeCount		DWORD	0
	outerCmp		DWORD	?
	innerCmp		DWORD	?
	comma			BYTE	",",0
	bye1			BYTE	"Thanks for using the program!",0
	bye2			BYTE	"Have a nice day!- Joon Yuan",0
	request			DWORD	?
	array			DWORD	MAX DUP(?) ;
	buffer			DWORD	"   ", 0
	gotHere			BYTE	"GOT HERE!",0






.code				;CS register
main proc
	
	call Randomize

	call introduction

	push OFFSET request
	call getData

	push OFFSET array		;12
	push request			;8
	call fillArray

	mov EDX, OFFSET unsortedNum
	call WriteString
	call Crlf
	push OFFSET array
	push request
	call displayList



main endp

	introduction PROC


		mov	EDX, OFFSET intro1
		call	WriteString
		call	CrLf
		
		mov	EDX, OFFSET intro2
		call WriteString
		call	CrLf
	
		mov	EDX, OFFSET intro3
		call	WriteString
		call	CrLf

	ret	
	introduction ENDP

	
	getData PROC

		push EBP			; Set up the stack frame.
		mov EBP, ESP
		mov	EBX, [EBP + 8] ; get address of request into ebx


	userPrompt:
		mov	EDX, OFFSET prompt	;prompt user to enter number
		call WriteString
		call Crlf	
		call ReadInt			
		mov [EBX], EAX
		cmp EAX, MIN
		jl lowerError
		cmp EAX, MAX
		jg upperError
		jmp next

	lowerError:
		mov EDX, OFFSET smallNumError
		call WriteString
		call Crlf
		jmp userPrompt

	upperError:
		mov EDX, OFFSET bigNumError
		call WriteString
		call Crlf
		jmp userPrompt

	next:
		pop EBP

	ret	4
	getData ENDP

	fillArray	PROC
		
		push	EBP					;set up stack frame
		mov		EBP, ESP
		mov		EDI, [EBP+12]		
		mov		ECX, [EBP+8]

	fillArrayLoop:
		mov EAX, HI
		sub	EAX, LO
		inc	EAX
		call RandomRange
		add EAX, LO
		mov [ESI], EAX
		add	ESI, 4
		loop fillArrayLoop

		pop EBP
		ret 8

	fillArray	ENDP

	sortList	PROC


		ret
	sortList	ENDP

	displayMedian	PROC

	ret
	displayMedian	ENDP

	displayList		PROC

		push EBP
		mov  EBP, ESP
		mov	 EBX, 0			  ; counting to 10 for ouput
		mov  ESI, [EBP+12]  ; @list
		mov	 ECX, [ebp+8]   ; loop control based on request

	displayLoop:
		mov		EAX, [ESI]  ; get current element
		call	WriteDec
		mov		EDX, OFFSET buffer
		call	WriteString
		inc		EBX
		cmp		EBX, MIN
		jl		skipCarry
		call	CrLf
		mov		EBX,0

	skipCarry:
		add		ESI, 4		; next element
		loop	displayLoop

	endDisplayLoop:
		pop		EBP
		ret		8

	displayList		ENDP

	farewell PROC
		call Crlf
		mov	EDX, OFFSET bye1			;display goodbye message
		call WriteString

		mov EDX, OFFSET bye2
		call WriteString
		call Crlf
		exit

	farewell ENDP



	invoke ExitProcess,0

end main