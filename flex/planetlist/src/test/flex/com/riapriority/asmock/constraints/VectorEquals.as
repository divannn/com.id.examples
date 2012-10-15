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
package com.riapriority.asmock.constraints
{
	import asmock.framework.constraints.AbstractConstraint;


	/**
	 * Implements constraint to compare vectors within testing with ASMock.
	 * @author Konstantin Kovalev (constantiner at gmail dot com)
	 */
	public class VectorEquals extends AbstractConstraint
	{
		private var _values:Vector.<*>;

		public function VectorEquals(values:Vector.<*>)
		{
			if (values == null)
			{
				throw new ArgumentError("values cannot be null");
			}

			_values = values;
		}


		/**
		 * @inheritDoc
		 */
		public override function eval(obj:Object):Boolean
		{
			var arr:Vector.<*> = Vector.<*>(obj);

			if (arr == null || arr.length != _values.length)
			{
				return false;
			}

			for (var i:uint = 0; i < _values.length; i++)
			{
				if (arr[i] != _values[i])
				{
					return false;
				}
			}

			return true;
		}

		/**
		 * @inheritDoc
		 */
		public override function get message():String
		{
			var sb:String = "equal to vector [";

			for (var i:uint = 0; i < _values.length; i++)
			{
				if (i > 0)
				{
					sb += ", ";
				}

				sb += _values[i];
			}

			sb += "]";

			return sb;
		}

	}
}