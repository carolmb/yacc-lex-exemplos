%{

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "y.tab.h"

int yylex(void);
void yyerror(char *);
void yyerrorType(const char *s1, const char *s2);
void verifyType(struct Token *t1, struct Token *t2);

%}

%code requires {
    struct Token {
	    int key;
	    char* name;
	    float value;
	};
}

%union { 
	struct Token *token;
}

%start program

%type<token> term mulex expr stmt program
%token<token> REAL_VALUE INT_VALUE LINE

%%

program : stmt program | stmt

stmt : expr LINE		{ printf("Resultado: %f\n",$1->value); } 
	| LINE

expr : expr '+' mulex	{ $$->value = $1->value + $3->value; }
	| expr '-' mulex    { $$->value = $1->value - $3->value; }
	| mulex             { $$->value = $1->value; }

mulex : mulex '*' term	{ $$->value = $1->value * $3->value; }
	| mulex '/' term    { verifyType($1,$3); $$->value = $1->value / $3->value; }
	| term              { $$->value = $1->value; }

term : '(' expr ')'		{ $$->value = $2->value; }
	| REAL_VALUE		{ $$->value = $1->value; }
	| INT_VALUE			{ $$->value = $1->value; }

%%

void verifyType(struct Token *t1, struct Token *t2) {
	if(strcmp(t1->name,t2->name) != 0) {
		yyerrorType(t1->name,t2->name);
	} 
}

void yyerror(char *s) {
	extern int line;
    fprintf(stderr, "Linha %d: %s\n", line, s);
    exit(1);
}

void yyerrorType(const char *s1, const char *s2) {
	extern int line;
    fprintf(stderr, "Linha %d: tipos incompatíveis %s e %s\n", line, s1, s2);
    exit(1);
}

int main(void) {
	printf("Insira expressão: \n");
	yyparse();
	return 0;
}

