package com.asfusion.mate.stockQuoteExample.business {
public class QuoteManager {

	public function QuoteManager() {
		trace("++++ new model");
	}

// --------------------------------------------
	// In this simple example, we make this property public.
	// To indicate that this manager is the only object that can
	// change it, we would have only a getter. If we use a getter,
	// we must ensure it is still bindable by using the [Bindable (event="currentPriceChange")]
	// meta tag and dispatching that event whenever the property changes
	// its value.

	[Bindable]
	public var currentPrice:Number = 0;

	// --------------------------------------------
	public function storeQuote(price:Number):void {
		trace(">>>--------------- " + price);
		currentPrice = price;
	}

}
}