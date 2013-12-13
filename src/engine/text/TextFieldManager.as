package engine.text
{
	import engine.core.Scene_data;
	import engine.display3D.Display3DContainer;
	import engine.display3D.Display3DQuad;
	import engine.programs.Program3DManager;
	
	import flash.display3D.textures.Texture;

	/**
	 * 
	 * @author liuyanfei QQ:421537900
	 * 
	 */	
	public class TextFieldManager
	{
		private static var _instance:TextFieldManager;
		/**
		 * vc对应ID的状态 是否处于使用中 
		 */		
		/**
		 * 动态显示对象的存储的数组 
		 */		
		private var display3dynamicAry:Vector.<Display3DynamicText>;
		/**
		 * 显示对象的容器 
		 */		
		private var _contaniner:Display3DContainer;
		/**
		 * 静态图片的材质 
		 */		
		private var _texture:Texture;
		
		private var _currentText:Text3Dynamic;

		public function TextFieldManager()
		{
			initDisplay();
			initTexture();
		}
		public static function getInstance():TextFieldManager{
			if(!_instance){
				_instance = new TextFieldManager;
			}
			return _instance;
		}
		/**
		 * 初始化数组 
		 * 
		 */		
		private function initDisplay():void{
			display3dynamicAry = new Vector.<Display3DynamicText>;
			
			Program3DManager.getInstance().registe(Display3DynamicTextShader.DISPLAY3DYNAMICTEXTSHADER,Display3DynamicTextShader);
		}
		
		public function addDisplayDynamic():Display3DynamicText{
			var display3dText:Display3DynamicText = new Display3DynamicText(Scene_data.context3D);
			display3dynamicAry.push(display3dText);
			display3dText.program = (Program3DManager.getInstance().getProgram(Display3DynamicTextShader.DISPLAY3DYNAMICTEXTSHADER));
			_contaniner.addChild(display3dText);
			return display3dText; 
		}
		
		/**
		 * 文字系统初始化 
		 * @param container 显示系统的容器
		 * 
		 */		
		public function init(container:Display3DContainer):void{
			_contaniner = container;
		}
		
		/**
		 * 获取一个图片文本 
		 * @param $width 宽
		 * @param $height 高
		 * @return 
		 * 
		 */		
		public function getText3Dynamic($width:int,$height:int,$zbuff:Number=0.0):Text3Dynamic{
			var $text:Text3Dynamic = new Text3Dynamic(this,$width,$height,$zbuff);
			return $text;
		}
		
		
		/**
		 * 初始化加载材质 
		 * 
		 */		
		private function initTexture():void{
			//TextureManager.getInstance().addTexture("assets/0_9.png",onTexture,null);
		}
		
		/**
		 * 设置材质 
		 * @param $texture
		 * @param info
		 * 
		 */	
		private function onTexture($texture:Texture,info:Object):void{
			_texture = $texture;
		}
		
		
		/**
		 * 从文字系统请求空闲的动态资源使用 
		 * @param txt 发起请求的动态文本对象
		 * 
		 */		
		public function requestDisplay(txt:Text3Dynamic):void{
			for(var i:int;i<display3dynamicAry.length;i++){
				var tf:Boolean = display3dynamicAry[i].requestDisplay(txt);
				if(tf){
					return;
				}
			}
			var display3dText:Display3DynamicText = addDisplayDynamic();
			display3dText.initData(txt.width,txt.height,txt.zbuff);
			display3dText.requestDisplay(txt);
			sort();
		}
			
		public function addChild(display3dText:Display3DQuad):void{
			_contaniner.addChild(display3dText);
		}
		
		private function sort():void{
			_contaniner.sort("zbuff",true);
		}
		
		
		public function reload():void{
			for(var i:int;i<_contaniner.childrenList.length;i++){
				if(_contaniner.childrenList[i] is Display3DynamicText){
					Display3DynamicText(_contaniner.childrenList[i]).reload();
				}
			}
		}
		
		public function dispose():void{
			var l:int = display3dynamicAry.length - 1;
			for(var i:int = l;i>=0;i--){
				if(display3dynamicAry[i].idleNum == display3dynamicAry[i].allNum){
					display3dynamicAry[i].dispose();
					display3dynamicAry.splice(i,1);
				}
			}
		}
		
	}
}