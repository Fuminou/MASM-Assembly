

INCLUDE Irvine32.inc

.386
.model flat,stdcall
.stack 4096			;SS register
ExitProcess proto,dwExitCode:dword

;creating variables here
.data				;DS register
	intro1	BYTE	"Hello I am Joon Yuan!",0
	intro2  BYTE	"Please enter two numbers and my program will calculate the sum, difference, product, (integer) quotient and remainder of the numbers.",0
	prompt1 BYTE	"Please enter the first number.",0
	prompt2 BYTE	"Please enter the second number.",0
	outro1	BYTE	"Hi ",0
	outro2	BYTE	"Here are the values of the sum, difference, product, (integer) quotient and remainder of the numbers you entered.",0
	num1	DWORD	?
	num2	DWORD	?
	sum 	DWORD	?
	dif		DWORD	?
	pro		DWORD	?
	quo		DWORD	?
	rem		DWORD	?
	bye1	BYTE	"Thanks for playing! Have a nice day!",0
	temp1	BYTE	"Here is the value of the sum",0
	temp2	BYTE	"Here is the value of the dif",0
	temp3	BYTE	"Here is the value of the product",0
	temp4	BYTE	"Here is the value of the division",0
	temp5	BYTE	"Here is the value of the remainder",0
	looper	BYTE	"Please enter 1 if you wish to exit the program. You may choose any other number if u wish to continue",0
	warning	BYTE	"Please ensure that the second number is smaller or equal to the first number!",0
	loopnum	DWORD	?


.code				;CS register
main proc

	Introduction:
		mov	EDX, OFFSET intro1		;display welcome message		
		call WriteString
		call Crlf
		mov EDX, OFFSET intro2		;tell user how the program works
		call WriteString
		call Crlf
		mov EDX, OFFSET looper		;ask user if they want to exit the program
		call WriteString
		call Crlf
		call ReadInt
		mov loopnum, EAX
		cmp EAX,1
		jne Get_number1
		jmp Good_bye

	Get_number1:
		mov	EDX, OFFSET prompt1			;prompt user to input first number	
		call WriteString
		call Crlf
		mov EDX, OFFSET warning			;tell user to keep the second number smaller or equal to the first number
		call WriteString
		call Crlf
		call ReadInt
		mov num1, EAX;add user prompt to num1

	Get_number2:
		mov	EDX, OFFSET prompt2			;prompt user to input second number
		call WriteString
		call Crlf
		call ReadInt
		mov num2, EAX;add user prompt to num2
		mov EAX, num1
		cmp EAX, num2
		jl Get_number1


	Calculate_sum:
		mov EAX, num1		;move num1 to eax register
		mov EBX, num2		;move num2 to ebx register
		add EAX, EBX		;perform addition
		mov sum, EAX		;move value into sum variable
		mov EDX, OFFSET temp1
		call WriteString
		call Crlf
		mov EDX, sum
		call WriteDec
		call Crlf

	Calculate_dif:
		mov EAX, num1		;move num1 to eax register
		mov EBX, num2		;move num2 to ebx register
		sub EAX, EBX		;perform subtraction
		mov EDX, OFFSET temp2
		call WriteString
		call Crlf
		mov EDX,dif			;move value into dif variable
		call WriteDec
		call Crlf

	Calculate_pro:
		mov EAX, num1		;move num1 to eax register
		mov EBX, num2		;move num1 to eax register
		mul EBX				;perform subtraction
		mov EDX, OFFSET temp3
		call WriteString
		call Crlf
		mov EDX,pro			;move value into pro variable
		call WriteDec
		call Crlf

	Calculate_quotient:
		mov EDX,0
		mov EAX, num1		;move num1 to eax register
		mov EBX, num2		;move num1 to eax register
		div EBX				;perform division
		mov EBX,quo
		mov EDX, OFFSET temp4
		call WriteString
		call Crlf
		mov EDX,quo
		call WriteDec		;display quotient
		call Crlf

	Calculate_remainder:
		mov EDX,0
		mov EAX, num1		;move num1 to eax register
		mov EBX, num2		;move num1 to eax register
		div EBX				;perform division
		mov EAX,EDX			;move edx value to eax
		mov EDX,rem
		mov EDX, OFFSET temp5
		call WriteString
		call Crlf
		;mov EAX,EDX		;move edx value to eax
		mov EDX,rem
		call WriteDec		;display remainder
		call Crlf
		jmp Introduction


	Good_bye:
		mov	EDX, OFFSET bye1				
		call WriteString
		call Crlf



	invoke ExitProcess,0
main endp
end main