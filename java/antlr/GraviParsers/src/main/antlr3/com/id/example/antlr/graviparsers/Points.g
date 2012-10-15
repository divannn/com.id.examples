/* Paser for points.
File format:

"
N, N, N
N, N, N
...
"

where N is double.
Each line represens coordinate of point (X,Y,Z).
 
@author idanilov
*/
grammar Points;

options {
  language = Java;
}

tokens {
  COMMA       = ',';
  UNARY_MINUS = '-';
}

@lexer::header {
  package com.id.example.antlr.graviparsers;
  
  import java.util.LinkedList;
  import com.id.example.antlr.graviparsers.*;
  
}

@parser::header {
  package com.id.example.antlr.graviparsers;

  import java.util.LinkedList;
  import com.id.example.antlr.graviparsers.*;
}

@lexer::members {

  //lexer errors.
  protected List<SyntaxError> errors = new LinkedList<SyntaxError>();

  public List<SyntaxError> getErrors() {
    return this.errors;
  }
  
   public void displayRecognitionError(String[] tokenNames, RecognitionException e) {
        String msg = getErrorMessage(e, tokenNames);
        SyntaxError error  = new SyntaxError(e.line,e.charPositionInLine,msg);
        this.errors.add(error);
   }

    /*public void emitErrorMessage(String msg) {
    }*/
}

@parser::members {

  //parser errors.
  protected List<SyntaxError> errors = new LinkedList<SyntaxError>();

  public List<SyntaxError> getErrors() {
    return this.errors;
  }
  
  public void displayRecognitionError(String[] tokenNames, RecognitionException e) {
        String msg = getErrorMessage(e, tokenNames);
        SyntaxError error  = new SyntaxError(e.line, e.charPositionInLine,msg);
        this.errors.add(error);
  }
    
  //forbid parser recovering. Stop on first error.
  protected Object recoverFromMismatchedToken(IntStream input, int ttype, BitSet follow)
        throws RecognitionException {
        //System.err.println("---Parser recover");
        // System.err.println("---Parser recover");
        MismatchedTokenException e = new MismatchedTokenException(ttype, input);
        if (e.token.getType() == Token.EOF) {
            //if error token is EOF - ANTLR does not calculate its line/position properly.
            //So take previous token and calculate.
            CommonToken prev = (CommonToken) ((TokenStream) input).LT(-1);
            e.line = prev.getLine();
            System.err.println("pos in line of prev token: " + prev.getCharPositionInLine());
            int len = prev.getStopIndex() - prev.getStartIndex() + 1;
            System.err.println("len of prev token: " + len);
            e.charPositionInLine = prev.getCharPositionInLine() + len;
        }
        throw e;
  }
    
    //can be used to customize/localize error messages.      
//  public String getErrorMessage(RecognitionException e, String[] tokenNames) {
////        for (String n : tokenNames) {
////            System.err.println("EEE: " + n);
////        }
//  
//       if (e instanceof EarlyExitException) {
//       }
//       return super.getErrorMessage(e, tokenNames);
//  }
  
}

//Replace defailt handler - do not consume parser errors. Throw them.
//@rulecatch {
//  catch (RecognitionException e) {
//    System.err.println("RULECATCH " + e);
//    throw e;
//  }
//}

file :
  lines EOF
  ;

lines :
  (line NEW_LINE)+
  ;

line :
  X = NUMBER_LITERAL COMMA Y = NUMBER_LITERAL COMMA Z = NUMBER_LITERAL {
    double x = Double.parseDouble($X.text);
    double y = Double.parseDouble($Y.text);
    double z = Double.parseDouble($Z.text);
    System.err.println(">> " + x + " " + y + " " + z);
  }
  ;

NUMBER_LITERAL :
  UNARY_MINUS?
  (
    DOUBLE_LITERAL
    | INT_LITERAL
  )
  ;

fragment
INT_LITERAL :
  DIGIT+
  ;

fragment
DOUBLE_LITERAL :
  DIGIT+ '.'+ DIGIT+
  ;

fragment
DIGIT :
  '0'..'9'
  ;

NEW_LINE :
  '\r'? '\n'
  ;

WS :
  (
    ' '
    | '\t'
    | '\u000C'
  //| '\n'
  //| '\r'
  )+
  {$channel=HIDDEN;}
  ;
