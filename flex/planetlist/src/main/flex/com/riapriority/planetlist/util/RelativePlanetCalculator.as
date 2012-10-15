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
package com.riapriority.planetlist.util
{
	import com.riapriority.planetlist.data.PlanetDescription;
	import com.riapriority.planetlist.renderer.PlanetRendererDimentions;

	/**
	 * Calculates planet sizes with relative dimentions.
	 * @author Konstantin Kovalev (constantiner at gmail dot com)
	 */
	public class RelativePlanetCalculator implements PlanetCalculator
	{
		/**
		 * Default constructor.
		 */
		public function RelativePlanetCalculator()
		{
			super();
		}

		/**
		 * @inheritDoc
		 */
		public function performCalculations(planetData:Vector.<PlanetDescription>,
											solarSystemSizeInPixels:Number):Vector.<PlanetRendererDimentions>
		{
			var result:Vector.<PlanetRendererDimentions> = new Vector.<PlanetRendererDimentions>();
			var maxRadius:Number = solarSystemSizeInPixels / 2;
			var numOfPlanets:int = planetData.length;
			var radiusDelta:Number = maxRadius / (2 * numOfPlanets);
			var externalOrbit:Number = maxRadius - radiusDelta;
			var i:int;
			var pow:Number = 1 / 4;
			var externalOrbitDistance:Number = Math.pow(planetData[numOfPlanets - 1].distanceFromSunKm, pow);
			for (i = 0; i < numOfPlanets; i++) {
				var element:PlanetDescription = planetData[i];
				var dimentions:PlanetRendererDimentions = new PlanetRendererDimentions();
				dimentions.orbitRadius = externalOrbit * Math.pow(planetData[i].distanceFromSunKm, pow) / 
					externalOrbitDistance;
				result.push(dimentions);
			}
			var planetSizeDivider:Number = 0;
			for (i = 0; i < numOfPlanets; i++) {
				var currentDimentions:PlanetRendererDimentions = result[i];
				var internalRadius:Number = (i > 0) ? result [i - 1].outerRadius : 0;
				var externalRadius:Number = (i == numOfPlanets - 1) ? maxRadius : 
					(currentDimentions.orbitRadius + result[i + 1].orbitRadius) / 2;
				currentDimentions.innerRadius = internalRadius;
				currentDimentions.outerRadius = externalRadius;
				var maxPlanetRadius:Number = 
					Math.min(externalRadius - currentDimentions.orbitRadius,  
						currentDimentions.orbitRadius - internalRadius);
				var currentPlanetSizeDivider:Number = Math.pow(planetData[i].radiusKm, pow) / maxPlanetRadius;
				if (currentPlanetSizeDivider > planetSizeDivider)
				{
					planetSizeDivider = currentPlanetSizeDivider;
				}
			}
			for (i = 0; i < numOfPlanets; i++) {
				result[i].planetSize = Math.pow(planetData[i].radiusKm, pow) * 2 / planetSizeDivider;
			}
			return result;
		}
	}
}