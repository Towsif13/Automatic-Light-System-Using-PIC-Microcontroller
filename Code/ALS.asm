
_read_ldr:

;ALS.c,19 :: 		void read_ldr()
;ALS.c,21 :: 		unsigned int adc_value = 0;
;ALS.c,22 :: 		adc_value = ADC_Read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
;ALS.c,23 :: 		light = 100 - adc_value/10.24;
	CALL       _word2double+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      215
	MOVWF      R4+1
	MOVLW      35
	MOVWF      R4+2
	MOVLW      130
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	MOVF       R0+2, 0
	MOVWF      R4+2
	MOVF       R0+3, 0
	MOVWF      R4+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVLW      72
	MOVWF      R0+2
	MOVLW      133
	MOVWF      R0+3
	CALL       _Sub_32x32_FP+0
	CALL       _double2int+0
	MOVF       R0+0, 0
	MOVWF      _light+0
	MOVF       R0+1, 0
	MOVWF      _light+1
;ALS.c,24 :: 		inttostr(light,value);
	MOVF       R0+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       R0+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _value+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;ALS.c,25 :: 		lcd_out(2,1,"Light = ");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_ALS+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;ALS.c,26 :: 		lcd_out(2,9,Ltrim(value));
	MOVLW      _value+0
	MOVWF      FARG_Ltrim_string+0
	CALL       _Ltrim+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      9
	MOVWF      FARG_Lcd_Out_column+0
	CALL       _Lcd_Out+0
;ALS.c,27 :: 		Lcd_Chr_Cp('%');
	MOVLW      37
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;ALS.c,28 :: 		Lcd_Chr_Cp(' ');
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;ALS.c,29 :: 		if(light>=65) // SWITCH off the light when light is 65 percent
	MOVLW      128
	XORWF      _light+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__read_ldr6
	MOVLW      65
	SUBWF      _light+0, 0
L__read_ldr6:
	BTFSS      STATUS+0, 0
	GOTO       L_read_ldr0
;ALS.c,31 :: 		PORTB.F1=0;
	BCF        PORTB+0, 1
;ALS.c,32 :: 		}
	GOTO       L_read_ldr1
L_read_ldr0:
;ALS.c,35 :: 		PORTB.F1=1;
	BSF        PORTB+0, 1
;ALS.c,36 :: 		}
L_read_ldr1:
;ALS.c,37 :: 		}
L_end_read_ldr:
	RETURN
; end of _read_ldr

_main:

;ALS.c,38 :: 		void main()
;ALS.c,40 :: 		TRISB=0X00;
	CLRF       TRISB+0
;ALS.c,41 :: 		PORTB=0X00;
	CLRF       PORTB+0
;ALS.c,42 :: 		ADC_Init();
	CALL       _ADC_Init+0
;ALS.c,44 :: 		Lcd_Init(); // Initialize LCD
	CALL       _Lcd_Init+0
;ALS.c,45 :: 		Lcd_Cmd(_LCD_CLEAR); // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;ALS.c,46 :: 		Lcd_Cmd(_LCD_CURSOR_OFF); // Cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;ALS.c,48 :: 		Lcd_Out(1,1,"AUTOMATIC" );
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_ALS+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;ALS.c,49 :: 		Lcd_Out(2,1,"LIGHT SYSTEM" );
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_ALS+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;ALS.c,50 :: 		delay_ms(2500);
	MOVLW      26
	MOVWF      R11+0
	MOVLW      94
	MOVWF      R12+0
	MOVLW      110
	MOVWF      R13+0
L_main2:
	DECFSZ     R13+0, 1
	GOTO       L_main2
	DECFSZ     R12+0, 1
	GOTO       L_main2
	DECFSZ     R11+0, 1
	GOTO       L_main2
	NOP
;ALS.c,51 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;ALS.c,53 :: 		Lcd_Out(1,1,"LIGHT SENSOR" ); // Write text in first row
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_ALS+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;ALS.c,55 :: 		while (1)
L_main3:
;ALS.c,57 :: 		read_ldr();
	CALL       _read_ldr+0
;ALS.c,58 :: 		}
	GOTO       L_main3
;ALS.c,59 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
