package com.kashirov.models 
{
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import org.as3commons.collections.framework.core.SetIterator;
	import org.as3commons.collections.Map;
	import org.as3commons.collections.Set;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author 
	 */
	public class BaseModel 
	{
		
		public var signal:Signal;
		public var prefix:String;
		
		private var modelFields:Set;
		private var exclude:Array = ['prefix', 'signal'];
		
		public function BaseModel() 
		{	
			init();
		}
		
		public function updateField(field:String, value:*):void
		{
			this[field] = value;
		}
		
		public function dispose():void
		{
			signal.removeAll();
			
			var iterator:SetIterator = modelFields.iterator() as SetIterator;
			while (iterator.hasNext()) {
				iterator.next();
				var field:* = this[iterator.current];
				
				if (field is BaseModel || field is Store || field is Hash) {
					field.dispose();
				}
			}
		}
		
		public function data():Object
		{
			var rt:Object = { };
			
			var iterator:SetIterator = modelFields.iterator() as SetIterator;
			while (iterator.hasNext()) {
				iterator.next();
				var field:* = this[iterator.current];
				
				if (field is BaseModel || field is Store || field is Hash) {
					rt[iterator.current] = field.data();
				} else {
					rt[iterator.current] = this[iterator.current];
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
				signal.dispatch(fields);
			}
		}
		
		public function iterator():SetIterator
		{
			return modelFields.iterator() as SetIterator;
		}		
		
		private function init():void
		{
			signal = new Signal(Map);
			parseModelFields();			
		}
		
		private function parseModelFields():void 
		{
			modelFields = new Set();
			var structure:XML = describeType(this);
			for each (var childNode:XML in structure.variable) {
				var name:String = childNode.@name;
				if (exclude.indexOf(name) != -1) continue;
				var type:String = childNode.@type;
				var clazz:Class = getDefinitionByName(type) as Class;
				if (!this[name]) this[name] = new clazz();
				modelFields.add(name);
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