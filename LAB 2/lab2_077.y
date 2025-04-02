%{
	#include "sym_tab.c"
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#define YYSTYPE char*
	int scope=0;	//initial declaration of scope for symbol table
	int type=-1;	//initial declaration of type for symbol table
	char* vval="~";	//initial declaration of value for symbol table

	void yyerror(char* s); // error handling function
	int yylex(); // declare the function performing lexical analysis
	extern int yylineno; // track the line number

%}

%token T_INT T_CHAR T_DOUBLE T_WHILE  T_INC T_DEC   T_OROR T_ANDAND T_EQCOMP T_NOTEQUAL T_GREATEREQ T_LESSEREQ T_LEFTSHIFT T_RIGHTSHIFT T_PRINTLN T_STRING  T_FLOAT T_BOOLEAN T_IF T_ELSE T_STRLITERAL T_DO T_INCLUDE T_HEADER T_MAIN T_ID T_NUM

%start START


%%
START : PROG { printf("Valid syntax\n"); YYACCEPT; }	
        ;	
	  
PROG :  MAIN PROG				
	|DECLR ';' PROG 				
	| ASSGN ';' PROG 			
	| 					
	;
	 

DECLR : TYPE LISTVAR 
	;	


LISTVAR : LISTVAR ',' VAR 
	  | VAR
	  ;

VAR: T_ID '=' EXPR 	{
				if(check_sym_tab($1))	//if variable is declared then variable is being re-declared
					yyerror($1);
				//call insert symbol_function with appropriate values
				insert_val($1,vval,yylineno);

			}
     | T_ID 		{
				//if variable is already declared and is being reclared, call yyerror
				if(check_sym_tab($1))	//if variable is declared then variable is being re-declared
					yyerror($1);
					
				insert_symbol($1,size(type),type,yylineno,scope);

			}	 

//assign type here to be returned to the declaration grammar
TYPE : T_INT {type = INT;}		//INT=2
       | T_FLOAT {type = FLOAT;}	//FLOAT=3
       | T_DOUBLE {type = DOUBLE;}	//DOUBLE=4
       | T_CHAR {type = CHAR;}		//CHAR=1
       ;

    
/* Grammar for assignment */   
ASSGN : T_ID '=' EXPR 	{
				if(!check_sym_tab($1))	//if variable not declared then value cannot be assigned
					yyerror($1);
				insert_val($1,vval,yylineno);
				vval="~";		//to make sure previous values aren't inserted into other identifiers
			}
	;

EXPR : EXPR REL_OP E
       | E 
       ;
	   
E : E '+' T
    | E '-' T
    | T 
    ;
	
	
T : T '*' F
    | T '/' F
    | F
    ;

F : '(' EXPR ')'
    | T_ID
    | T_NUM {vval=strdup($1);}
    | T_STRLITERAL {vval=strdup($1);}
    ;

REL_OP :   T_LESSEREQ
	   | T_GREATEREQ
	   | '<' 
	   | '>' 
	   | T_EQCOMP
	   | T_NOTEQUAL
	   ;	


/* Grammar for main function */
MAIN : TYPE T_MAIN '(' EMPTY_LISTVAR ')' '{' STMT '}';

EMPTY_LISTVAR : LISTVAR
		|	
		;

STMT : STMT_NO_BLOCK STMT
       | BLOCK STMT
       |
       ;


STMT_NO_BLOCK : DECLR ';'
       | ASSGN ';' 
       ;

BLOCK : '{' STMT '}';


%%


/* error handling function */
void yyerror(char* s)
{
	printf("Error :%s at %d \n",s,yylineno);
}


int main(int argc, char* argv[])
{
	t=init_table();
	printf("Enter input: For example:  int main(){int a;float b;a=10;b=20.1;}\n");
	yyparse();
	printf("Symbol Table: \n");
	display_sym_tab();
	return 0;


}
