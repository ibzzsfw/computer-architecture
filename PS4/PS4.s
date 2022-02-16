		;
		;		PS4.s
		;
		;		Created by suppakorn rakna (1061), pakamon trakarnkittikul (1055) on 13/2/2565 BE.
		;

STACK	DCD		0, 6 ; parameter of stack filled with initial end point, default LEFT and default RIGHT,.
		ADR		R8, STACK
		ADD		R8, R8, #8 ; contain 2 words

ARR		DCD		17, 14, 65, 4, 22, 63, 11
		ADR		R0, ARR 
		;		we decide to use inplace swap (inside the register so, we do not want top index pointer in this case.)
		
QUICKSORT ;		= (ARR, LEFT, RIGHT) => none return
		LDR		R1, [R8] ; LOAD LEFT
		SUB		R8, R8, #4
		LDR		R2, [R8] ; LOAD RIGHT
		CMP		R1, R2 ; LEFT < RIGHT ?
		BGE		ENDQUICKSORT ; IF NOT EXPECTED CASE, JUMP TO END OF THE SUBROUTINE
		
		B		PARTITION ; Hoare Partition
		
AFTERPARTITION
		;		set up to operate quick sort RHS of PIVOT
		; 		Note that we push RIGHT end point before LEFT end point because of structure of STACK; FIFO.
		ADD		R8, R8, #4 
		STR		R2, [R8]
		ADD		R12, R12, #1 ; RIGHT
		ADD		R8, R8, #4
		STR		R12, [R8] ; PIVOT+1
		B		QUICKSORT ; (ARR[PIVOT+1...RIGHT])
		; 		set up to operate quick sort LHS of PIVOT
		SUB		R12, R12, #2 ; +1 -> -1 == -2
		ADD		R8, R8, #4
		STR		R12, [R8] ; PIVOT-1
		ADD		R8, R8, #4
		STR		R1, [R8] ; LEFT
		B		QUICKSORT ; (ARR[LEFT...PIVOT-1])
		SUB		R8, R8, #4 ; POP j out of STACK after using in each fraction of sort
		
ENDQUICKSORT

		SUB		R8, R8, #8 ; POP used parameter out of STACK; sub-LEFT|RIGHT 
		CMP		R8, #0 ; check if parameter stack empty or not?
		BLT		QUICKSORT ; jump to sort if there're remain

END 	; 		stop emulator
		
		
PARTITION ; 	= (ARR, LEFT, RIGHT) => j ; PUSH into parameter STACK

		LDR		R3, [R0, R1, LSL #2] ; PIVOT = ARR[LEFT]
		MOV		R11, R1 ; i = LEFT
		MOV		R12, R2 ; j = RIGHT
		ADD		R12, R12, #1 ; j = RIGHT + 1
		
REPEAT

ISLIDE	; 		move i from left to right
		ADD		R11, R11, #1 ; i++
		LDR		R4, [R0, R11, LSL #2] ; LOAD ARR[i]
		CMP		R4, R3 ; ARR[i] >= PIVOT ?
		BLT		ISLIDE ; if FALSE, loop
		
JSLIDE	; 		move j from right to left
		SUB		R12, R12, #1 ; j--
		LDR		R5, [R0, R12, LSL #2] ; LOAD ARR[j]
		CMP		R5, R3 ; ARR[j] <= PIVOT ?
		BGT		JSLIDE ; if FALSE, loop
		; 		swap ARR[i], ARR[j]
		STR		R4, [R0, R12, LSL #2]
		STR		R5, [R0, R11, LSL #2]
		CMP		R11, R12 ; i >= j ?
		BLT		REPEAT
		; 		UNDO last swap
		LDR		R4, [R0, R11, LSL #2]
		LDR		R5, [R0, R12, LSL #2]
		STR		R4, [R0, R12, LSL #2]
		STR		R5, [R0, R11, LSL #2]
		; 		swap ARR[LEFT], ARR[j]
		LDR		R5, [R0, R12, LSL #2]
		STR		R3, [R0, R12, LSL #2]
		STR		R5, [R0, R1 , LSL #2]
		
		ADD		R8, R8, #4
		; 		NOW WE HAVE RETURN VALUE OF j
		LDR		R12, [R8]
		B		AFTERPARTITION

ENDOFPARTITION