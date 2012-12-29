package com.asfusion.weather.business
{		
	import mx.core.Application;
import mx.core.FlexGlobals;

public class Initializer {
		
		// ----------------------------------------------------------
		public function loadFlashVars():Object 
		{
			var obj:Object = new Object();
			obj.location = FlexGlobals.topLevelApplication.parameters.location;
			obj.unit = FlexGlobals.topLevelApplication.parameters.unit;


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