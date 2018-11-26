%{
	#include <stdio.h> 
    #include "zoomjoystrong.tab.h"
    #include "zoomjoystrong.h"
    void yyerror(const char* msg);
    int yylex();
%}

/* datatypes */
%union { 
	int iVal;
	float fVal;
		}

/* declarations */
//tokens
%token END
%token END_STATEMENT
%token POINT
%token LINE
%token CIRCLE
%token RECTANGLE
%token SET_COLOR
%token INT
%token FLOAT

//types
%type<iVal> INT
%type<fVal> FLOAT

%%

/* grammar */
zoomjoystrong:	list_of_expr
;

list_of_expr: expr 
	| list_of_expr expr
;

expr:  end
	|	point
	|	line
	|	circle
	|	rectangle	
	|	set_color
;

//defining each type of expression

/* if end of program, will terminate */
end: END END_STATEMENT{
	finish(); //calls finishing method in c file
}
;

/* Draws a point in the specified position if coordinates are inside window.
	The x and y coordinates need to be less than the window's specifications
	or else out of bounds */
point:	POINT INT INT END_STATEMENT{
    	if($2 <= WIDTH && $2 >= 0 && $3 <= HEIGHT && $3 >= 0){
   			point($2,$3);
  		}
  		else{
    		yyerror("the point is out of bounds"); //sends error message to yyerror
  		}
    }  
;

/* Draws a line in the specified position if coordinates are inside window
	The x and y coordinates need to be less than the window's specifications
	or else out of bounds */
line:	LINE INT INT INT INT END_STATEMENT{
		if($2 <= WIDTH && $2 >= 0 && $3 <= HEIGHT && $3 >= 0 && $4 <= WIDTH && $4 >= 0 && $5 <= HEIGHT && $5 >= 0){
   			line($2,$3,$4,$5);
  		}
  		else{
    		yyerror("the line is out of bounds"); //sends error message to yyerror
  		}
  	}
;

/* Draws a circle in the specified position if coordinates are inside window
	The x and y coordinates need to be less than the window's specifications
	or else out of bounds */
circle:	CIRCLE INT INT INT END_STATEMENT{
		if(WIDTH-$2 >= $4 && $2 >= $4 && $3 >= $4 && HEIGHT-$3 >= $4  && $4 >= 0){ 
    		circle($2,$3,$4);
  		}
  		else{
    		yyerror("the circle is out of bounds"); //sends error message to yyerror
  		}
	}
;

/* Draws a rectangle in the specified position if coordinates are inside window
	The x and y coordinates need to be less than the window's specifications
	or else out of bounds */
rectangle:  RECTANGLE INT INT INT INT END_STATEMENT {
		if($2 <= WIDTH && $2 >= 0 && $3 <= HEIGHT && $3 >= 0){ 
   			rectangle($2,$3,$4,$5);
  		}
  		else{
    		yyerror("the rectangle is out of bounds"); //sends error message to yyerror
  		}
	}
;

/* Sets the color if the color values are within range. All colors values need to
	be less than or equal to 255. */	
set_color:  SET_COLOR INT INT INT END_STATEMENT{
		if($2 <= 255 && $2 >= 0 && $3 <= 255 && $3 >= 0 && $4 <= 255 && $4 >= 0){
    		set_color($2,$3,$4);
  		}
  		else{
    		yyerror("the color is out of bounds"); //sends error message to yyerror
 		 }
	}
;

%%

//c code for functions

/* displaying error messages */
void yyerror(const char* err){
  fprintf(stderr, "ERROR: %s\n", err); //displays the error message
}

/* main */
int main(int argc, char** argv){
  setup();
  yyparse();
}

