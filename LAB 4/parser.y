%{
	#include "abstract_syntax_tree.c"
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	void yyerror(char* s); 											// error handling function
	int yylex(); 													// declare the function performing lexical analysis
	extern int yylineno; 											// track the line number
%}

%union																// union to allow nodes to store return different datatypes
{
	char* text;
	expression_node* exp_node;
}



%token <text> T_ID T_NUM

%type <exp_node> E T F

/* specify start symbol */
%start START


%%
START : ASSGN	{ 
					printf("Valid syntax\n");
	 				YYACCEPT;										// If program fits the grammar, syntax is valid
	 			}

/* Grammar for assignment */
ASSGN : T_ID '=' E	{
						display_exp_tree($3);				// displaying the expression tree
					}
	;

/* Expression Grammar */
E : E '+' T 	{
					$$ = init_exp_node(strdup("+"), $1, $3);		// creating a new node of the AST and setting left and right children
				}
	| E '-' T 	{
												// creating a new node of the AST and setting left and right children
				}
	| T 	{ $$ = $1; }
	;
	
	
T : T '*' F 	{
								// creating a new node of the AST and setting left and right children
				}
	| T '/' F 	{
								// creating a new node of the AST and setting left and right children
				}
	| F {
			$$ = $1;												//passing AST node to parent node
		}
	;

F : '(' E ')' { $$ = $2; }
	| T_ID 	{
				$$ = init_exp_node(strdup($1), NULL, NULL);			// creating a terminal node of the AST and setting left and right children to NULL
			}
	| T_NUM 	{
							// creating a terminal node of the AST and setting left and right children to NULL
				}
	;

%%


/* error handling function */
void yyerror(char* s)
{
    fprintf(stderr, "Syntax Error on line %d: %s\n", yylineno, s);
    
    // Get the unexpected token from yylval if available
    extern char* yytext;  // `yytext` holds the last matched token
    if (yytext)
    {
        fprintf(stderr, "Unexpected token: '%s'\n", yytext);
    }
    
    exit(EXIT_FAILURE); // Terminate parsing on error
}



/* main function - calls the yyparse() function which will in turn drive yylex() as well */
int main(int argc, char* argv[])
{
	printf("Enter input: Sample input: c=a+b+c\n");
	yyparse();
	return 0;
}