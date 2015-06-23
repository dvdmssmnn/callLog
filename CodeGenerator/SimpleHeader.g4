grammar SimpleHeader;

@header
{
package dm.generator.antlr;
}

expression      : (include
                | enum_specifier
                | typedef
                | function_dec) expression
                | EOF;

type            : (CONST? IDENTIFIER | IDENTIFIER CONST?) STAR?
                ;

enum_specifier  : 'enum' IDENTIFIER? LBRACE enum_entry+ RBRACE SEMICOLON
                ;
enum_entry      : IDENTIFIER enum_value? COMMA?
                ;

enum_value      : '=' NUMBER
                ;

include         : ('#include'|'#import') ('<'|'\"') IDENTIFIER ('>'|'\"')
                ;

typedef         : 'typedef' IDENTIFIER IDENTIFIER SEMICOLON
                ;

function_dec    : IDENTIFIER IDENTIFIER LPAREN param_list RPAREN SEMICOLON
                ;

param_list      : (param (COMMA param)*)?
                ;

param           : type IDENTIFIER
                ;


LBRACE          : '{';
RBRACE          : '}';
LPAREN          : '(';
RPAREN          : ')';
LBRACKET        : '[';
RBRACKET        : ']';
SEMICOLON       : ';';
COMMA           : ',';
STAR            : '*';
CONST           : 'const';

IDENTIFIER      : ('a'..'z'|'A'..'Z')('a'..'z'|'A'..'Z'|'0'..'9'|'_'|'/'|'.')*;
NUMBER          : ('-')?('0'..'9')+|('0x'('0'..'9')+);

WS              : [ \r\t\n]+ -> skip;
