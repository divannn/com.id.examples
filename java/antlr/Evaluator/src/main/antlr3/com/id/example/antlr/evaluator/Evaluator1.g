/* Simple integer calculator.
Step1 : Basic recognizer. 
@author idanilov
*/
grammar Evaluator1;

options {
  language = Java;
}

tokens {
  LPAREN = '(';
  RPAREN = ')';
  MUL    = '*';
  DIV    = '/';
  MOD    = '%';
  PLUS   = '+';
  MINUS  = '-';
}

@header {
  package com.id.example.antlr.evaluator;
}

@lexer::header {
  package com.id.example.antlr.evaluator;
}

eval :
  expr EOF
  ;

expr :
  add
  ;

add :
  mult
  (
    (
      PLUS
      | MINUS
    )
    mult
  )*
  ;

mult :
  sign
  (
    (
      MUL
      | DIV
      | MOD
    )
    sign
  )*
  ;
  

sign :
  MINUS? atom
  ;

atom :
  LPAREN expr RPAREN
  | INT
  ;

INT :
  DIGIT+
  ;

fragment
DIGIT :
  '0'..'9'
  ;

WS :
  (
    ' '
    | '\t'
    | '\r'
    | '\n'
  )+
  {$channel=HIDDEN;}
  ;
