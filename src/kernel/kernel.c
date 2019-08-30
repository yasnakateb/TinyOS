void main() 
{
    char* character = (char*) 0xb8000;              ///  Create a pointer  to a char , and  point it to the  first  text  cell of
                                                    ///  video  memory
    *character = 'X';                               ///  Store  the  character  ’X’

}
