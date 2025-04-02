#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "sym_tab.h"

extern table* t;  // Use `extern` instead of redeclaring `t`

// Initialize a new symbol table
table* init_table() {
    t = (table*)malloc(sizeof(table));
    t->head = NULL;
    return t;
}

// Initialize a symbol
symbol* init_symbol(char* name, int size, int type, int lineno, int scope) {
    symbol* sym = (symbol*)malloc(sizeof(symbol));
    sym->name = strdup(name);
    sym->size = size;
    sym->type = type;
    sym->line = lineno;   // Use 'line' instead of 'lineno'
    sym->scope = scope;
    sym->val = NULL;
    sym->next = NULL;
    return sym;
}

// Insert symbol into table
void insert_symbol(char* name, int size, int type, int lineno, int scope) {
    symbol* sym = init_symbol(name, size, type, lineno, scope);
    if (t->head == NULL) {
        t->head = sym;
    } else {
        symbol* temp = t->head;
        while (temp->next != NULL) {
            temp = temp->next;
        }
        temp->next = sym;
    }
}

// Insert value into the symbol table
void insert_val(char* name, char* v, int line) {
    if (t->head == NULL) {
        printf("Error: Symbol Table is empty!\n");
        return;
    }
    symbol* curr = t->head;
    while (curr != NULL) {
        if (strcmp(curr->name, name) == 0) {
            curr->val = strdup(v);
            curr->line = line;  // Use 'line' instead of 'lineno'
            return;
        }
        curr = curr->next;
    }
    printf("Error: Variable %s not found in symbol table.\n", name);
}

// Retrieve value from symbol table
char* retrieve_val(char* name) {
    char* val = "~";
    if (t->head == NULL) {
        return val;
    }
    symbol* curr = t->head;
    while (curr != NULL) {
        if (strcmp(curr->name, name) == 0) {
            return curr->val;
        }
        curr = curr->next;
    }
    return val;
}

// Retrieve type of a symbol
int retrieve_type(char* name) {
    int type = -1;
    if (t->head == NULL) {
        return type;
    }
    symbol* curr = t->head;
    while (curr != NULL) {
        if (strcmp(curr->name, name) == 0) {
            return curr->type;
        }
        curr = curr->next;
    }
    return type;
}

// Check if a symbol exists in the table
int check_sym_tab(char* name) {
    if (t->head == NULL) {
        return 0;
    }
    symbol* curr = t->head;
    while (curr != NULL) {
        if (strcmp(curr->name, name) == 0) {
            return 1;
        }
        curr = curr->next;
    }
    return 0;
}

// Display the symbol table
void display_sym_tab() {
    if (t->head == NULL) {
        printf("Symbol Table is empty!\n");
        return;
    }
    printf("%-15s %-10s %-10s %-10s %-10s %-10s\n", "NAME", "SIZE", "TYPE", "LINE", "SCOPE", "VALUE");
    printf("--------------------------------------------------------------\n");
    
    symbol* curr = t->head;
    while (curr != NULL) {
        printf("%-15s %-10d %-10d %-10d %-10d %-10s\n", 
               curr->name, curr->size, curr->type, curr->line, curr->scope, curr->val ? curr->val : "NULL");
        curr = curr->next;
    }
}

// Type checking from value string
int type_check(char* value) {
    char *s = strchr(value, '\"'); // Check if there's a double quote, then it's a char
    if (s != NULL)
        return 1;
    char *f = strchr(value, '.'); // Check if there's a dot, then it's a float or double
    if (f != NULL)
        return 3;
    return 2; // Otherwise, return int type
}

// Determine size from type
int size(int type) {
    if (type == 3)
        return 4;
    if (type == 4)
        return 8;
    return type;
}
