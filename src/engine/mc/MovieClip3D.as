package engine.mc
{
	public class MovieClip3D
	{
		private var _x:int;
		private var _y:int;
		public var width:Number;
		public var height:Number;
		
		public var useX:int = -2000;
		public var useY:int = -2000;
		
		public var frame:int;
		
		private var _time:uint;
		
		private var _frameTime:uint = 33;
		
		public var allFrame:int;
		
		public var isUse:Boolean;
		
		public var isShow:Boolean;
		
		public var displayTarget:Display3DMovieClip;
		
		public function MovieClip3D()
		{
			
		}
		
		public function updateFrame(time:int):void{
			_time += time;
			
			frame = int(_time/_frameTime);
			
			if(frame >= allFrame){
				frame = 0;
				_time = 0;
			}
			
		}
		
		public function add():void{
			if(!displayTarget.parent){
				MovieClipManager.getInstance().addShowDisplay(displayTarget);
			}
			useX = x;
			useY = y;
			isShow = true;
		}
		
		public function remove():void{
			useX = -2000;
			useY = -2000;
			isShow = false;
			displayTarget.clear();
		}
		
		public function dispose():void{
			this.isUse = false;
			useX = -2000;
			useY = -2000;
			//displayTarget.clear();
		}
		
		public function set x(value:int):void{
			_x = value;
			if(isShow){
				useX = value;
			}
		}
		
		public function get x():int{
			return _x;
		}
		
		public function set y(value:int):void{
			_y = value;
			if(isShow){
				useY = value;
			}
		}
		
		public function get y():int{
			return _y;
		}
		
	}
}