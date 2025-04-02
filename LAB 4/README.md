# Commands to Run This Lab  
(Note: The labs were done on a **Windows OS**)

# Lab 4 - Abstract Syntax Tree (AST) using Lex and Yacc  

## Description  
This lab demonstrates the implementation of an **Abstract Syntax Tree (AST)** for arithmetic expressions using **Lex** and **Yacc (Bison)**. The lexer identifies tokens, while the parser constructs an AST and displays it.  

## Files Included  
- `lexer.l` - Lex file for tokenizing input  
- `parser.y` - Yacc file for parsing expressions and building AST  
- `abstract_syntax_tree.c` - Implementation of the AST structure  
- `abstract_syntax_tree.h` - Header file for AST functions  
- `lex.yy.c` - Lex-generated C file  
- `y.tab.c` - Yacc-generated C file  
- `y.tab.h` - Yacc-generated header file  
- `a.exe` - Executable file after compilation  
- `LAB4_Output.png` - Screenshot of the program output  

## Commands to Run  
```sh
flex lexer.l
bison -d parser.y
gcc lex.yy.c y.tab.c // if parser.tab files are returned just rename them to y.tab files
a.exe

# example for testing
- valid input : c=a+b+c
- invalid input : c=a+b+
