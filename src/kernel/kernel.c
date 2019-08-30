#include "../../include/kernel/kernel.h"

/*
 * 16 bit video buffer elements(register ax)
 * 8 bits(ah) higher : 
 * Lower 4 bits - forec olor
 * Higher 4 bits - back color
 * 8 bits(al) lower :
 * 8 bits : ASCII character to print
 */
uint16 vga_entry(unsigned char ch, uint8 fore_color, uint8 back_color) 
{
    uint16 ax = 0;            
    uint8 ah = 0, al = 0;      
    ah = back_color;            
    ah |= fore_color;            
    ax = ah;                      
    ax <<= 8;                      
    al = ch;
    ax |= al;
    return ax;                  
}

/* 
 * Clear video buffer array 
 */                                                                       
void clear_vga_buffer(uint16 **buffer, uint8 fore_color, uint8 back_color)
{
    uint32 i;
    for(i = 0; i < BUFSIZE; i++)   
    {
        (*buffer)[i] = vga_entry(NULL, fore_color, back_color);
    }
}

/*
 * Initialize vga buffer
 */
void init_vga(uint8 fore_color, uint8 back_color)
{
    vga_buffer = (uint16*)VGA_ADDRESS;                        // Point vga_buffer pointer to VGA_ADDRESS 
    clear_vga_buffer(&vga_buffer, fore_color, back_color);    // Clear buffer
}


void main()
{
  
    init_vga(COLOR_BLACK, COLOR_WHITE);
  
    vga_buffer[0] = vga_entry('H', COLOR_RED, COLOR_BLACK);
    vga_buffer[1] = vga_entry('a', COLOR_RED, COLOR_BLACK);
    vga_buffer[2] = vga_entry('v', COLOR_RED, COLOR_BLACK);
    vga_buffer[3] = vga_entry('e', COLOR_RED, COLOR_BLACK);
    vga_buffer[4] = vga_entry(' ', COLOR_WHITE, COLOR_BLACK);
    vga_buffer[5] = vga_entry('F', COLOR_CYAN, COLOR_BLACK);
    vga_buffer[6] = vga_entry('u', COLOR_CYAN, COLOR_BLACK);
    vga_buffer[7] = vga_entry('n', COLOR_CYAN, COLOR_BLACK);
    vga_buffer[8] = vga_entry(' ', COLOR_WHITE, COLOR_BLACK);
    vga_buffer[9] = vga_entry('Y', COLOR_MAGENTA, COLOR_BLACK);
    vga_buffer[10] = vga_entry('a', COLOR_MAGENTA, COLOR_BLACK);
    vga_buffer[11] = vga_entry('s', COLOR_MAGENTA, COLOR_BLACK);
    vga_buffer[12] = vga_entry('n', COLOR_MAGENTA, COLOR_BLACK);
    vga_buffer[13] = vga_entry('a', COLOR_MAGENTA, COLOR_BLACK);

}

