package com.asfusion.weather.model
{
	import com.asfusion.mate.ioc.InjectorTarget;
	import com.yahoo.webapis.weather.CurrentConditions;
	import com.yahoo.webapis.weather.Units;

	public class DetailModel extends InjectorTarget
	{
		/*-----------------------------------------------------------------------------------------------------------
		*                                          Public Bindable Properties
		-------------------------------------------------------------------------------------------------------------*/
		[Bindable] 
		public var description:String;
		
		[Bindable] 
		public var humidity:Number;
		
		[Bindable] 
		public var pressure:String;
		
		[Bindable] 
		public var visibility:String;
		
		[Bindable] 
		public var wind:String;
		
		
		
		/*-.........................................weather..........................................*/
		private var _weather:CurrentConditions;
		public function get weather():CurrentConditions 
		{
			return _weather;
		}
		
		[Bindable] 
		public function set weather(w:CurrentConditions):void {
			_weather = w;
			humidity = _weather.atmosphere.humidity;
			description = _weather.description;
			formatUnits();
		}
		
		
		/*-.........................................units..........................................*/
		private var _units:Units;
		public function get units():Units 
		{
			return _units;
		}
		[Bindable]
		public function set units(u:Units):void 
		{
			_units = u;
			formatUnits();
		}
		
		
		/*-.........................................formatUnits..........................................*/
		private function formatUnits():void 
		{
			if (weather && units) {
				pressure = weather.atmosphere.pressure + " " + units.pressure + " and " + weather.atmosphere.rising;
				wind = (weather.wind.speed > 0)?( weather.wind.speed + " " + units.speed):'Calm';
				visibility =  Number(weather.atmosphere.visibility)/100 + " " +  units.distance;
			}			
		}
		
	}
}