package com.id.example.antlr.evaluator;

import org.antlr.runtime.ANTLRStringStream;
import org.antlr.runtime.CharStream;
import org.antlr.runtime.CommonTokenStream;
import org.antlr.runtime.RecognitionException;
import org.antlr.runtime.TokenStream;
import org.antlr.runtime.tree.CommonTreeNodeStream;

import com.id.example.antlr.evaluator.Evaluator3Parser.eval_return;

/**
 * @author idanilov
 *
 */
public class Starter3 {

	public static void main(String[] args) {
		CharStream charStream = new ANTLRStringStream("2-4*(9%2)/3");
		Evaluator3Lexer lexer = new Evaluator3Lexer(charStream);
		TokenStream tokenStream = new CommonTokenStream(lexer);
		Evaluator3Parser parser = new Evaluator3Parser(tokenStream);
		try {
			eval_return parse_result = parser.eval();
			System.err.println("AST: " + parse_result.tree.toStringTree());

			CommonTreeNodeStream treeNodeStream = new CommonTreeNodeStream(
					parse_result.tree);
			EvaluatorWalker treeWalker = new EvaluatorWalker(treeNodeStream);
			int result = treeWalker.eval();
			System.err.println("OK! result is " + result);
		} catch (RecognitionException e) {
			e.printStackTrace();
		}
	}
}
