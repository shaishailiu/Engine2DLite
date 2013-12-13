package engine.mc
{
	import engine.core.Scene_data;
	import engine.display3D.Display3DContainer;

	public class MovieClipManager
	{
		private static var _instance:MovieClipManager;
		
		private var _container:Display3DContainer;
		
		private var _dic:Object;
		
		public function MovieClipManager()
		{
			_dic = new Object;
		}
		
		public static function getInstance():MovieClipManager{
			if(!_instance){
				_instance = new MovieClipManager;
			}
			return _instance;
		}
		
		public function init($container:Display3DContainer):void{
			_container = $container;
		}
		
		public function getMc(url:String,baseWitdh:Number,baseHeight:Number,allFrameNum:int):MovieClip3D{
			if(!_dic[url]){
				_dic[url] = new Vector.<Display3DMovieClip>;
			}
			var movie:MovieClip3D;
			var vec:Vector.<Display3DMovieClip> = _dic[url];
			for(var i:int;i<vec.length;i++){
				movie = vec[i].getIdleMovie();
				if(movie){
					return movie;
				}
			}
			
			var mc:Display3DMovieClip = new Display3DMovieClip(Scene_data.context3D);
			mc.setBaseWidthHeight(baseWitdh,baseHeight,allFrameNum);
			mc.loadTexture(url);
			
			
			vec.push(mc);
			movie = mc.getIdleMovie();
			
			return movie;
		}
		
		public function addShowDisplay(display:Display3DMovieClip):void{
			_container.addChild(display);
		}
		
	}
}