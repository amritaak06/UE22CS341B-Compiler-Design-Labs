#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "sym_tab.h"


table* init_table()	//allocate a new empty symbol table
{
	table* t = (table*)malloc(sizeof(table));
	t->head = NULL;
	return t;
}

symbol* init_symbol(char* name, int size, int type, int lineno, int scope) //allocates space for items in the list
{
	symbol* s = (symbol*)malloc(sizeof(symbol));
	s->name = (char*)malloc(sizeof(char)*(strlen(name)+1));
	strcpy(s->name,name);
	/*assign value for size, type, line and scope for node s. For example:s->size = size; */
	s->size=size;
	s->type=type;
	s->line=lineno;
	s->scope=scope;	




	s->val=(char*)malloc(sizeof(char)*10);
	strcpy(s->val,"~");
	s->next = NULL;
	return s;
}

void insert_symbol(char* name, int size, int type, int lineno, int scope)	//inserts symbols into the table when declared
{
	
	symbol* s = init_symbol(name, size, type, lineno,scope);
	if(t->head == NULL)		//if table is empty insert in the beginning
	{
		t->head = s;
		return;
	}
	symbol* curr = t->head;
	while(curr->next!=NULL)		//else traverse to the end of the list and insert there
	{
		curr = curr->next;
	}
	curr->next = s;
}


void insert_val(char* name, char* v, int line)	//inserts values into the table when initialised
{
	
	if(v=="~")			//no value to insert
		return;
	if(t->head == NULL)
	{
		return;
	}
	symbol* curr = t->head;
	while(curr!=NULL)		//find variable name and insert
	{
		if(strcmp(curr->name,name)==0)
		{
			strcpy(curr->val,v);
			curr->line=line;
			return;
		}	
		curr = curr->next;
	}
}


int check_sym_tab(char* name)		//checks symbol table whether the variable has been declared or not
{					//return 0 if symbol not found and 1 if symbol is found
	if(t->head == NULL)		
	{
		return 0;
	}
	symbol* curr = t->head;
	while(curr!=NULL)
	{
		if(strcmp(curr->name,name)==0)
		{
			//printf("Variable %s already declared\n",name);
			return 1;
		}
		curr = curr->next;
	}
	//printf("Variable %s not declared\n",name);
	return 0;
}

void display_sym_tab()			//displays symbol table
{
	symbol* curr = t->head;
	if(curr == NULL)
		return;
	printf("Name\tsize\ttype\tlineno\tscope\tvalue\n");
	while(curr!=NULL)
	{		
		/* print name, size, type,lineno,scope,value.
		For example:
		printf("%s\t%d\t\n", curr->name, curr->size);
		*/
		printf("%s\t%d\t%d\t%d\t%d\t%s\n",curr->name,curr->size,curr->type,curr->line,curr->scope,curr->val);
		
		curr = curr->next;
	}
}

int size(int type)
{
	if(type==3)
		return 4;
	if(type==4)
		return 8;
	return type;
}
