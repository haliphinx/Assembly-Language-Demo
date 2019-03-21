.386
STACK SEGMENT USE16 STACK
      DB 200 DUP(0)
STACK ENDS
CODE  SEGMENT USE16
      ASSUME CS:CODE,SS:STACK
START:MOV AX,0
      DEC AX
      ADD AX,07FFFH
      ADD AX,2
      NOT AX             
      SUB AX,0FFFFH
      ADD AX,8000H
      OR  AX,0BFDFH     
      AND AX,0EBEDH     
      XCHG AH,AL        
      SAL AX,1          
      RCL AX,1          
      MOV AH,4CH
      INT 21H
CODE  ENDS
      END START
