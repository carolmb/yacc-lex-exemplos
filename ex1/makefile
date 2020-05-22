yacc: lex.yy.c y.tab.c
	gcc -o string lex.yy.c y.tab.c -lfl 

lex.yy.c:
	lex string.l

y.tab.c:
	yacc -d string.y

clean: 
	rm -rf lex.yy.c y.tab.c y.tab.h string