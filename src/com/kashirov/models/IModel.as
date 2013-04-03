package com.kashirov.models 
{
	
	/**
	 * ...
	 * @author 
	 */
	public interface IModel 
	{
		
		function get prefix():String;
		function set prefix(value:String):void;
		
		function data():Object;
		function updateData(value:Object):void;
		function dispose():void;
		
	}
	
}