.MODEL SMALL
.STACK 100H

.DATA
 MSZ1 DB 'PRESS 1 TO ADD',0DH,0AH
     DB 'PRESS 2 TO SUBTRACT',0DH,0AH
     DB 'PRESS 3 TO MULTIPLY',0DH,0AH
     DB 'PRESS 4 TO DIVIDE',0DH,0AH
     DB 'PRESS 5 TO TERMINATE',0DH,0AH,'$'
ENTER DB 0DH,0AH,'$'
MSZ2 DB 'ENTER THE TWO NUMBERS : $'
MSZ3 DB 0DH,0AH,'RESULT OF ADDITION : $'
MSZ4 DB 0DH,0AH,'RESULT OF SUBTRACTION : $'
MSZ5 DB 0DH,0AH,'RESULT OF MULTIPLICATION : $'
MSZ6 DB 0DH,0AH,'RESULT OF DIVISION : $'
COUNT1 DW 0
COUNT2 DW 0
FLAG DW 0
A DW ?
B DW ?
C DB ?
.CODE

MAIN PROC
   MOV AX,@DATA
    MOV DS,AX     
    
   ; MOV AH,1
   ; INT 21H 
    
    
;    CALL INDEC
 ;   
  ;  PUSH AX 
    
 ;    MOV AH, 2
  ;  MOV DL, 0Dh
   ; INT 21h
    
  ;  MOV DL, 0Ah
  ;  INT 21h
    
   ;  POP AX
     
   ; CALL OUTDEC
    
     PROMPT:
    
    MOV AH,9
    LEA DX,MSZ1
    INT 21H
    
    MOV AH,1
    INT 21H
    SUB AL,48
    MOV C,AL
    MOV AH,9 
    LEA DX,ENTER
    INT 21H
    
    MOV AL,C
    CMP AL,1
    JE ADDITION
    CMP AL,2
    JE SUBTRACTION
    CMP AL,3
    JE MULTIPLICATION
    CMP AL,4
    JE DIVISION
    CMP AL,5
    JE END_PROC
    
    ADDITION:
           
           
     CALL INDEC
     MOV A,AX 
     
     MOV AH, 2
    MOV DL, 0Dh
    INT 21h
    
    MOV DL, 0Ah
    INT 21h
   
     
     
     CALL INDEC 
     MOV B,AX
     ADD AX,A  
     PUSH AX
      MOV AH, 2
    MOV DL, 0Dh
    INT 21h
    
    MOV DL, 0Ah
    INT 21h
    POP AX
   
    CALL OUTDEC 
           
    MOV AH, 2
    MOV DL, 0Dh
    INT 21h
    
    MOV DL, 0Ah
    INT 21h
         
           
           
           
           
    
    JMP PROMPT 
    
    SUBTRACTION:  
    
    
    
 CALL INDEC
     MOV A,AX 
     
     MOV AH, 2
    MOV DL, 0Dh
    INT 21h
    
    MOV DL, 0Ah
    INT 21h
   
     
     
     CALL INDEC 
     MOV B,AX
     SUB AX,A
     NEG AX  
     PUSH AX
      MOV AH, 2
    MOV DL, 0Dh
    INT 21h
    
    MOV DL, 0Ah
    INT 21h
    POP AX
   
    CALL OUTDEC 
           
    MOV AH, 2
    MOV DL, 0Dh
    INT 21h
    
    MOV DL, 0Ah
    INT 21h
        
    
    
    JMP PROMPT
    
    MULTIPLICATION:
    
    
    
    
    
    
    
     CALL INDEC
     MOV A,AX 
     
     MOV AH, 2
    MOV DL, 0Dh
    INT 21h
    
    MOV DL, 0Ah
    INT 21h
   
     
     
     CALL INDEC 
     
     IMUL A
     
     
     
     
   ;  MOV B,AX
   ;  ADD AX,A 
     
     
      
     PUSH AX
      MOV AH, 2
    MOV DL, 0Dh
    INT 21h
    
    MOV DL, 0Ah
    INT 21h
    POP AX
   
    CALL OUTDEC 
           
    MOV AH, 2
    MOV DL, 0Dh
    INT 21h
    
    MOV DL, 0Ah
    INT 21h
    

    
    JMP PROMPT
    
    DIVISION:
    
    
    
    JMP PROMPT
    
    
    
    END_PROC:
    
   
    
    
           
    
    MOV AH, 4CH
    INT 21H           
  
 
  
                
MAIN ENDP


;Program Listing PGM~_ 1.ASM ·
 OUTDEC  PROC
 ;prints AX as a signed decimal integer
; input: AX
 ;output: none
 PUSH AX
 PUSH BX
 PUSH  CX
 PUSH   DX
 ;if AX"< o·
 OR AX,AX      ;AX<0?
JGE  @END_IF1   ;NO, >0
 
 ;then

 
  PUSH AX ; SAVE NUMBER
  MOV DL,'-'              ; GET '-'
  MOV AH,2              ; PRINT CHGAR FUNCTION
  INT 21H
  POP AX               ;GET AX BACK
  NEG AX              ;AX=-AX

 @END_IF1:

; GET DECIMAL DIGITS


	XOR CX,CX
	MOV BX,10D
	
@REPEAT1:
		XOR DX,DX
		DIV BX
		PUSH DX
		INC CX
;UNTIL
		OR AX,AX
		JNE @REPEAT1		;NO , KEEP GOIJNG
		
;CONVERT DIGITS TO CHARACTYERS AND PROINT

		MOV AH,2

;FOR COUNT TIMES DO 

@PRINT_LOOP:
		POP DX
		OR DL,30H
		INT 21H
		LOOP @PRINT_LOOP

;END FOR 
		POP DX
		POP CX
		POP BX
		POP AX
		RET
OUTDEC ENDP







   


INDEC PROC
; READS A NUMBER IN BETWEEN -32768 TOI 32767
;INPUT NONE
;OUTPUT AX=BINARY EQUIVALENT OF NUMBER 


		PUSH BX			;SAVE REGISTERS USED
		PUSH CX	
		PUSH DX
; PRINBT PROMPT

@BEGIN:
		
;TOTAL=0
		XOR BX,BX
;NEGETAIVE =FALSE
		XOR CX,CX
;READ A CHARACTER
		MOV AH,1
		INT  21H  		;CHARACTERIN AL
;CASE CHARACTER OF

		CMP AL,'-'		;- SIGN?
		JE @MINUS
		CMP AL,'+'		;PLIS SIGN
		JE @PLUS		;YES , GET ANOTHER CHARACTER
		JMP @REPEAT2		;START PROCESSING CHARACTER
@MINUS:
		MOV CX,1		;NEGETIVE =TRUE
@PLUS:
		INT 21H			;READ A CHARACTER
;END CASE
@REPEAT2:
;IF CHARACTERIS BETWEEN 0 AND 9 
		CMP AL,'0'			;CHARACTER IS GREATER THAN EQUAL 0
		JNGE @NOT_DIGIT		;ILLEGAL CHARACTER
		CMP AL,'9'			;CHARACTERIS LES THAN EQUAL 9
		JNLE @NOT_DIGIT		;NO,ILLEGAL CHARACTER
;THEN CONVERT CHARACTERINTO A DIGIT
		AND AX,000FH		;CONVERT TO DIGIT
		PUSH AX
;TOTAL=TOTAL*10+DIGIT
		MOV AX,10		;GET 10
		MUL BX		;AX=TOTOAL *10
		POP BX		;RETRIVE DIGIT
		ADD BX,AX	;TOTAL=TOTAL*10+DIGIT
;READ A CHARACTER
		MOV AH ,1
		INT 21H
		CMP AL,0DH		;CARRIAGE RETURN?
		JNE @REPEAT2	;NO , KEEP GOING
;UNTILL CR
		MOV AX,BX		;STORE NUMBER IN AX
;IF NEGETIVE 
		OR CX,CX		;NEGATIVE NUMBER
		JE @EXIT		;NO,EXIT
;THEN
		NEG AX			;YES,NEGATE
;ENDIF
@EXIT:
		POP DX			;MOVE REGISTERS
		POP CX
		POP BX
		RET
@NOT_DIGIT :
		MOV AH,2		;MOVE CURSOR TO A NEW LINE
		MOV DL,0DH
		INT 21H
		MOV DL,0AH
		INT 21H
		JMP @BEGIN		;GO TO BEGINING
INDEC ENDP
		




END MAIN