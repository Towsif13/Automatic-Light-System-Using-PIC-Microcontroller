#line 1 "C:/Users/Towsif/Desktop/Automatic Light System/Code/ALS.c"

sbit LCD_RS at RD2_bit;
sbit LCD_EN at RD3_bit;
sbit LCD_D4 at RD4_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D7 at RD7_bit;

sbit LCD_RS_Direction at TRISD2_bit;
sbit LCD_EN_Direction at TRISD3_bit;
sbit LCD_D4_Direction at TRISD4_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D7_Direction at TRISD7_bit;

char value[7];

int light;
void read_ldr()
{
 unsigned int adc_value = 0;
 adc_value = ADC_Read(0);
 light = 100 - adc_value/10.24;
 inttostr(light,value);
 lcd_out(2,1,"Light = ");
 lcd_out(2,9,Ltrim(value));
 Lcd_Chr_Cp('%');
 Lcd_Chr_Cp(' ');
 if(light>=65)
 {
 PORTB.F1=0;
 }
 else
 {
 PORTB.F1=1;
 }
}
void main()
{
 TRISB=0X00;
 PORTB=0X00;
 ADC_Init();

 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);

 Lcd_Out(1,1,"AUTOMATIC" );
 Lcd_Out(2,1,"LIGHT SYSTEM" );
 delay_ms(2500);
 Lcd_Cmd(_LCD_CLEAR);

 Lcd_Out(1,1,"LIGHT SENSOR" );

 while (1)
 {
 read_ldr();
 }
}
