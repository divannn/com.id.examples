package com.asfusion.weather.business
{		
	import mx.core.Application;
	
	public class Initializer {
		
		// ----------------------------------------------------------
		public function loadFlashVars():Object 
		{
			var obj:Object = new Object();
			obj.location = Application.application.parameters.location;
			obj.unit = Application.application.parameters.unit;
			
			// if you are not using flas vars we set a default
			if( obj.location == null )
			{
				obj.location="92677";
				obj.unit="f";
			}
			return obj;
		}
	}
}