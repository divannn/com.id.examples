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
	import com.riapriority.planetlist.renderer.RendererWithAnimation;
	
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	
	import spark.effects.animation.Animation;
	import spark.effects.animation.IAnimationTarget;

	[Event(name="animationUpdate", type="com.riapriority.planetlist.util.PlanetAnimationEvent")]
	/**
	 * Controls planet animation.
	 * @author Konstantin Kovalev (constantiner at gmail dot com)
	 */
	public class PlanetAnimation extends EventDispatcher implements IAnimationTarget, RendererWithAnimation
	{
		private var _data:PlanetDescription;
		private var _dimentions:PlanetRendererDimentions;

		private var _rotationMultiplier:Number = 10;
		private var anim:Animation;
		private var prevValue:Number;

		
		/**
		 * @inheritDoc
		 */
		public function pauseAnimation():void
		{
			if (anim)
			{
				anim.pause();
			}
		}

		/**
		 * @inheritDoc
		 */
		public function resumeAnimation():void
		{
			if (anim)
			{
				anim.resume();
			}
		}

		/**
		 * @inheritDoc
		 */
		public function animationEnd(animation:Animation):void
		{
			startAnimation(0);
		}

		/**
		 * @inheritDoc
		 */
		public function animationRepeat(animation:Animation):void
		{
			//Empty implementation
		}

		/**
		 * @inheritDoc
		 */
		public function animationStart(animation:Animation):void
		{
			updateAnimation();
		}

		/**
		 * @inheritDoc
		 */
		public function animationStop(animation:Animation):void
		{
			//Empty implementation
		}

		/**
		 * @inheritDoc
		 */
		public function animationUpdate(animation:Animation):void
		{
			updateAnimation();
		}

		/**
		 * Planet data to operate.
		 * @param value Planet data to operate.
		 */
		public function set data(value:PlanetDescription):void
		{
			if (value != _data)
			{
				_data = value;
				if (_data)
				{
					startAnimation(0);
				}
				else
				{
					stopAnimation();
				}
			}
		}

		/**
		 * Some calculated dimentions to operate.
		 * @param value Some calculated dimentions to operate.
		 */
		public function set dimentions(value:PlanetRendererDimentions):void
		{
			if (_dimentions != value)
			{
				_dimentions = value;
				prevValue = NaN;
			}
		}

		/**
		 * Speed parameter.
		 * @param value Speed parameter.
		 */
		public function set rotationMultiplier(value:Number):void
		{
			if (_rotationMultiplier != value)
			{
				_rotationMultiplier = value;
				if (anim)
				{
					var currentValue:Number = anim.currentValue["planetAngle"];
					startAnimation(currentValue);
				}
			}
		}

		/**
		 * Starts amination.
		 * @param startValue Valuet to start animation from.
		 */
		private function startAnimation(startValue:Number):void
		{
			stopAnimation();
			if (_data)
			{
				var allTime:Number = (_data as PlanetDescription).orbitalPeriodInEarthDays *
					_rotationMultiplier;
				var endValue:Number = 2 * Math.PI;
				var duration:Number = allTime;
				if (startValue > 0)
				{
					var currentStartingTime:Number = allTime * startValue / endValue;
					duration = allTime - currentStartingTime;
				}
				anim = new Animation(duration, "planetAngle", startValue, endValue);
				anim.easer = null;
				anim.animationTarget = this;
				anim.play();
			}
		}

		/**
		 * Stops current animation.
		 */
		private function stopAnimation():void
		{
			if (anim)
			{
				anim.animationTarget = null;
				anim.stop();
				anim = null;
			}
		}

		private function updateAnimation():void
		{
			var value:Number = anim.currentValue ? anim.currentValue["planetAngle"] : 0;
			if (_dimentions)
			{
				var needRedraw:Boolean = false;
				if (isNaN(prevValue))
				{
					needRedraw = true;
				}
				else
				{
					if (Math.abs(value - prevValue) * _dimentions.orbitRadius > .1)
					{
						needRedraw = true;
					}
				}
				if (needRedraw)
				{
					var cos:Number = Math.cos(value);
					var sin:Number = Math.sin(value);
					var xShift:Number = _dimentions.orbitRadius * cos;
					var yShift:Number = _dimentions.orbitRadius * sin;
					var planet:Point = new Point();
					planet.x = xShift - _dimentions.planetSize / 2;
					planet.y = yShift - _dimentions.planetSize / 2;
					prevValue = value;
					dispatchEvent(new PlanetAnimationEvent(PlanetAnimationEvent.
														   ANIMATION_UPDATE, planet));
				}
			}
		}
	}
}