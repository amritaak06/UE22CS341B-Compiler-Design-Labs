# Commands to Run This Lab  
(Note: The labs were done on a **Windows OS**)

## Lab Activity - Lex and Yacc for Parsing  

This lab focuses on using **Lex (Flex) and Yacc (Bison)** to implement a simple parser.  
The program processes input based on defined grammar rules and tokenizes keywords, operators, and identifiers.  
It also includes a **symbol table** for variable storage and scope management.  

### Files Included:
- **`lab2_077.l`** – Lex (Flex) file for lexical analysis.
- **`lab2_077.y`** – Yacc (Bison) file for syntax analysis.
- **`sym_tab.c` & `sym_tab.h`** – Symbol table implementation.
- **`y.tab.c` & `y.tab.h`** – Bison-generated parser files.
- **`lex.yy.c`** – Flex-generated scanner file.
- **`a.exe`** – Compiled executable (Windows).  

## Steps to Compile and Execute

```sh
bison -dy lab2_077.y
flex lab2_077.l
gcc y.tab.c lex.yy.c
a.exe
