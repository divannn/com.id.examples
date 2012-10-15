/* Simple integer calculator.
Step3 : Evaluate via AST.
@see Evaluator3.g 
@author idanilov
*/
tree grammar EvaluatorWalker;

options {
  language     = Java;
  tokenVocab   = Evaluator3;
  ASTLabelType = CommonTree;
}

@header {
  package com.id.example.antlr.evaluator;
}

eval returns [int result] :
  e = expr EOF {result = e;}
  ;

expr returns [int result] :
  ^(PLUS op1 = expr op2 = expr)
  { result = op1 + op2; }
  |
  ^(MINUS op1 = expr op2 = expr)
  { result = op1 - op2; }
  |
  ^(MUL op1 = expr op2 = expr)
  { result = op1 * op2; }
  |
  ^(DIV op1 = expr op2 = expr)
  { result = op1 / op2; }
  |
  ^(MOD op1 = expr op2 = expr)
  //'%' is a special symbol in StringTemplate - so escape it.
  { result = op1 \% op2; }
  |
  ^(UNARY_MINUS e = expr)
  { result = -e; }
  | INT { result = Integer.parseInt($INT.text); }
  ;
