%{

	#include <stdio.h>
	void exit();
	int lineNum = 1;

%}

%%

(END)				{ printf("EXIT\n"); exit(0);}
(CIRCLE)			{ printf("DRAW_CIRCLE\n");}
(RECTANGLE)			{ printf("DRAW_RECTANGLE\n");}
(SET_COLOR)			{ printf("COLOR_SET\n");}
[0-9]				{printf("INT\n");}
([0-9]*[.])?[0-9]+	{printf("FLOAT\n");}
;					{ printf("END_STATEMENT\n");}
\n					{++lineNum;}
\n|\t|[ ]			{ }
.					{printf("%s on line %d was not found\n",yytext, lineNum);}

%%

int main(int argc, char** argv){
	yylex();
	return 0;
}
