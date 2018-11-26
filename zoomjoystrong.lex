%{

	#include <stdio.h>
	#include "zoomjoystrong.h"
	#include "zoomjoystrong.tab.h"
	void exit();
	int lineNum = 1;

%}

%option noyywrap

%%

(end)				{ return END; }
(circle)			{ return CIRCLE; }
(rectangle)			{ return RECTANGLE;}
(set_color)			{ return SET_COLOR;}
(point)				{ return POINT; }
(line)				{ return LINE; }
[0-9]+				{ yylval.iVal = atoi(yytext); return INT; }
-?[0-9]+\.[0-9]+	{ yylval.fVal = atof(yytext); return FLOAT;}
;					{ return END_STATEMENT;}
[ |\t|\n]+			;
.					;

%%
