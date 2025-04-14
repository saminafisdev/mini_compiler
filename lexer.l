/* lexer.l */
%{
#include "parser.tab.h"
%}

%%
[ \t]+         /* Skip whitespace */
[\n]           { return EOL; }
[0-9]+         { yylval.ival = atoi(yytext); return NUMBER; }
"ANS"          { return ANS; }
"+"            { return ADD; }
"-"            { return SUB; }
"*"            { return MUL; }
"/"            { return DIV; }
"("            { return LPAREN; }
")"            { return RPAREN; }
.              { fprintf(stderr, "Error: Unknown character '%s'\n", yytext); }
%%

int yywrap() {
    return 1;
}