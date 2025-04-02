# UE22CS341B-Compiler-Design-Labs
A collection of Compiler Design lab programs done in class covering lexical analysis, parsing, syntax trees, intermediate code generation, and optimization using C, Lex, and Yacc.

Course - Compiler Design at PES UNIVERSITY
Semester - 6

# In this repository 
Lab 2: Implements a simple parser with input based on defined grammar rules and tokenizes keywords, operators, and identifiers. <br>
Lab 3: parses variable declarations, assignments, expressions, and function definitions, while also integrating a symbol table for tracking variables and values. <br>
Lab 4: implements an Abstract Syntax Tree (AST) for arithmetic expressions using Lex and Yacc (Bison). <br>
Lab 5: implementation of Intermediate Code Generation (ICG) using quadruples for arithmetic expressions and generating three-address code (TAC) in quadruple format. <br>

## **Prerequisites**  
Before running the labs, ensure you have the following installed:  

- **Lex** (Flex)  
- **Yacc** (Bison)  
- **GCC (GNU Compiler Collection)**  
- **C Standard Library**  
- **A Terminal or Command Prompt**  

These tools are required to compile and execute the programs in this repository.  

---

## **How to Compile & Run Labs**  

Each lab has a **README.md** file with specific commands. However, the general steps are:  

```sh
flex lexer.l        # Generate lex.yy.c
bison -d parser.y   # Generate y.tab.c and y.tab.h
gcc lex.yy.c y.tab.c -o a.exe  # Compile into an executable
a.exe               # Run the program

