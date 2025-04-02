%{
	#include "sym_tab3.c"
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#define YYSTYPE char*
	int type=-1;	//initial declaration of type for symbol table
	char* vval="~";	//initial declaration of value for symbol table
	int vtype=-1;	//initial declaration for type checking for symbol table
	int scope=0;	//initial declaration for scope
	void yyerror(char* s); // error handling function
	int yylex(); // declare the function performing lexical analysis
	extern int yylineno; // track the line number

%}

/* declare tokens */
%token T_INT T_CHAR T_DOUBLE T_WHILE  T_INC T_DEC   T_OROR T_ANDAND T_EQCOMP T_NOTEQUAL T_GREATEREQ T_LESSEREQ T_LEFTSHIFT T_RIGHTSHIFT T_PRINTLN T_STRING  T_FLOAT T_BOOLEAN T_IF T_ELSE T_STRLITERAL T_DO T_INCLUDE T_HEADER T_MAIN T_ID T_NUM

/* specify start symbol */
%start START

%%

START : PROG { printf("Valid syntax\n"); YYACCEPT; };

/* main function */
PROG : MAIN PROG
	| DECLR ';' PROG
	| ASSGN ';' PROG
	| ;

/* Grammar for variable declaration */
DECLR : TYPE LISTVAR;

/* List of variables */
LISTVAR : LISTVAR ',' VAR 
	  | VAR
	  ;

VAR: T_ID '=' EXPR 	{
				if(check_sym_tab($1)) {
					printf("Error: Variable '%s' is already declared.\n", $1);
					yyerror($1);
				} else {
					insert_symbol($1, size(type), type, yylineno, scope);
					insert_val($1, vval, yylineno);
					vval="~";	
					type=-1;
				}
			}
     | T_ID 		{
				if(check_sym_tab($1)) {
					printf("Error: Variable '%s' is already declared.\n", $1);
					yyerror($1);
				} else {
					insert_symbol($1, size(type), type, yylineno, scope);
					type=-1;
				}
			};

TYPE : T_INT {type = 2;}		
       | T_FLOAT {type = 3;}	
       | T_DOUBLE {type = 4;}	
       | T_CHAR {type = 1;}	
       ;

/* Grammar for assignment */   
ASSGN : T_ID {type=retrieve_type($1);}'=' EXPR 	{
				if(!check_sym_tab($1)) {
					printf("Error: Variable '%s' not declared.\n", $1);
					yyerror($1);
				}
				insert_val($1, vval, yylineno);
				vval="~";	
				type=-1;
			}
	;

EXPR : EXPR REL_OP E  
       | E {vval=$1;}
       ;

/* Expression Grammar */	   
E : E '+' T 	{ 
			if(vtype==2)
				sprintf($$,"%d",(atoi($1)+atoi($3)));
			else if(vtype==3)
				sprintf($$,"%lf",(atof($1)+atof($3)));
			else {
				printf("Error: Character used in arithmetic operation.\n");
				yyerror($$);
				$$="~";
			}
		}
    | E '-' T 	{ 
			if(vtype==2)
				sprintf($$,"%d",(atoi($1)-atoi($3)));
			else if(vtype==3)
				sprintf($$,"%lf",(atof($1)-atof($3)));
			else {
				printf("Error: Character used in arithmetic operation.\n");
				yyerror($$);
				$$="~";
			}
		}
    | T {$$=$1;}
    ;
	
T : T '*' F 	{ 
			if(vtype==2)
				sprintf($$,"%d",(atoi($1)*atoi($3)));
			else if(vtype==3)
				sprintf($$,"%lf",(atof($1)*atof($3)));
			else {
				printf("Error: Character used in arithmetic operation.\n");
				yyerror($$);
				$$="~";
			}
		}
    | T '/' F 	{ 
			if(vtype==2) {
				if(atoi($3) == 0) {
					printf("Error: Division by zero.\n");
					yyerror($$);
					$$="~";
				} else
					sprintf($$,"%d",(atoi($1)/atoi($3)));
			}
			else if(vtype==3) {
				if(atof($3) == 0) {
					printf("Error: Division by zero.\n");
					yyerror($$);
					$$="~";
				} else
					sprintf($$,"%lf",(atof($1)/atof($3)));
			}
			else {
				printf("Error: Character used in arithmetic operation.\n");
				yyerror($$);
				$$="~";
			}
		}
    | F {$$=$1;}
    ;

F : '(' EXPR ')'
    | T_ID 	{
			if(check_sym_tab($1)) {
				char* check=retrieve_val($1);
				if(strcmp(check, "~") == 0) {
					printf("Error: Variable '%s' is not initialized.\n", $1);
					yyerror($1);
				} else {	
					$$=strdup(check);
					vtype=type_check(check);	
					if(vtype!=type && type!=-1) {
						printf("Error: Type mismatch for '%s'.\n", $1);
						yyerror($1);
					}	
				}
			}
		}
    | T_NUM 	{
    			$$=strdup($1); 
    			vtype=type_check($1);
    			if(vtype!=type && type!=-1) {
				printf("Error: Type mismatch.\n");
				yyerror($1);
			}
		}
    | T_STRLITERAL {
    			$$=strdup($1); 
    			vtype=1;
			if(vtype!=type) {
				printf("Error: Type mismatch.\n");	
				yyerror($1);
			}
		}
    ;

REL_OP :   T_LESSEREQ
	   | T_GREATEREQ
	   | '<' 
	   | '>' 
	   | T_EQCOMP
	   | T_NOTEQUAL
	   ;	

/* Grammar for main function */
MAIN : TYPE T_MAIN '(' EMPTY_LISTVAR ')' '{' {scope++;} STMT '}' {scope--;};

/* argument list can be empty, or have a list of variables */
EMPTY_LISTVAR : LISTVAR
		|;

/* statements can be standalone, or parts of blocks */
STMT : STMT_NO_BLOCK STMT
       | BLOCK STMT
       |
       ;

STMT_NO_BLOCK : DECLR ';'
       | ASSGN ';'
       ;

BLOCK : '{' {scope++;} STMT '}' {scope--;};

%%

/* Error handling function */
void yyerror(char* s) {
    fprintf(stderr, "Error at line %d: %s\n", yylineno, s);
}

/* Main function */
int main(int argc, char* argv[]) {
    printf("Sample Valid input:\nint z=10; int main(){int a=10; int b=10+20; int c=a+b;}\n");
    printf("Sample Invalid input:\nint z=10; int main(){int a=10; char c='x'; char d=a/c;}\n");

    init_table();  // Initialize the symbol table
    yyparse();     // Parse the input
    display_sym_tab(); // Display the symbol table
    
    return 0;
}
