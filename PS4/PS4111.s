ARR				DCD		85, 22, 79, 20, 1, 28, 45, 20, 6, 19, 94, 62, 38, 8, 50, 5, 13, 49, 57, 93
				ADR		R0, ARR
				
STK				DCD		19, 0
				ADR		R10, STK
				ADD		R10, R10, #4
				
QSORT
				CMP		R10, #0X1FC
				BEQ		TERMINATE
				LDR		R1, [R10]
				SUB		R10, R10, #4
				CMP		R10, #0X1FC
				BEQ		TERMINATE
				LDR		R2, [R10]
				SUB		R10, R10, #4
				CMP		R1, R2
				BGE		EOF
				
				B		PARTITION
				
AFTER_PARTITION
				LDR		R11, [R10]
				SUB		R10, R10, #4
				
				ADD		R10, R10, #4
				STR		R2, [R10]
				ADD		R11, R11, #1
				ADD		R10, R10, #4
				STR		R11, [R10]
				
				SUB		R11, R11, #2
				ADD		R10, R10, #4
				STR		R11, [R10]
				ADD		R10, R10, #4
				STR		R1, [R10]
				
				B		QSORT
				SUB		R10, R10, #8
				
EOF
				CMP		R10, #0
				BGT		QSORT
				
TERMINATE			END
				
PARTITION
				LDR		R3, [R0, R2, LSL #2]
				MOV		R11, R1
				SUB		R11, R11, #1
				
				MOV		R12, R1
				
FOR
				CMP		R12, R2
				BGE		RETURN
				
				LDR		R5, [R0, R12, LSL #2]
				CMP		R5, R3
				BGE		INC
				ADD		R11, R11, #1
				LDR		R4, [R0, R11, LSL #2]
				STR		R4, [R0, R12, LSL #2]
				STR		R5, [R0, R11, LSL #2]
				
INC
				ADD		R12, R12, #1
				B		FOR
				
RETURN
				ADD		R11, R11, #1
				LDR		R4, [R0, R11, LSL #2]
				LDR		R6, [R0, R2 , LSL #2]
				STR		R6, [R0, R11, LSL #2]
				STR		R4, [R0, R2 , LSL #2]
				
				ADD		R10, R10, #4
				STR		R11, [R10]
				B		AFTER_PARTITION
