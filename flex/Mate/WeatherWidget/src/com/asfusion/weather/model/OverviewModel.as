package com.asfusion.weather.model
{
	import com.asfusion.mate.ioc.InjectorTarget;
	import com.yahoo.webapis.weather.CurrentConditions;
	import com.yahoo.webapis.weather.Location;

	public class OverviewModel extends InjectorTarget
	{
		/*-----------------------------------------------------------------------------------------------------------
		*                                          Public Bindable Properties
		-------------------------------------------------------------------------------------------------------------*/
		[Bindable] public var temperature:String = '';
		[Bindable] public var icon:String;
		[Bindable] public var location:String;
		
		/*-.........................................weather..........................................*/
		private var _weather:CurrentConditions;
		[Bindable]
		public function set weather(w:CurrentConditions):void 
		{
			_weather = w;
			if (_weather && !isNaN(_weather.temperature))
				temperature = _weather.temperature + 'º';
			else
				temperature = '';
		}
		public function get weather():CurrentConditions 
		{
			return _weather;
		}
		
		
		/*-.........................................locationObject..........................................*/
		private var _locationObject:Location;
		[Bindable]
		public function set locationObject(loc:Location):void 
		{
			_locationObject = loc;
			location = _locationObject.city;
		}
		public function get locationObject():Location 
		{
			return _locationObject;
		}
		
	}
}