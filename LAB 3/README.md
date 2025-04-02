# Commands to Run This Lab  
(Note: The labs were done on a **Windows OS**)

# Lab 3 - Lex & Yacc: Syntax Analysis with Symbol Table 
This lab demonstrates **syntax analysis** using **Lex (Flex) and Yacc (Bison)**.  
It parses variable declarations, assignments, expressions, and function definitions, while also integrating a **symbol table** for tracking variables and values.
It also has **Error Handling** which detects undeclared variables, type mismatches, and division by zero.

## Files Included  
- **`l_lab3.l`** - Lex file for lexical analysis (tokenizing input).  
- **`par077.y`** - Yacc file for syntax parsing and validation.  
- **`sym_tab3.c` & `sym_tab.h`** - Symbol table implementation.  
- **`par077.tab.c` & `par077.tab.h`** - Auto-generated parser files by Bison.  
- **`y.tab.c` & `y.tab.h`** - Additional parser files (if required).  
- **`lex.yy.c`** - Auto-generated scanner file by Flex.  
- **`a.exe`** - Compiled executable (Windows).  
- **`LAB3_Output.png`** - Screenshot of program output.  

## Compilation & Execution   
```sh
bison -dy par077.y
flex l_lab3.l
gcc y.tab.c lex.yy.c
a.exe  // to run the program 
