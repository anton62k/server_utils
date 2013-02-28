package com.kashirov.net.models 
{
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import org.as3commons.collections.Map;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author 
	 */
	public class BaseModel 
	{
		
		public var fieldsDispatch:Signal;
		
		private var structure:XML;
		
		public function BaseModel() 
		{
			structure = describeType(this);
			fieldsDispatch = new Signal(Map);
			
			for each (var childNode:XML in structure.variable) {
				var name:String = childNode.@name;
				var type:String = childNode.@type;
				var clazz:Class = getDefinitionByName(type) as Class;
				if (!this[name]) this[name] = new clazz();
			}
		}
		
		public function dispose():void
		{
			fieldsDispatch.removeAll();
			
			for each (var childNode:XML in structure.variable) {
				var name:String = childNode.@name;
				var field:* = this[name];
				
				if (field is BaseModel || field is Store || field is Hash) {
					field.dispose();
				}
			}
		}
		
		public function data():Object
		{
			var rt:Object = { };
			
			for each (var childNode:XML in structure.variable) {
				var name:String = childNode.@name;
				var field:* = this[name];
				
				if (field is BaseModel || field is Store || field is Hash) {
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
				
				if (field is BaseModel) {
					parseBaseModel(field as BaseModel, itemData);
				} else if (field is Store) {
					parseStore(field as Store, itemData);
					
				} else if (field is Hash) {
					parseHash(field as Hash, itemData);
					
				} else {
					parseField(name, itemData)
				}
				
				fields.add(name, this[name]);
			}
			
			if (fields.size) {
				fieldsDispatch.dispatch(fields);
			}
		}
		
		private function parseField(name:String, data:Object):void
		{
			this[name] = data;
		}
		
		private function parseHash(hash:Hash, data:Object):void
		{
			hash.updateData(data);
		}
		
		private function parseBaseModel(model:BaseModel, data:Object):void
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
				
				var item:BaseModel = model.getItem(name) || model.addItem(name);
				item.updateData(data[name]);
			}
		}
		
	}

}