%{

	#include <stdio.h>
	void exit();

%}

%%

(END)		{ printf("EXIT\n"); exit(0);}
.;|;			{ printf("END_STATEMENT\n");}
[0-9]		{printf("INT\n");}
.			{ printf("'%s' on line %d does not match any rule\n", yytext, yylineno);}

%%

int main(int argc, char** argv){
	yylex();
	return 0;
}
