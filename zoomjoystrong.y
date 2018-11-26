%{
    #include "zoomjoystrong.h"
    #include "zoomjoystrong.tab.h"
    #include <stdio.h> 
    int yylex();
    void yyerror(const char* msg);
%}

/* datatypes */
%union { int iVal;
		float fVal;
		}

/* declarations */
%token END
%token CIRCLE
%token RECTANGLE
%token SET_COLOR
%token INT
%token FLOAT
%token END_STATEMENT
%token POINT
%token LINE
%type<iVal> INT
%type<fVal> FLOAT

%%

/* grammar */
zoomjoystrong:	list_of_expr
;

list_of_expr: expr 
	| list_of_expr expr
;

expr:  point    
	|	circle
	|	line
	|	set_color	
	|	rectangle 
	|	end
;

/* Draws a point in the specified position if coordinates are inside window */
point:	POINT INT INT END_STATEMENT
    {
    	if($2 <= WIDTH && $2 >= 0 && $3 <= HEIGHT && $3 > 0){
   			point($2,$3);
  		}
  		else{
    		yyerror("the point is out of bounds");
  		}
    }  
;

/* Draws a circle in the specified position if coordinates are inside window */
circle:	CIRCLE INT INT INT END_STATEMENT
	{
		if(WIDTH-$2 >= $4 && $2 >= $4 && $3 >= $4 && HEIGHT-$3 >= $4  && $4 >= 0){ 
    		circle($2,$3,$4);
  		}
  		else{
    		yyerror("the circle is out of bounds");
  		}
	}
;

/* Draws a line in the specified position if coordinates are inside window */
line:	LINE INT INT INT INT END_STATEMENT
	{
		if($2 <= WIDTH && $2 >= 0 && $3 <= HEIGHT && $3 >= 0 && $4 <= WIDTH && $4 >= 0 && $5 <= HEIGHT && $5 >= 0){
   			line($2,$3,$4,$5);
  		}
  		else{
    		yyerror("the line is out of bounds");
  		}
  	}
;

/* Sets the color if the color values are within range */
set_color:  SET_COLOR INT INT INT END_STATEMENT
	{

		if($2 <= 255 && $2 >= 0 && $3 <= 255 && $3 >= 0 && $4 <= 255 && $4 >= 0){
    		set_color($2,$3,$4);
  		}
  		else{
    		yyerror("the color is out of bounds");
 		 }
	}

/* Draws a rectangle in the specified position if coordinates are inside window */
rectangle:  RECTANGLE INT INT INT INT END_STATEMENT
	{
		if($2 + $4 <= WIDTH && $2 + $4 >= 0 && $3 + $5 <= HEIGHT && $3 + $5 >= 0){ 
   			rectangle($2,$3,$4,$5);
  		}
  		else{
    		yyerror("the rectangle is out of bounds");
  		}
	}
;

/* if end of program, will terminate */
end: END END_STATEMENT{
	finish();
}
;

%%

/* displaying error messages */
void yyerror(const char* err){
  fprintf(stderr, "ERROR: %s\n", err);
}

/* main */
int main(int argc, char** argv){
  setup();
  yyparse();
  finish();
}

