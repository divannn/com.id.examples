package com.id.example.antlr.graviparsers;

/**
 * @author idanilov
 * 
 */
public class SyntaxError {

	protected int line = -1;
	protected int col = -1;
	protected String message;

	public SyntaxError(int line, int col, String message) {
		this.line = line;
		this.col = col;
		this.message = message;
	}

	public String getMessage() {
		return message;
	}

	public int getLine() {
		return line;
	}

	public int getColumn() {
		return this.col + 1;// antlr column is 0-based.
	}

	public String toString() {
		return String.format("line=%d,col=%d,msg=%s", new Integer(getLine()),
				new Integer(getColumn()), message);
	}

}