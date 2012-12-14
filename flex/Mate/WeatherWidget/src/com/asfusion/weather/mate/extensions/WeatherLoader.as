package com.asfusion.weather.mate.extensions
{
	import com.asfusion.mate.actionLists.IScope;
	import com.asfusion.mate.actions.AbstractServiceInvoker;
	import com.asfusion.mate.actions.IAction;
	import com.yahoo.webapis.weather.Units;
	import com.yahoo.webapis.weather.WeatherService;
	import com.yahoo.webapis.weather.events.WeatherErrorEvent;
	import com.yahoo.webapis.weather.events.WeatherResultEvent;

	public class WeatherLoader extends AbstractServiceInvoker implements IAction
	{	
		public var location:String;
		public var unit:String = Units.ENGLISH_UNITS;
		public var url:String = 'http://weather.yahooapis.com/forecastrss';
		
		// the service that we are wrapping
		private var weatherService:WeatherService;
		
		public function WeatherLoader() 
		{
			weatherService = new WeatherService();
			currentInstance = this;	
		}
		
		// ---------------------------------------------------------
		override protected function run(scope:IScope):void 
		{
			
			weatherService.api_URL = url;
			
			// specify that the dispatcher of the result and error event is the weatherService object
			innerHandlersDispatcher = weatherService;
			
			if (resultHandlers && resultHandlers.length > 0)
			{
				createInnerHandlers(scope, WeatherResultEvent.WEATHER_LOADED, resultHandlers);
			}
			
			if (faultHandlers && faultHandlers.length > 0)
			{
				createInnerHandlers(scope, WeatherErrorEvent.INVALID_LOCATION , faultHandlers);
			}
			
			weatherService.getWeather(location, unit);
		}
	}
}