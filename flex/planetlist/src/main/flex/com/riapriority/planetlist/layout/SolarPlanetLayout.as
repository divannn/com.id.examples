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
package com.riapriority.planetlist.layout
{
	import com.riapriority.planetlist.data.PlanetDescription;
	import com.riapriority.planetlist.renderer.PlanetRendererDimentions;
	import com.riapriority.planetlist.renderer.SolarPlanetRenderer;
	import com.riapriority.planetlist.util.PlanetCalculator;
	
	import mx.collections.ArrayCollection;
	import mx.core.ILayoutElement;
	
	import spark.layouts.supportClasses.LayoutBase;

	/**
	 * Performs orbital layout.
	 * @author Konstantin Kovalev (constantiner at gmail dot com)
	 */
	public class SolarPlanetLayout extends LayoutBase
	{
		/**
		 * Default constructor.
		 */
		public function SolarPlanetLayout()
		{
			super();
		}

		/**
		 * @private
		 */
		private var _planetCalculator:PlanetCalculator;

		/**
		 * @private
		 */
		private var planetCalculatorDirty:Boolean = false;

		/**
		 * Current layout's planet dimentions calculator.
		 * @return Current calculator.
		 */
		public function get planetCalculator():PlanetCalculator
		{
			return _planetCalculator;
		}

		/**
		 * Sets planet calculator to operate.
		 * @param value Calculator to set.
		 */
		public function set planetCalculator(value:PlanetCalculator):void
		{
			if (value != _planetCalculator)
			{
				_planetCalculator = value;
				if (target)
				{
					planetCalculatorDirty = true;
					target.invalidateSize();
					target.invalidateDisplayList();
				}
			}
		}

		/**
		 * @inheritDoc
		 */
		override public function updateDisplayList(width:Number, height:Number):void
		{
			// We don't need scrolling!
			target.setContentSize(width, height);

			var dimention:Number = Math.min(width, height);
			var xShift:Number = (width - dimention) / 2;
			var yShift:Number = (height - dimention) / 2;
			var count:int = target.numElements;
			var purePlanetsData:Vector.<PlanetDescription> = new Vector.<PlanetDescription>();
			var planetRenderers:ArrayCollection = new ArrayCollection();

			var solarRenderer:SolarPlanetRenderer;
			var element:ILayoutElement;
			var i:int;
			// Data verification and forming.
			for (i = 0; i < count; i++)
			{
				element = useVirtualLayout ? target.getVirtualElementAt(i) : target.
					getElementAt(i);
				solarRenderer = element is SolarPlanetRenderer ? element as SolarPlanetRenderer :
					null;
				if (!solarRenderer)
				{
					// TODO Localized message.
					throw new SolarPlanetLayoutException("Invalid renderer!");
				}
				planetRenderers.addItem(element);
				purePlanetsData.push(solarRenderer.planetDescription);
			}

			var dimentions:Vector.<PlanetRendererDimentions> = _planetCalculator.
				performCalculations(purePlanetsData, dimention);

			for (i = 0; i < dimentions.length; i++)
			{
				var currentDimention:PlanetRendererDimentions = dimentions[i];
				currentDimention.totalRendererDimention = dimention;
				element = planetRenderers.getItemAt(i) as ILayoutElement;
				element.setLayoutBoundsSize(dimention, dimention, false);
				element.setLayoutBoundsPosition(xShift, yShift);
				solarRenderer = planetRenderers.getItemAt(i) as SolarPlanetRenderer;
				solarRenderer.setDimentions(currentDimention, !planetCalculatorDirty);
			}
			planetCalculatorDirty = false;
		}
	}
}