MOV    R0, #0        ; Copy 0 to register R0
MOV    R1, #0        ; Copy 0 to register R1
MOV    R2, #1        ; Copy 1 to register R2
MOV    R3, #1        ; Copy 1 to register R3
LOOP                ; Start looping
ADD    R0, R1, R2    ; Add R1 with R2 then store in R0
MOV    R1, R2        ; Moving value of R2 to R1
MOV    R2, R0        ; Moving value of R0 to R2
ADD    R3, R3, #1    ; Adding value of R3 by 1
CMP    R3, #44        ; Compare R3 with 44
BLT    LOOP        ; Braching if the Compare gives less than
