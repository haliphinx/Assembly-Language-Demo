.386
STACK SEGMENT USE16 STACK
      DB 200 DUP(0)
STACK ENDS

DATA  SEGMENT USE16
A     DB 1
BUF   DB 15 DUP(0)
OUT1  DB 'THE ASCII CODE OF $'
OUT2  DB 'IS$'
OUT3  DB  0AH,0DH,'$'
OUT4  DB 'PLEASE INPUT A CHARACTER:','$'
DATA  ENDS
CODE  SEGMENT USE16
      ASSUME CS:CODE,DS:DATA,SS:STACK
START:MOV  AX,DATA
      MOV  DS,AX
      MOV  ECX,0

      LEA  DX,OUT4
      MOV  AH,9
      INT  21H

      MOV  AH,1
      INT  21H
      MOV  A,AL
      mov  CL,AL

      LEA  DX,OUT3
      MOV  AH,9
      INT  21H

      MOV  EAX,ECX
      MOV  EBX,16
      LEA  SI,BUF
      CALL RADIX
      MOV  BYTE PTR [SI],'$'
      LEA  DX,OUT1
      MOV  AH,9
      INT  21H

      MOV  DL,A
      MOV  AH,2
      INT  21H

      MOV  DL,' '
      MOV  AH,2
      INT  21H

      LEA  DX,OUT2
      MOV  AH,9
      INT  21H

      MOV  DL,' '
      MOV  AH,2
      INT  21H

      LEA  DX,BUF
      MOV  AH,9
      INT  21H

      MOV  DL,'H'
      MOV  AH,2
      INT  21H
      
      MOV  DL,' '
      MOV  AH,2
      INT  21H

      MOV  DL,'('
      MOV  AH,2
      INT  21H

      MOV  EAX,ECX
      MOV  EBX,10
      LEA  SI,BUF
      CALL RADIX
      MOV  BYTE PTR [SI],'$' 
      
      LEA  DX,BUF
      MOV  AH,9
      INT  21H

      MOV  DL,')'
      MOV  AH,2
      INT  21H
      
      MOV  AH,4CH
      INT  21H
RADIX PROC
      PUSH  CX
      PUSH  EDX
      XOR   CX,CX
LOP1: XOR   EDX,EDX
      DIV   EBX
      PUSH  DX
      INC   CX
      OR    EAX,EAX
      JNZ   LOP1
LOP2: POP   AX
      CMP   AL,10
      JB    L1
      ADD   AL,7
L1:   ADD   AL,30H
      MOV   [SI],AL
      INC   SI
      LOOP  LOP2
      POP   EDX 
      POP   CX
      RET
RADIX ENDP
CODE  ENDS
      END START
