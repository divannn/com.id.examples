package com.id.example.antlr.graviparsers;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import junit.framework.Assert;

import org.antlr.runtime.ANTLRInputStream;
import org.antlr.runtime.CharStream;
import org.antlr.runtime.CommonTokenStream;
import org.antlr.runtime.RecognitionException;
import org.antlr.runtime.TokenStream;
import org.junit.Test;

/**
 * @author idanilov
 * 
 */
public class PonitsTest /* extends TestCase */{

	// @Before
	// protected void setUp() throws Exception {
	// }

	@Test
	public void testValid1() throws IOException {
		System.err.println("testValid1");
		PointsParser parser = getParser("/valid1.pnt");
		doTest(parser);
	}

	@Test(expected = ParserException.class)
	public void testEmpty1() throws IOException {
		System.err.println("testEmpty1");
		PointsParser parser = getParser("/empty1.pnt");
		doTest(parser);
	}

	@Test(expected = ParserException.class)
	public void testEmpty2() throws IOException {
		System.err.println("testEmpty2");
		PointsParser parser = getParser("/empty2.pnt");
		doTest(parser);                  
	}

	@Test(expected = LexerException.class)
	public void testInvalid1() throws IOException {
		System.err.println("testInvalid1");
		PointsParser parser = getParser("/invalid1.pnt");
		doTest(parser);
	}
	
	@Test(expected = ParserException.class)
	public void testInvalid2() throws IOException {
		System.err.println("testInvalid2");
		PointsParser parser = getParser("/invalid2.pnt");
		doTest(parser);
	}

	private void doTest(PointsParser parser) throws LexerException,
			ParserException {
		try {
			parser.file();
			List<SyntaxError> lexerErrors = getLexer(parser).getErrors();
			if (lexerErrors.size() > 0) {
				System.err.println("  Lexer errors found:");
				for (SyntaxError n : lexerErrors) {
					System.err.println("\t" + n);
				}
				throw new LexerException("Lexer failed");
			}

			List<SyntaxError> parserErrors = parser.getErrors();
			if (parserErrors.size() > 0) {
				System.err.println("  Parser errors found:");
				SyntaxError firstError = parser.getErrors().get(0);
				System.err.println("\t" + firstError);
				throw new ParserException("Parser failed");
			}
			// System.err.println("OK!");
		} catch (RecognitionException e) {
			// never thrown. see @rulecatch in grammar.
			e.printStackTrace();
			// System.err.println(e.line + ":" + e.charPositionInLine);
			Assert.fail("Parser failed");
		}
	}

	private PointsParser getParser(String fileName) throws IOException {
		InputStream is = getClass().getResourceAsStream(fileName);
		CharStream charStream = new ANTLRInputStream(is);
		PointsLexer lexer = new PointsLexer(charStream);
		TokenStream tokenStream = new CommonTokenStream(lexer);
		PointsParser result = new PointsParser(tokenStream);
		return result;
	}

	private PointsLexer getLexer(PointsParser parser) {
		return (PointsLexer) parser.getTokenStream().getTokenSource();
	}

}
