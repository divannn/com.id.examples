package com.asfusion.weather.business
{
	import com.yahoo.webapis.weather.CurrentConditions;
	import com.yahoo.webapis.weather.Location;
	import com.yahoo.webapis.weather.Units;
	import com.yahoo.webapis.weather.Weather;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class WeatherManager extends EventDispatcher
	{
		private var _weather:Weather;
		public function setWeather(w:Weather):void 
		{
			_weather = w;
			dispatchEvent(new Event("weatherChange"));
		}
		
		[Bindable (event="weatherChange")]
		public function get currentWeather():CurrentConditions
		{
			return (_weather != null)?_weather.current:null;
		}
		
		[Bindable (event="weatherChange")]
		public function get currentWeatherImage():String
		{
			return codeToImage((_weather!=null)?_weather.current.code:3200);
		}
		
		[Bindable (event="weatherChange")]
		public function get units():Units
		{
			return (_weather!=null)?_weather.units:null;
		}
		
		[Bindable (event="weatherChange")]
		public function get location():Location
		{
			return (_weather != null)?_weather.location:null;
		}
		
		
		public function handleFault(message:String):void {
			trace(message);
		}
		
		// -------------------------------------------------
		public function codeToImage(code:Number):String {
			var image:String = '';
			
			switch (code) {
				case 0: image = 'windy'; break;//0  	tornado
				case 1: image = 'heavyRain'; break; // 	tropical storm
				case 2: image = 'windyRain'; break; // 	hurricane
				case 3: //  	severe thunderstorms
				case 4: image = 'thunderstorms'; break; //  	thunderstorms
				case 5:  //  	mixed rain and snow
				case 6:  //  	mixed rain and sleet
				case 7: image = 'icyFrozenSnow'; break; //  	mixed snow and sleet
				case 8: image = 'icydrizzle'; break; //  	freezing drizzle
				case 9: image = 'drizzle'; break; //  	drizzle
				case 10: image = 'icydrizzle'; break; //  	freezing rain
				case 11:  //  	showers
				case 12: image = 'showers'; break; //  	showers
				case 13: image = 'lightSnow'; break; //  	snow flurries
				case 14: image = 'lightSnow'; break; //  	light snow showers
				case 15: image = 'windySnow'; break; //  	blowing snow
				case 16: image = 'medSnow'; break; //  	snow
				case 17: image = 'sleet'; break; //  	hail
				case 18: image = 'sleet'; break; //  	sleet
				case 19: image = 'dust'; break; //  	dust
				case 20: image = 'fog'; break; //  	foggy
				case 21: image = 'haze'; break; //  	haze
				case 22: image = 'smoke'; break; //  	smoky
				case 23: image = 'windy'; break; //  	blustery
				case 24: image = 'windy'; break; //  	windy
				case 25: image = 'snow'; break; //  	cold
				case 26: image = 'cloudy'; break; //  	cloudy
				case 27: image = 'mostlyCloudyNight'; break; //  	mostly cloudy (night)
				case 28: image = 'mostlyCloudyDay'; break; //  	mostly cloudy (day)
				case 29: image = 'partiallyCloudyNight'; break; //  	partly cloudy (night)
				case 30: image = 'partiallyCloudyDay'; break; //  	partly cloudy (day)
				case 31: image = 'moon'; break; //  	clear (night)
				case 32: image = 'sun'; break; //  	sunny
				case 33: image = 'lightCloudsNight'; break; //  	fair (night)
				case 34: image = 'lightCloudsDay'; break; //  	fair (day)
				case 35: image = 'icydrizzle'; break; //  	mixed rain and hail
				case 36: image = 'sun'; break; //  	hot
				case 37:  //  	isolated thunderstorms
				case 38:  //  	scattered thunderstorms
				case 39: image = 'sunnyThunderStorm'; break; //  	scattered thunderstorms
				case 40: image = 'sunnyRain'; break; //  	scattered showers
				case 41: image = 'medSnow'; break; //  	heavy snow
				case 42: image = 'medSnow'; break; //  	scattered snow showers
				case 43: image = 'medSnow'; break; //  	heavy snow
				case 44: image = 'partiallyCloudyDay'; break; //  	partly cloudy
				case 45: image = 'thunderstorms'; break; //  	thundershowers
				case 46: image = 'medSnow'; break; //  	snow showers
				case 47: image = 'sunnyThunderStorm'; break; //  	isolated thundershowers
				case 3200: image = 'unknown'; break; //  	not available
			}
			return image + '.png';

		}

	}
}