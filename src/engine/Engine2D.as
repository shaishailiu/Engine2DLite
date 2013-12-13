package engine 
{
	import flash.display.Stage;
	import flash.display.StageAlign;2
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.display3D.Context3D;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import engine.core.Scene_data;
	import engine.core.Config;
	import engine.programs.Program3DManager;
	import engine.textures.TextureManager;
	

	/**
	 * 主引擎类 
	 * @author liuyanfei QQ:421537900
	 * 
	 */	
	public class Engine2D
	{
		private static var context3D:Context3D;
		private static var stage:Stage;
		private static var onComplete:Function
		public function Engine2D()
		{
		}
		/**
		 * 初始化引擎 
		 * @param $stage
		 * 
		 */		
		public static function initEngine($stage:Stage,$onComplete:Function):void{
			stage = $stage;
			Scene_data.stage = $stage;
			onComplete = $onComplete;
			
			configStage();
			
			Config.init(Scene_data.stage, on3DConfigComplete, reloadScene, on3DError);
		}
		/**
		 * 配置舞台属性 
		 * 
		 */		
		private static function configStage():void{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.quality = StageQuality.LOW;
			stage.frameRate = Scene_data.framenum;
		}
		
		private static function on3DConfigComplete():void
		{
			context3D = Scene_data.context3D;
			
			TextureManager.getInstance().init(context3D);
			
			//调一下尺寸
			reSize(stage.stageWidth, stage.stageHeight);
			
			//stage.addEventListener(Event.ENTER_FRAME,update);
			stage.addEventListener(Event.RESIZE,onResize);
			
			onComplete();
			
		}
		
		/**
		 * 重新装载场景 
		 * 
		 */		
		private static function reloadScene():void{
			context3D = Scene_data.context3D;
			Program3DManager.getInstance().reload();
			
			//调一下尺寸
			reSize(stage.width, stage.height);
		}
		
		/**
		 * 不能正确初始化的回调 
		 * @param $errorType 错误类型, 1表示未开启硬件加速,  2驱动不支持,  3表示其他错误 
		 */		
		protected static function on3DError($errorType:int):void
		{
			
		}
		
		/**
		 * 重置大小
		 * @param $width
		 * @param $height
		 */
		private static function reSize($width:Number, $height:Number):void
		{
			//for 3D
			Scene_data.stageWidth = $width - Scene_data.stage3D.x;
			Scene_data.stageHeight = $height - Scene_data.stage3D.y;
				
			try
			{
				Scene_data.context3D.configureBackBuffer(Scene_data.stageWidth, Scene_data.stageHeight,Scene_data.antiAlias, true);
			} 
			catch(error:Error) 
			{
				
			}
				
		}
		private static function onResize(event:Event):void{
			reSize(stage.stageWidth, stage.stageHeight);
		}
		/**
		 * 主渲染驱动 
		 * 
		 */		
		public static function update(event:Event):void{
			
		}
			
		
	}
}