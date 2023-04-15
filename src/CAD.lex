/** @file
    @brief lexer */

%{
    #include "CAD.hpp"
%}

%option yylineno noyywrap

%%
#[^\n]*     {}                          // line comment

".gui"      TOKEN(Sym,SYM)

[_a-zA-Z][_a-zA-Z0-9]*  TOKEN(Sym,SYM)

[ \t\r\n]+  {}                          // drop spaces
.           {yyerror("");}              // error on any undetected char
