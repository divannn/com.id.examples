package com.id.example.antlr.evaluator;

import org.antlr.runtime.ANTLRStringStream;
import org.antlr.runtime.CharStream;
import org.antlr.runtime.CommonTokenStream;
import org.antlr.runtime.RecognitionException;
import org.antlr.runtime.TokenStream;

/**
 * @author idanilov
 *
 */
public class Starter2 {

	public static void main(String[] args) {
		CharStream charStream = new ANTLRStringStream("2-(5+1)/2+3*4");
		Evaluator2Lexer lexer = new Evaluator2Lexer(charStream);
		TokenStream tokenStream = new CommonTokenStream(lexer);
		Evaluator2Parser parser = new Evaluator2Parser(tokenStream);
		try {
			int result = parser.eval();
			System.err.println("OK! result is " + result);
		} catch (RecognitionException e) {
			e.printStackTrace();
		}
	}

}
