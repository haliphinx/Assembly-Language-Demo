.386
STACK SEGMENT USE16 STACK
      DB 200 DUP(0)
STACK ENDS
DATA  SEGMENT USE16
BUF1  DB 80
      DB ?
      DB 80 DUP(0)
BUF2  DB 80
      DB ?
      DB 80 DUP(0)
OUT1  DB 'MATCH!',0AH,0DH,'$'
OUT2  DB 'NOT MATCH!',0AH,0DH,'$'
OUT3  DB 0AH,0DH,'$'
OUT4  DB 'PLEASE INPUT A STRING:','$'
DATA  ENDS
CODE  SEGMENT USE16
      ASSUME CS:CODE,DS:DATA,SS:STACK
START:MOV AX,DATA
      MOV DS,AX
      MOV SI,1
      LEA DX,OFFSET OUT4
      MOV AH,9
      INT 21H
      LEA DX,BUF1
      MOV AH,10
      INT 21H
      LEA DX,OFFSET OUT3
      MOV AH,9
      INT 21H
      LEA DX,OFFSET OUT4
      MOV AH,9
      INT 21H
      LEA DX,BUF2
      MOV AH,10
      INT 21H
      LEA DX,OFFSET OUT3
      MOV AH,9
      INT 21H
      MOV BL,BUF1[1]
      CMP BL,BUF2[1]
      JNE CASE1
      ADD BX,2
CMP1: INC SI
      MOV CL,BUF1[SI]
      CMP CL,BUF2[SI]
      JNE CASE1
      CMP BX,SI
      JNE CMP1
      JMP CASE2
CASE1:LEA DX,OFFSET OUT2
      MOV AH,9
      INT 21H
      JMP END1
CASE2:LEA DX,OFFSET OUT1
      MOV AH,9
      INT 21H
END1: MOV AH,4CH
      INT 21H
CODE  ENDS
      END START
