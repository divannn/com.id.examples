/* Simple integer calculator.
Step3 : Evaluate via AST.
@see EvaluatorWalker.g 
@author idanilov
*/
grammar Evaluator3;

options {
  language     = Java;
  output       = AST;
  ASTLabelType = CommonTree; //ANTLR will generate this common class.
}

tokens {
  LPAREN = '(';
  RPAREN = ')';
  MUL    = '*';
  DIV    = '/';
  MOD    = '%';
  PLUS   = '+';
  MINUS  = '-';
  UNARY_MINUS;
}

@header {
  package com.id.example.antlr.evaluator;
}

@lexer::header {
  package com.id.example.antlr.evaluator;
}

eval :
  expr EOF!
  ;

expr :
  add
  ;

add :
  mult
  (
    (
      PLUS^
      | MINUS^
    )
    mult
  )*
  ;

mult :
  sign
  (
    (
      MUL^
      | DIV^
      | MOD^
    )
    sign
  )*
  ;

sign :
  (MINUS^ { $MINUS.setType(UNARY_MINUS); })? atom
  ;

atom :
  LPAREN! expr RPAREN!
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
