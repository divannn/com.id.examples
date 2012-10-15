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

	/**
	 * Represents planet dimentions for renderer.
	 * @author Konstantin Kovalev (constantiner at gmail dot com)
	 */
	[Bindable]
	public class PlanetRendererDimentions
	{

		/**
		 * Default constructor.
		 */
		public function PlanetRendererDimentions()
		{
			super();
		}

		/**
		 * Inner radius for renderer in pixels.
		 */
		public var innerRadius:Number;
		/**
		 * Orbital radius for planet in renderer in pixels.
		 */
		public var orbitRadius:Number;
		/**
		 * Outer radius for renderer in pixels.
		 */
		public var outerRadius:Number;
		/**
		 * Planet diameter in pixels.
		 */
		public var planetSize:Number;
		/**
		 * The total width (and height) of square renderer in pixels.
		 * The orbits are inside in center.
		 */
		public var totalRendererDimention:Number;

		/**
		 * Compares two objects.
		 * @param dimention Object to compare to.
		 * @return True if objects are equal.
		 *
		 */
		public function equals(dimention:PlanetRendererDimentions):Boolean
		{
			if (!dimention)
			{
				return false;
			}
			if (dimention.innerRadius != innerRadius)
			{
				return false;
			}
			if (dimention.orbitRadius != orbitRadius)
			{
				return false;
			}
			if (dimention.outerRadius != outerRadius)
			{
				return false;
			}
			if (dimention.planetSize != planetSize)
			{
				return false;
			}
			return true;
		}

		/**
		 * String representation of the object for debugging purposes.
		 * @return String representation.
		 */
		public function toString():String
		{
			return "PlanetRendererDimentions{innerRadius:" + innerRadius + ", orbitRadius:" +
				orbitRadius + ", outerRadius:" + outerRadius + ", planetSize:" +
				planetSize + ", totalRendererDimention:" + totalRendererDimention +
				"}";
		}
	}
}