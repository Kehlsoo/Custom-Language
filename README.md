# Lexer
A lexer is the first step in creating a programming language. The lexer is responsible for breaking up the input stream into tokens, and emitting those tokens.

The Flex file should define the following tokens:
- [x] END. This statement exits the interpreter.
- [x] END_STATEMENT. All commands should end with a semicolon.
- [x] POINT. When we match the command to plot a point.
- [x] LINE. When we match the command to draw a line.
- [x] CIRCLE. When we match the command to draw a circle.
- [x] RECTANGLE. When we match the command to draw a rectangle.
- [x] SET_COLOR. Matches the command to change colors.
- [x] INT. Matches an integer value.
- [x] FLOAT. Matches a floating-point value.
- [x] A way to match tabs, spaces, or newlines, and to ignore them.
- [x] A way to match anything not listed above, and to tell the user they messed up, and on which line.
