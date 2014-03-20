all:
	lex lexer.l
	gcc -c stringtable.c
	gcc -c lex.yy.c
	gcc -c driver.c
	gcc -o mylex lex.yy.o stringtable.o driver.o -ll

