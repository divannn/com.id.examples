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
	import asmock.framework.Expect;
	import asmock.framework.MockRepository;
	import asmock.framework.constraints.Is;
	import asmock.integration.flexunit.ASMockClassRunner;
	
	import com.riapriority.asmock.constraints.VectorEquals;
	import com.riapriority.planetlist.data.PlanetDescription;
	import com.riapriority.planetlist.renderer.PlanetRendererDimentions;
	import com.riapriority.planetlist.renderer.SolarPlanetRendererImplementation;
	import com.riapriority.planetlist.util.PlanetCalculator;
	
	import flexunit.framework.Assert;
	
	import spark.components.supportClasses.GroupBase;
	import spark.components.supportClasses.ItemRenderer;

	/**
	 * Tests SolarPlanetLayout class.
	 * @author Konstantin Kovalev (constantiner at gmail dot com)
	 */
	[RunWith("asmock.integration.flexunit.ASMockClassRunner")]
	[Mock("spark.components.supportClasses.GroupBase")]
	[Mock("com.riapriority.planetlist.util.PlanetCalculator")]
	[Mock("com.riapriority.planetlist.renderer.SolarPlanetRendererImplementation")]
	public class SolarPlanetLayoutTest
	{
		private static const WIDTH:Number = 150;
		private static const HEIGHT:Number = 250;
		
		private var layout:SolarPlanetLayout;

		// Mock repository
		private var mockRepository:MockRepository = new MockRepository();

		// Mocks
		private var calculator:PlanetCalculator;
		private var targetGroup:GroupBase;
		private var renderer:SolarPlanetRendererImplementation;

		[Before]
		public function setUp():void
		{
			// Create class under test
			layout = new SolarPlanetLayout();

			// Create mock for layout's target group
			targetGroup = GroupBase(mockRepository.createStrict(GroupBase));
			Assert.assertNotNull("Mock should be created", targetGroup);
			Assert.assertTrue("Mock is an instance of expected type", targetGroup is GroupBase);
			layout.target = targetGroup;

			// Create mock for planet calculator
			calculator = PlanetCalculator(mockRepository.createStrict(PlanetCalculator));
			Assert.assertNotNull("Mock should be created", calculator);
			Assert.assertTrue("Mock is an instance of expected type", calculator is PlanetCalculator);
			
			// Create mock for renderer
			renderer = SolarPlanetRendererImplementation(mockRepository.createStrict(SolarPlanetRendererImplementation));
			mockRepository.stubEvents(renderer);
			Assert.assertNotNull("Mock should be created", renderer);
			Assert.assertTrue("Mock is an instance of expected type", renderer is SolarPlanetRendererImplementation);
		}

		[Test(description="Tests set and get values as far as calls to validate size and update display list")]
		public function setPlanetCalculator():void
		{
			// Record calls
			Expect.call(targetGroup.invalidateSize());
			Expect.call(targetGroup.invalidateDisplayList());

			mockRepository.replay(targetGroup);

			layout.planetCalculator = calculator;
			Assert.assertStrictlyEquals("Calculators are the same", calculator, layout.
										planetCalculator);

			mockRepository.verify(targetGroup);
		}

		[Test(description="Tests layout with virtual layout")]
		public function updateDisplayListVirtual():void
		{
			// Misc expected data
			var elementsCount:int = 1;
			var planetDescription:PlanetDescription = new PlanetDescription();
			var purePlanetsData:Vector.<PlanetDescription> = new <PlanetDescription>[planetDescription];
			var dimention:PlanetRendererDimentions = new PlanetRendererDimentions();
			var dimentions:Vector.<PlanetRendererDimentions> = new <PlanetRendererDimentions>[dimention];
			
			// Record calls on setting virtual layout
			Expect.call(targetGroup.invalidateDisplayList());
			
			// Record calls on setting calculator
			Expect.call(targetGroup.invalidateSize());
			Expect.call(targetGroup.invalidateDisplayList());
			
			// Record calls on updateDisplayList
			Expect.call(targetGroup.setContentSize(WIDTH, HEIGHT));
			Expect.call(targetGroup.numElements).returnValue(elementsCount);
			Expect.call(targetGroup.getVirtualElementAt(0)).returnValue(renderer);
			Expect.call(renderer.planetDescription).returnValue(planetDescription);
			Expect.call(calculator.performCalculations(null, 0)).
				constraints([new VectorEquals(Vector.<*>(purePlanetsData)), Is.equal(WIDTH)]).returnValue(dimentions);
			Expect.call(renderer.setLayoutBoundsSize(WIDTH, WIDTH, false));
			Expect.call(renderer.setLayoutBoundsPosition(0, 50));
			Expect.call(renderer.setDimentions(dimention, false));
			
			mockRepository.replay(targetGroup);
			mockRepository.replay(renderer);
			mockRepository.replay(calculator);
			
			layout.useVirtualLayout = true;
			layout.planetCalculator = calculator;
			layout.updateDisplayList(WIDTH, HEIGHT);
			
			Assert.assertEquals("Total dimantion is the same", WIDTH, dimention.totalRendererDimention);
			
			mockRepository.verify(targetGroup);
		}
		
		[Test(description="Tests layout with not virtual layout")]
		public function updateDisplayListNotVirtual():void
		{
			// Misc expected data
			var elementsCount:int = 1;
			var planetDescription:PlanetDescription = new PlanetDescription();
			var purePlanetsData:Vector.<PlanetDescription> = new <PlanetDescription>[planetDescription];
			var dimention:PlanetRendererDimentions = new PlanetRendererDimentions();
			var dimentions:Vector.<PlanetRendererDimentions> = new <PlanetRendererDimentions>[dimention];
			
			// Record calls on setting calculator
			Expect.call(targetGroup.invalidateSize());
			Expect.call(targetGroup.invalidateDisplayList());
			
			// Record calls on updateDisplayList
			Expect.call(targetGroup.setContentSize(WIDTH, HEIGHT));
			Expect.call(targetGroup.numElements).returnValue(elementsCount);
			Expect.call(targetGroup.getElementAt(0)).returnValue(renderer);
			Expect.call(renderer.planetDescription).returnValue(planetDescription);
			Expect.call(calculator.performCalculations(null, 0)).
				constraints([new VectorEquals(Vector.<*>(purePlanetsData)), Is.equal(WIDTH)]).returnValue(dimentions);
			Expect.call(renderer.setLayoutBoundsSize(WIDTH, WIDTH, false));
			Expect.call(renderer.setLayoutBoundsPosition(0, 50));
			Expect.call(renderer.setDimentions(dimention, false));
			
			mockRepository.replay(targetGroup);
			mockRepository.replay(renderer);
			mockRepository.replay(calculator);
			
			layout.useVirtualLayout = false; // BTW this is default value 
			layout.planetCalculator = calculator;
			layout.updateDisplayList(WIDTH, HEIGHT);
			
			Assert.assertEquals("Total dimantion is the same", WIDTH, dimention.totalRendererDimention);
			
			mockRepository.verify(targetGroup);
		}
		
		
		[Test(description="Tests layout with just resizing")]
		public function updateDisplayListJustResizing():void
		{
			// Misc expected data
			var elementsCount:int = 1;
			var planetDescription:PlanetDescription = new PlanetDescription();
			var purePlanetsData:Vector.<PlanetDescription> = new <PlanetDescription>[planetDescription];
			var dimention:PlanetRendererDimentions = new PlanetRendererDimentions();
			var dimentions:Vector.<PlanetRendererDimentions> = new <PlanetRendererDimentions>[dimention];
			
			// Record calls on setting calculator
			Expect.call(targetGroup.invalidateSize());
			Expect.call(targetGroup.invalidateDisplayList());
			
			// Record calls on updateDisplayList first call
			Expect.call(targetGroup.setContentSize(WIDTH, HEIGHT));
			Expect.call(targetGroup.numElements).returnValue(elementsCount);
			Expect.call(targetGroup.getElementAt(0)).returnValue(renderer);
			Expect.call(renderer.planetDescription).returnValue(planetDescription);
			Expect.call(calculator.performCalculations(null, 0)).
				constraints([new VectorEquals(Vector.<*>(purePlanetsData)), Is.equal(WIDTH)]).returnValue(dimentions);
			Expect.call(renderer.setLayoutBoundsSize(WIDTH, WIDTH, false));
			Expect.call(renderer.setLayoutBoundsPosition(0, 50));
			Expect.call(renderer.setDimentions(dimention, false));
			
			// Record calls on updateDisplayList second call
			Expect.call(targetGroup.setContentSize(WIDTH, HEIGHT));
			Expect.call(targetGroup.numElements).returnValue(elementsCount);
			Expect.call(targetGroup.getElementAt(0)).returnValue(renderer);
			Expect.call(renderer.planetDescription).returnValue(planetDescription);
			Expect.call(calculator.performCalculations(null, 0)).
				constraints([new VectorEquals(Vector.<*>(purePlanetsData)), Is.equal(WIDTH)]).returnValue(dimentions);
			Expect.call(renderer.setLayoutBoundsSize(WIDTH, WIDTH, false));
			Expect.call(renderer.setLayoutBoundsPosition(0, 50));
			// The difference only in this call
			Expect.call(renderer.setDimentions(dimention, true));
			
			mockRepository.replay(targetGroup);
			mockRepository.replay(renderer);
			mockRepository.replay(calculator);
			
			layout.useVirtualLayout = false; // BTW this is default value 
			layout.planetCalculator = calculator;
			layout.updateDisplayList(WIDTH, HEIGHT);
			// THe second call without setting calculator. So we don't need animation and treat it as resizing
			layout.updateDisplayList(WIDTH, HEIGHT);
			
			Assert.assertEquals("Total dimantion is the same", WIDTH, dimention.totalRendererDimention);
			
			mockRepository.verify(targetGroup);
		}
		
		[Test(description="Tests layout with wrong renderer",
			expects="com.riapriority.planetlist.layout.SolarPlanetLayoutException")]
		public function updateDisplayListWithWrongRenderers():void
		{
			// Misc expected data
			var elementsCount:int = 1;
			
			// Record calls on setting calculator
			Expect.call(targetGroup.invalidateSize());
			Expect.call(targetGroup.invalidateDisplayList());
			
			// Record calls on updateDisplayList
			Expect.call(targetGroup.setContentSize(WIDTH, HEIGHT));
			Expect.call(targetGroup.numElements).returnValue(elementsCount);
			// Return type which does not implement required interface
			Expect.call(targetGroup.getElementAt(0)).returnValue(new ItemRenderer());
			
			mockRepository.replay(targetGroup);
			mockRepository.replay(renderer);
			mockRepository.replay(calculator);
			
			layout.useVirtualLayout = false; // BTW this is default value 
			layout.planetCalculator = calculator;
			layout.updateDisplayList(WIDTH, HEIGHT);
			
			Assert.fail("Will never call");
			
			mockRepository.verify(targetGroup);
		}
	}
}