/* Simple integer alculator.
Step2 : Evaluate via actions. 
@author idanilov
*/
grammar Evaluator2;

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

eval returns [int result] :
  expr EOF { result = $expr.result; }
  ;

expr returns [int result] :
  add { result = $add.result; }
  ;

add returns [int result] :
  op1 = mult { result = op1; }
  (
    (
      PLUS op2 = mult { result += op2; }
      | MINUS op2 = mult { result -= op2; }
    )
  )*
  ;

mult returns [int result] :
  op1 = sign { result = op1; }
  (
    (
      MUL op2 = sign { result *= op2; }
      | DIV op2 = sign { result /=  op2; }
      //'%' is a special symbol in StringTemplate - so escape it.
      | MOD op2 = sign { result \%= op2; }
    )
  )*
  ;

sign returns [int result]
@init {
 boolean positive = true; 
} :
  (MINUS { positive = !positive; })? atom {
    result = $atom.result;
    if (!positive) {
      result = -result;
    }
  }
  ;

atom returns [int result] :
  LPAREN expr RPAREN { result = $expr.result; }
  | INT { result = Integer.parseInt($INT.text); }
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
