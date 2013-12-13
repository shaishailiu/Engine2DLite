package engine.core
{
	import flash.display.BitmapData;
	import flash.display3D.textures.Texture;
	/**
	 * 贴图Vo类 
	 * @author liuyanfei QQ:421537900
	 * 
	 */	
	public class TextureVo
	{
		/**
		 * bitmapdata 内存资源 
		 */		
		public var bitmapdata:BitmapData;
		/**
		 *  texture 显卡资源
		 */		
		public var texture:Texture;
		/**
		 * 使用次数 
		 */		
		public var useNum:int;
		/**
		 * 路径 
		 */		
		public var url:String;
		/**
		 * 闲置时间 
		 */		
		public var idleTime:int;
		
		public function TextureVo()
		{
			
		}
		public function dispose():void{
			if(texture)
				texture.dispose();
			bitmapdata.dispose();
		}
	}
}