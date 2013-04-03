package com.kashirov.models.vo 
{
	import com.kashirov.models.Store;
	
	/**
	 * ...
	 * @author 
	 */
	public class MyStore extends Store 
	{
		
		public var assign:MyItem;
		
		public function add(key:* = null, data:Object = null):MyItem { return addItem(key, data) as MyItem; }
		public function get(key:*):MyItem { return getItem(key) as MyItem; }
		public function remove(key:*):MyItem { return removeItem(key) as MyItem; }
		
	}

}