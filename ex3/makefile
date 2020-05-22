yacc: y.tab.c lex.yy.c
	gcc -o calculator lex.yy.c y.tab.c token.c -lfl 

lex.yy.c:
	lex calculator.l

y.tab.c:
	yacc -d calculator.y

clean: 
	rm -rf lex.yy.c y.tab.c y.tab.h calculator