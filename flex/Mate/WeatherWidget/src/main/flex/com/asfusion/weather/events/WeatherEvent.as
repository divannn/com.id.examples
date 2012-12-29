package com.asfusion.weather.events
{
	import flash.events.Event;

	public class WeatherEvent extends Event
	{
		
		/*-.........................................Constants..........................................*/
		public static const GET:String = 'getWeatherEvent';
		
		
		/*-.........................................Properties..........................................*/
		public var location:String;
		public var unit:String;
		
		
		/*-.........................................Constructor..........................................*/
		public function WeatherEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}