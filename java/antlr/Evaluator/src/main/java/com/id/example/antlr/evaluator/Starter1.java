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
public class Starter1 {

	public static void main(String[] args) {
		CharStream charStream = new ANTLRStringStream("(3*4)/(2*3)");
		Evaluator1Lexer lexer = new Evaluator1Lexer(charStream);
		TokenStream tokenStream = new CommonTokenStream(lexer);
		Evaluator1Parser parser = new Evaluator1Parser(tokenStream);
		try {
			parser.eval();
			System.err.println("OK!");
		} catch (RecognitionException e) {
			e.printStackTrace();
		}
	}

}
