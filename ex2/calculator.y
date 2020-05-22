%{

#include <stdlib.h>
#include <stdio.h>
#include "y.tab.h"

int yylex(void);
void yyerror(char *);

%}

%token INTEGER

%%

program : line program | line

line : expr '\n'		{ printf("%d\n",$1); } 
	| '\n'

expr : expr '+' mulex	{ $$ = $1 + $3; }
	| expr '-' mulex    { $$ = $1 - $3; }
	| mulex             { $$ = $1; }

mulex : mulex '*' term	{ $$ = $1 * $3; }
	| mulex '/' term    { $$ = $1 / $3; }
	| term              { $$ = $1; }

term : '(' expr ')'		{ $$ = $2; }
	| INTEGER			{ $$ = $1; }

%%

void yyerror(char *s) {
	fprintf(stderr,"%s\n",s);
	return;
}

int main(void) {
	printf("Insira expressão: \n");
	yyparse();
	return 0;
}

