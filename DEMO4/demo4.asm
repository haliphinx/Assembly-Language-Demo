.386
STACK   SEGMENT    USE16    STACK
        DB  200  DUP(0)
STACK   ENDS
DATA    SEGMENT    USE16
X    DW   0H
Y    DW   0H
Z    DW   0H
W    DW   0H
Q    DW   12H
T    DW   0H
CASE1  DB  'T = (X - Y*Z + W)/Q > 0 $'
CASE2  DB  'T = (X - Y*Z + W)/Q = 0 $'
CASE3  DB  'T = (X - Y*Z + W)/Q < 0 $'
DATA  ENDS
CODE    SEGMENT    USE16
        ASSUME    CS:CODE,DS:DATA,SS:STACK
START:  MOV    AX,DATA
        MOV    DS,AX
	MOV    AX,Y
	IMUL   AX,Z
	SUB    X,AX
	MOV    AX,X
	ADD    AX,W
	CWD    
	MOV    BX,Q
	IDIV   BX
	LEA    EAX,T
	MOV    [EAX],AX
	MOV    [EAX+2],DX
	MOV    BX,AX
	CMP    BX,0
	JNL    L1
        LEA    DX,CASE3
        MOV    AH,9
	INT    21H
        JMP    EXIT
L1   :  CMP    BX,0
        JNZ    L2   
	LEA    DX,CASE1
        JMP    EXIT
L2   :  LEA    DX,CASE2
        MOV    AH,9
	INT    21H
EXIT :  MOV    AH,4CH
        INT    21H
CODE    ENDS
        END    START