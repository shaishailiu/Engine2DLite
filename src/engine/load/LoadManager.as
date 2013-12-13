package engine.load
{
	import flash.events.Event;
	import flash.net.URLLoaderDataFormat;

	/**
	 * @author liuyanfei  QQ: 421537900
	 */
	public class LoadManager
	{
		
		//静态函数
//===========================================================
		/**版本控制函数  格式：function version(url:String):String*/
		private static var _getVersion:Function;
		
		/**
		 * 初始化pan3D要使用的解密和版本获取函数 
		 */		
		public static function initGlobalConfig( $version:Function ):void
		{
			_getVersion = $version;
		}
		
		
		private static var _instance:LoadManager;
		private var _listLoader:ListLoader;
		private var _stackLoader:StackLoader;
		
		public function LoadManager()
		{
			if(_instance!=null) throw new Error("Error: Singletons can only be instantiated via getInstance() method!");  
			LoadManager._instance = this;  
			init();
		}
		public static function getInstance():LoadManager{
			if(!_instance)
				_instance = new LoadManager();
			return _instance;
		}
		
		private function init():void{
			_listLoader = new ListLoader;
			_stackLoader = new StackLoader;
		}
		
		public function addSingleLoad(loaderInfo:LoadInfo):void{
			_stackLoader.addLoad(loaderInfo);
			return;
//			if(Scene_data.isDevelop){
//				_stackLoader.addLoad(loaderInfo);
//			}else{
//				load(loaderInfo);
//			}
		}
		
		public function addListLoad(list:Vector.<LoadInfo>,fun:Function):void{
			_listLoader.load(list);
			_listLoader.addEventListener(Event.COMPLETE,fun);
		}
		
		
		
		private function getType(str:String):String{
			if(str != LoadInfo.XML){
				 return URLLoaderDataFormat.BINARY;
			}else{
				 return URLLoaderDataFormat.TEXT;
			}
		}
		
	}
}