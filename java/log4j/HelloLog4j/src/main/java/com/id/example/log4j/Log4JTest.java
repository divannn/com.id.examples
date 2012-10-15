package com.id.example.log4j;

import org.apache.log4j.Logger;

/**
 * @author idanilov
 *
 */
public class Log4JTest {

	private static final Logger LOG = Logger.getLogger(Log4JTest.class);
	private static final Logger LOG2 = Logger.getLogger("foo");

	public static final void main(String[] args) {
		System.err.println("Hi there!");

		LOG.error("error1");
		LOG.warn("warn1");
		LOG.info("info1");
		LOG.trace("trace1");

		LOG2.error("error2");
		LOG2.warn("warn2");
		LOG2.info("info2");
		LOG2.trace("trace2");
	}

}