%{
	#include "zoomjoystrong.tab.h"
    #include "zoomjoystrong.h"
	#include <stdio.h>
	void exit();
	int lineNum = 1;
%}

%option noyywrap

%%

(end)				{ return END; } //ends program
;					{ return END_STATEMENT;} //all commands ends in semicolon
(point)				{ return POINT; } //matches command to plot a point
(line)				{ return LINE; } //matches command to draw a line
(circle)			{ return CIRCLE; } //matches command to draw a circle
(rectangle)			{ return RECTANGLE;} //matches command to draw a rectangle
(set_color)			{ return SET_COLOR;} //matches command to change colors
[0-9]+				{ yylval.iVal = atoi(yytext); return INT; } //matches integers
-?[0-9]+\.[0-9]+	{ yylval.fVal = atof(yytext); return FLOAT;} //matches floats
[ |\t|\n]+			; //matches and ignores whitespace, tabs, and new lines
.					; //matches and ignores everything else

%%