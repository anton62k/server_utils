package com.kashirov.models.vo 
{
	import com.kashirov.models.Store;
	
	/**
	 * ...
	 * @author 
	 */
	public class StoreTop extends Store 
	{
		
		public var assign:MyStore;
		
		public function add(key:* = null, data:Object = null):MyStore { return addItem(key, data) as MyStore; }
		public function get(key:*):MyStore { return getItem(key) as MyStore; }
		public function remove(key:*):MyStore { return removeItem(key) as MyStore; }
		
	}

}