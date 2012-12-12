package com.asfusion.mate.stockQuoteExample.business {

// --------------------------------------------
// This helper class parses data coming from the
// stock quotes web service and converts it into
// an object

public class QuoteServiceParser {
	// --------------------------------------------
	// The webservice returns a string representation
	// of an xml object. We first convert to xml
	// and then get the properties from it
	public function parseQuoteResults(quote:String):Object {
		trace("~~~ parse xml " );
		trace(new XML(quote));
		trace("~~~");
		var xml:XML = new XML(quote);

		var quoteObject:Object = new Object();

		quoteObject.lastPrice = xml.Stock.Last.toString();
		quoteObject.symbol = xml.Stock.Symbol.toString();
		quoteObject.change = xml.Stock.Change.toString();
		quoteObject.name = xml.Stock.Name.toString();

		return quoteObject;
	}

}
}