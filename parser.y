/* parser.y */
%{
#include <stdio.h>
#include <stdlib.h>

// Function prototype for the lexer
extern int yylex();
extern char *yytext;
void yyerror(const char *s);
int result;
%}

%union {
    int ival;
}

%token <ival> NUMBER ADD SUB MUL DIV LPAREN RPAREN EOL ANS
%type <ival> program expression

%left ADD SUB
%left MUL DIV

%%
program:
    program expression EOL { printf("Result: %d\n", $2); result = $2; }
    | /* empty */
    ;

expression:
    ANS { $$ = result; }
    | NUMBER              { $$ = $1; }
    | LPAREN expression RPAREN { $$ = $2; }
    | expression ADD expression  { $$ = $1 + $3; }
    | expression SUB expression  { $$ = $1 - $3; }
    | expression MUL expression  { $$ = $1 * $3; }
    | expression DIV expression  {
                                    if ($3 == 0) {
                                        fprintf(stderr, "Error: Division by zero\n");
                                        exit(1);
                                    }
                                    $$ = $1 / $3;
                                  }
    ;
%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s at '%s'\n", s, yytext);
}

int main() {
    printf("Enter an arithmetic expression (Ctrl+D to exit):\n");
    while (yyparse() == 0);
    return 0;
}