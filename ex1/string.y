%{

#include <stdlib.h>
#include <stdio.h>

int yylex(void);
void yyerror(char *s);

%}

%token A B NL

%%

expr : A expr | B NL { printf("Exemplo correto."); exit(0); }

%%

void yyerror(char *s) {
    printf("Erro.");
}

int main(void) {
    printf("Insira string: \n");
    yyparse();
    return 0;
}
