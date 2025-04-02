# Commands to Run This Lab  
(Note: The labs were done on a **Windows OS**)

# Lab 5 - Intermediate Code Generation (ICG) using Lex and Yacc    
This lab demonstrates the implementation of **Intermediate Code Generation (ICG)** using **quadruples** for arithmetic expressions with **Lex** and **Yacc (Bison)**.  
The `quad_code_gen` function in `quad_generation.c` generates **three-address code (TAC)** in quadruple format.

## Files Included  
- `lexer.l` - Lex file for tokenizing input  
- `parser.y` - Yacc file for parsing expressions and generating intermediate code  
- `quad_generation.c` - Implementation of quadruple generation  
- `quad_generation.h` - Header file for `quad_generation.c`  
- `lex.yy.c` - Lex-generated C file  
- `y.tab.c` - Yacc-generated C file  
- `y.tab.h` - Yacc-generated header file  
- `icg_quad.txt` - Output file containing the generated intermediate code  
- `a.exe` - Executable file after compilation  
- `LAB5_Output.png` - Screenshot of the program output  

## Commands to Run  
```sh
flex lexer.l
bison -d parser.y
gcc lex.yy.c y.tab.c // if parser.tab files are returned just rename them to y.tab files before running this
a.exe

# example for testing
- valid input : c=a+b+c
- invalid input : c=a+b+
