////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2010, Konstantin Kovalev aka Constantiner (constantiner at gmail dot com)
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification, are permitted provided that 
// the following conditions are met:
// * Redistributions of source code must retain the above copyright notice, this list of conditions and 
// the following disclaimer.
// * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and 
// the following disclaimer in the documentation and/or other materials provided with the distribution.
// * Neither the name of the Konstantin Kovalev aka Constantiner nor the names of its contributors 
// may be used to endorse or promote products derived from this software 
// without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS 
// OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY 
// AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER 
// OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, 
// OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; 
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, 
// WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT 
// OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
////////////////////////////////////////////////////////////////////////////////
package com.riapriority.planetlist.data
{

	/**
	 * Describes planet.
	 * @author Konstantin Kovalev (constantiner at gmail dot com)
	 */
	[Bindable]
	public class PlanetDescription
	{
		/**
		 * Default constructor.
		 */
		public function PlanetDescription()
		{
			super();
		}

		/**
		 * Distance from Sun in kilometers.
		 */
		public var distanceFromSunKm:Number;
		/**
		 * The class to display planet image.
		 */
		public var image:Class;
		/**
		 * Planet name to display.
		 */
		public var name:String;
		/**
		 * The full orbital period in Earth' days.
		 */
		public var orbitalPeriodInEarthDays:Number;
		/**
		 * Planet radius in kilometers.
		 */
		public var radiusKm:Number;

		/**
		 * String representation of the object for debugging purposes.
		 * @return String representation.
		 */
		public function toString():String
		{
			return "PlanetDescription{distanceFromSunKm:" + distanceFromSunKm + ", image:" +
				image + ", name:\"" + name + "\", orbitalPeriodInEarthDays:" + orbitalPeriodInEarthDays +
				", radiusKm:" + radiusKm + "}";
		}
	}
}