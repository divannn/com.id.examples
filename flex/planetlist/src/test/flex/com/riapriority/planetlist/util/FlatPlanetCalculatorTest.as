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
	 * Tests com.riapriority.planetlist.util.FlatPlanetCalculator
	 * @author Konstantin Kovalev (constantiner at gmail dot com)
	 */
	public class FlatPlanetCalculatorTest extends PlanetCalculatorTestBase
	{
		[Test]
		public function performCalculations():void
		{
			var solarSystemSizeInPixels:Number = 200;
			var externalPlanet:PlanetDescription = getPlanetDescription(2000, 100);
			var internalPlanet:PlanetDescription = getPlanetDescription(1000, 50);
			var planetData:Vector.<PlanetDescription> = new <PlanetDescription>[internalPlanet, externalPlanet];
			
			var calculator:PlanetCalculator = new FlatPlanetCalculator();
			var dimentions:Vector.<PlanetRendererDimentions> = 
				calculator.performCalculations(planetData, solarSystemSizeInPixels);
			var innerDimentions:PlanetRendererDimentions = dimentions[0];
			assertDimentionsTheSame("Inner planet dimentions should be the same", 0, 25, 50, 50, innerDimentions);
			var outerDimentions:PlanetRendererDimentions = dimentions[1];
			assertDimentionsTheSame("Outer planet dimentions should be the same", 50, 75, 100, 50, outerDimentions);
		}
	}
}