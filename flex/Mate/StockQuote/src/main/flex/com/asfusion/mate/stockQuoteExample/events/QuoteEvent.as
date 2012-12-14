package com.asfusion.mate.stockQuoteExample.events {
import flash.events.Event;

public class QuoteEvent extends Event {
	public static const GET:String = "getQuoteEvent";

	public var symbol:String;


	public function QuoteEvent(type:String, bubbles:Boolean = true, cancelable:Boolean = false) {
		super(type, bubbles, cancelable);
	}

}
}