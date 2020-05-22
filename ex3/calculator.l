%{

#include <stdlib.h>
#include <stdio.h>
#include "y.tab.h"

void yyerror(char*);

int line = 1;

int baseBlock ( int token_id, const char* name) {
    
    struct Token *t = malloc (sizeof (struct Token));
    
    t->key = token_id;
    t->name = (char *) name;
    t->value = atof(yytext);
    
    yylval.token = t;
    
    return token_id;
}

%}

%option yylineno

LINE			\n

INT_VALUE       [0-9]+
REAL_VALUE      [0-9]+"."[0-9]+

SUM             "+"
MINOR           "-"
MULT            "*"
DIVISION        "/"

%%

{LINE}	{ line++; return baseBlock ( LINE, "LINE" ); }

{INT_VALUE}       { return baseBlock ( INT_VALUE, "INT_VALUE" ); }
{REAL_VALUE}      { return baseBlock ( REAL_VALUE, "REAL_VALUE" ); }

{SUM}		{return yytext[0];} 
 
{MINOR}		{return yytext[0];} 
 
{MULT}		{return yytext[0];} 
 
{DIVISION}	{return yytext[0]; } 
