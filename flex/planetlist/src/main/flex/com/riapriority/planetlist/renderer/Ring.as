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
	import flash.display.Graphics;
	import flash.events.Event;
	import spark.primitives.Ellipse;

	/**
	 * Draws ring.
	 * @author Konstantin Kovalev (constantiner at gmail dot com)
	 */
	public class Ring extends Ellipse
	{
		private static const INNERHEIGHT_CHANGE_EVENT:String = "innerHeightChange";
		private static const INNERWIDTH_CHANGE_EVENT:String = "innerWidthChange";
		private static const INNERX_CHANGE_EVENT:String = "innerXChange";
		private static const INNERY_CHANGE_EVENT:String = "innerYChange";

		/**
		 * Default constructor.
		 */
		public function Ring()
		{
			super();
		}

		private var _innerHeight:Number = 0;

		private var _innerWidth:Number = 0;

		private var _innerX:Number = 0;

		private var _innerY:Number = 0;

		/**
		 * Returns inner circle height.
		 * @return Inner circle height
		 */
		[Bindable(event="innerHeightChange")]
		public function get innerHeight():Number
		{
			return _innerHeight;
		}

		/**
		 * Sets inner circle height.
		 * @param value Is inner circle height.
		 */
		public function set innerHeight(value:Number):void
		{
			if (_innerHeight != value)
			{
				_innerHeight = value;
				dispatchEvent(new Event(INNERHEIGHT_CHANGE_EVENT));
			}
		}

		/**
		 * Returns inner circle width.
		 * @return Inner circle width.
		 */
		[Bindable(event="innerWidthChange")]
		public function get innerWidth():Number
		{
			return _innerWidth;
		}

		/**
		 * Sets inner circle width.
		 * @param value Is inner circle width.
		 * 
		 */
		public function set innerWidth(value:Number):void
		{
			if (_innerWidth != value)
			{
				_innerWidth = value;
				dispatchEvent(new Event(INNERWIDTH_CHANGE_EVENT));
			}
		}

		/**
		 * Returns inner circle x-coordinate.
		 * @return Inner circle x-coordinate.
		 */
		[Bindable(event="innerXChange")]
		public function get innerX():Number
		{
			return _innerX;
		}

		/**
		 * Sets inner circle x-coordinate.
		 * @param value Is inner circle x-coordinate.
		 */
		public function set innerX(value:Number):void
		{
			if (_innerX != value)
			{
				_innerX = value;
				dispatchEvent(new Event(INNERX_CHANGE_EVENT));
			}
		}

		/**
		 * Returns inner circle y-coordinate.
		 * @return Inner circle y-coordinate.
		 */
		[Bindable(event="innerYChange")]
		public function get innerY():Number
		{
			return _innerY;
		}

		/**
		 * Sets inner circle y-coordinate.
		 * @param value Is inner circle y-coordinate.
		 */
		public function set innerY(value:Number):void
		{
			if (_innerY != value)
			{
				_innerY = value;
				dispatchEvent(new Event(INNERY_CHANGE_EVENT));
			}
		}

		/**
		 * @inheritDoc
		 */
		override protected function draw(g:Graphics):void
		{
			super.draw(g);
			g.drawEllipse(_innerX, _innerY, _innerWidth, _innerHeight);
		}
	}
}