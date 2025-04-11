all: parser

parser: parser.tab.o lex.yy.o
	gcc parser.tab.o lex.yy.o -o parser

parser.tab.o: parser.tab.c parser.tab.h
	gcc -c parser.tab.c

lex.yy.o: lex.yy.c parser.tab.h
	gcc -c lex.yy.c

parser.tab.c parser.tab.h: parser.y
	bison -d parser.y

lex.yy.c: lexer.l parser.tab.h
	flex lexer.l

clean:
	rm -f parser parser.tab.c parser.tab.h lex.yy.c lex.yy.o parser.tab.o