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
package com.riapriority.planetlist.renderer
{
	import flexunit.framework.Assert;

	/**
	 * Tests com.riapriority.planetlist.renderer.PlanetRendererDimentions
	 * @author Konstantin Kovalev (constantiner at gmail dot com)
	 */
	public class PlanetRendererDimentionsTest
	{
		private static const INNER_RADIUS:Number = 42512;
		private static const ORBIT_RADIUS:Number = 784526;
		private static const OUTER_RADIUS:Number = 325124;
		private static const PLANET_SIZE:Number = 895945;
		private static const TOTAL_RENDERER_DIMENTION:Number = 13456;

		private var planetRendererDimentions:PlanetRendererDimentions = getDimentions(INNER_RADIUS,
																					  ORBIT_RADIUS,
																					  OUTER_RADIUS,
																					  PLANET_SIZE,
																					  TOTAL_RENDERER_DIMENTION);

		[Test(description="Test equality with null description")]
		public function equalsWithNull():void
		{
			var nullDimentions:PlanetRendererDimentions;
			Assert.assertFalse("Dimentions are not equal", planetRendererDimentions.
							   equals(nullDimentions));
		}

		[Test(description="Test equality except innerRadius")]
		public function equalsExceptInnerRadius():void
		{
			var dimentions:PlanetRendererDimentions = getDimentions(INNER_RADIUS +
																	1, ORBIT_RADIUS,
																	OUTER_RADIUS,
																	PLANET_SIZE,
																	TOTAL_RENDERER_DIMENTION);
			Assert.assertFalse("Dimentions are not equal", planetRendererDimentions.
							   equals(dimentions));
		}

		[Test(description="Test equality except orbitRadius")]
		public function equalsExceptOrbitRadius():void
		{
			var dimentions:PlanetRendererDimentions = getDimentions(INNER_RADIUS,
																	ORBIT_RADIUS +
																	1, OUTER_RADIUS,
																	PLANET_SIZE,
																	TOTAL_RENDERER_DIMENTION);
			Assert.assertFalse("Dimentions are not equal", planetRendererDimentions.
							   equals(dimentions));
		}

		[Test(description="Test equality except outerRadius")]
		public function equalsExceptOuterRadius():void
		{
			var dimentions:PlanetRendererDimentions = getDimentions(INNER_RADIUS,
																	ORBIT_RADIUS,
																	OUTER_RADIUS +
																	1, PLANET_SIZE,
																	TOTAL_RENDERER_DIMENTION);
			Assert.assertFalse("Dimentions are not equal", planetRendererDimentions.
							   equals(dimentions));
		}

		[Test(description="Test equality except planetSize")]
		public function equalsExceptPlanetSize():void
		{
			var dimentions:PlanetRendererDimentions = getDimentions(INNER_RADIUS,
																	ORBIT_RADIUS,
																	OUTER_RADIUS,
																	PLANET_SIZE +
																	1, TOTAL_RENDERER_DIMENTION);
			Assert.assertFalse("Dimentions are not equal", planetRendererDimentions.
							   equals(dimentions));
		}

		[Test(description="Test equality except totalRendererDimention")]
		public function equalsExceptTotalRendererDimention():void
		{
			var dimentions:PlanetRendererDimentions = getDimentions(INNER_RADIUS,
																	ORBIT_RADIUS,
																	OUTER_RADIUS,
																	PLANET_SIZE,
																	TOTAL_RENDERER_DIMENTION +
																	1);
			Assert.assertTrue("Dimentions are equal", planetRendererDimentions.equals(dimentions));
		}

		private function getDimentions(innerRadius:Number, orbitRadius:Number, outerRadius:Number,
									   planetSize:Number, totalRendererDimention:Number):PlanetRendererDimentions
		{
			var result:PlanetRendererDimentions = new PlanetRendererDimentions();
			result.innerRadius = innerRadius;
			result.orbitRadius = orbitRadius;
			result.outerRadius = outerRadius;
			result.planetSize = planetSize;
			result.totalRendererDimention = totalRendererDimention;
			return result;
		}
	}
}