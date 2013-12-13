package engine.textures
{
	import engine.core.TextureVo;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DTextureFormat;
	import flash.display3D.textures.Texture;
	import flash.geom.Matrix;
	import flash.utils.ByteArray;
	
	import engine.load.LoadInfo;
	import engine.load.LoadManager;
	
	/**
	 * @author liuyanfei  QQ: 421537900
	 */
	public class TextureManager
	{
		private var _textureDic:Object;
		private var _loadFunDic:Object;
		private var _context:Context3D;
		
		private static var instance:TextureManager;
		
		public function TextureManager()
		{
			_textureDic = new Object;
			_loadFunDic = new Object;
			
			//TickTime.addCallback(dispose);
		}
		public static function getInstance():TextureManager{
			if(!instance){
				instance = new TextureManager;
			}
			return instance;
		}
		/**
		 * 图片转显卡资源 
		 * @param bmp
		 * @return 
		 */		
		public function bitmapToTexture(bmp:BitmapData, autoDispose:Boolean = false):Texture
		{
			try{
				var texture:Texture=_context.createTexture(bmp.width,bmp.height, Context3DTextureFormat.BGRA,false);
				uploadBimapdataMipmap(texture,bmp);
			} 
			catch(error:Error) {}
			if(autoDispose)
			{
				bmp.dispose();
			}
			return texture;
		}
		
		
//		public  function makeLoopBmp(newBmp:BitmapData,baseBmp:BitmapData):void
//		{
//			var tempM:Matrix=new Matrix
//			for(var i:int=0;i<int(newBmp.width/baseBmp.width);i++)
//			{
//				for(var j:int=0;j<int(newBmp.height/baseBmp.height);j++)
//				{
//					tempM.tx=i*baseBmp.width
//					tempM.ty=j*baseBmp.height
//					newBmp.draw(baseBmp,tempM);
//				}
//			}
//		}
		
		public function init(context:Context3D):void{
			this._context = context;
		}
		public function addTexture(url:String,fun:Function,info:Object,$priority:int=0):void{
			if(_textureDic.hasOwnProperty(url)){
				fun(_textureDic[url],info);
			}else{
				if(!_loadFunDic.hasOwnProperty(url)){
					_loadFunDic[url] = new Array;
					var loaderinfo:LoadInfo = new LoadInfo(url,LoadInfo.BITMAP,onTextureLoad,$priority,url);
					LoadManager.getInstance().addSingleLoad(loaderinfo);
				}
				_loadFunDic[url].push({"fun":fun,"info":info});
			}
		}
		private function onTextureLoad(bitmap:Bitmap,url:String):void{
			var bitmapdata:BitmapData = bitmap.bitmapData;
			var texture:Texture;
			
			try{
				texture = this._context.createTexture(bitmapdata.width, bitmapdata.height, Context3DTextureFormat.BGRA, true);
				uploadBimapdataMipmap(texture,bitmapdata);
			} 
			catch(error:Error) {}
			
			var textureVo:TextureVo = new TextureVo;
			_textureDic[url] = textureVo;
			
			textureVo.bitmapdata = bitmapdata;
			textureVo.texture = texture;
			textureVo.url = url;
			
			var ary:Array = _loadFunDic[url];
			for each(var obj:Object in ary){
				obj.fun(textureVo,obj.info)
			}
			delete _loadFunDic[url];
		}
		
		private function uploadBimapdataMipmap(texture:Texture,bitmapdata:BitmapData):void{
			texture.uploadFromBitmapData(bitmapdata);
			return;
			var ws:int = bitmapdata.width;
			var hs:int = bitmapdata.height;
			var level:int = 0; 
			var tmp:BitmapData;
			var transform:Matrix = new Matrix();
			tmp = new BitmapData(ws, hs, true, 0x00000000);
			while ( ws >= 1 && hs >= 1 ) {
				tmp.draw(bitmapdata, transform, null, null,
					null, true);
				texture.uploadFromBitmapData(tmp, level);
				transform.scale(0.5, 0.5);
				level++; 
				ws >>= 1;
				hs >>= 1;
				if(hs!=ws && (hs==0||ws==0)){
					if(hs == 0){
						hs = 1;
					}
					if(ws == 0){
						ws = 1;
					}
				}
				if (hs && ws) {
					tmp.dispose();
					tmp = new BitmapData(ws, hs, true, 0x00000000);
				}
			}
			tmp.dispose();
		}
		public function reload(context:Context3D):void{
			this._context = context;
			
			for each(var textureVo:TextureVo in _textureDic){
				textureVo.texture = this._context.createTexture(textureVo.bitmapdata.width, textureVo.bitmapdata.height, Context3DTextureFormat.BGRA, true);
				uploadBimapdataMipmap(textureVo.texture,textureVo.bitmapdata);
			}
			
		}
		
		public function reloadTexture(url:String):Texture{
			if(_textureDic.hasOwnProperty(url)){
				return _textureDic[url].texture;
			}
			trace("重载资源不存在"); 
			return null;
		}
		private var flag:int;
		public function dispose():void{
//			var num:int;
//			for each(var textureVo:TextureVo in _textureDic){
//				if(textureVo.useNum <= 0){
//					textureVo.idleTime++;
//					if(textureVo.idleTime >= Scene_data.cacheTime){
//						delete _textureDic[textureVo.url];
//						textureVo.dispose();
//					}
//				}else{
//					textureVo.idleTime = 0;
//					num++;
//				}
//			}
//			
//			flag++;
//			if(flag == Log.logTime){
//				flag = 0;
//				var allNum:int;
//				for each(textureVo in _textureDic){
//					if(textureVo.useNum > 0){
//						Log.add(textureVo.url + "*" + textureVo.useNum)
//					}
//						allNum++;
//				}
//				Log.add("******************************************分割线***********************************************使用数量" +　num +　" 总数：" + allNum + "空闲个数：" + (allNum-num));
//			}
//			TextureCount.getInstance().countTextureManager(_textureDic);
			//trace("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&内存线&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& " +　System.totalMemory);
		}
		
	}
}