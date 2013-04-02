package com.kashirov.models 
{
	import flash.utils.describeType;
	import flash.utils.flash_proxy;
	import flash.utils.getDefinitionByName;
	import flash.utils.Proxy;
	import org.as3commons.collections.framework.core.SetIterator;
	import org.as3commons.collections.Map;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author 
	 */
	public class Unit extends Proxy
	{
		
		public var signal:Signal;
		public var prefix:String;
		
		private var modelFields:Array;
		private var exclude:Array = ['prefix', 'signal'];
		
		override flash_proxy function nextNameIndex(index:int):int 
		{
			if (index < modelFields.length) {
				return index + 1;
			} else {
				return 0;
			}
		}
		
		override flash_proxy function nextName (index:int):String
		{
			return modelFields[index - 1];
		}
		
		override flash_proxy function nextValue(index:int):*
		{
			var field:String = modelFields[index - 1];
			return this[field];
		}
		
		public function Unit() 
		{	
			signal = new Signal(Map);
			parseModelFields();		
		}
		
		public function updateField(field:String, value:*):void
		{
			this[field] = value;
		}
		
		public function dispose():void
		{
			signal.removeAll();
			
			for (var name:String in this) 
			{
				var field:* = this[name];
				
				if (field is Unit || field is Store || field is Hash) {
					field.dispose();
				}
			}
		}
		
		public function data():Object
		{
			var rt:Object = { };
			
			for (var name:String in this) 
			{
				var field:* = this[name];
				
				if (field is Unit || field is Store || field is Hash) {
					rt[name] = field.data();
				} else {
					rt[name] = this[name];
				}
			}
			
			return rt;
		}
		
		public function updateData(data:Object, dispatchSignal:Boolean = true):void
		{
			var fields:Map = new Map();
			
			for (var name:String in data) 
			{
				var field:* = this[name];
				var itemData:Object = data[name];
				
				if (field is Unit) {
					parseBaseModel(field as Unit, itemData);
				} else if (field is Store) {
					parseStore(field as Store, itemData);
					
				} else if (field is Hash) {
					parseHash(field as Hash, itemData);
					
				} else {
					if (itemData != this[name]) {
						parseField(name, itemData)
						fields.add(name, this[name]);
					}
				}
				
			}
			
			if (fields.size) {
				signal.dispatch(fields);
			}
		}
		
		private function parseModelFields():void 
		{
			modelFields = [];
			var structure:XML = describeType(this);
			for each (var childNode:XML in structure.variable) {
				var name:String = childNode.@name;
				if (exclude.indexOf(name) != -1) continue;
				var type:String = childNode.@type;
				var clazz:Class = getDefinitionByName(type) as Class;
				if (!this[name]) this[name] = new clazz();
				modelFields.push(name);
			}
			modelFields = modelFields.sort();
		}
		
		private function parseField(name:String, data:Object):void
		{
			this[name] = data;
		}
		
		private function parseHash(hash:Hash, data:Object):void
		{
			hash.updateData(data);
		}
		
		private function parseBaseModel(model:Unit, data:Object):void
		{
			model.updateData(data);
		}
		
		private function parseStore(model:Store, data:Object):void
		{
			for (var name:String in data) 
			{
				var value:Object = data[name];
				
				if (value == null && model.getItem(name)) {
					model.removeItem(name);
					continue;
				}
				
				var item:Unit = model.getItem(name) || model.addItem(name);
				item.updateData(data[name]);
			}
		}
		
	}

}