package engine.core
{
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.display.Stage3D;
	import flash.display3D.*;
	import flash.display3D.textures.Texture;
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	


	// --------------MSN:lation_pan@live.cn  QQ: 3423526------------- //
	public class Scene_data
	{
		public static var listTxt:String="Pan3d.me";
		public static var drawNum:uint=0;
		public static var drawTriangle:uint=0;
		public static var fileRoot:String="";
		public static var md5Root:String="";
		/**
		 * 粒子文件的根目录(这个在游戏启动时, 会由2D层传递过来) 
		 */		
		public static var particleRoot:String = "";
		/**
		 * buff文件的根目录 (这个在游戏启动时, 会由2D层传递过来) 
		 */		
		public static var buffRoot:String="";
		
		public static var framenum:Number=60;//游戏帧率
		public static var root:MovieClip;
		public static var stage:Stage;
		public static var stage3D:Stage3D;
		public static var context3D:Context3D;
		public static var program3D:Program3D;
		public static var texShadowMap:Texture;
		public static var sunMatrix:Matrix3D=new Matrix3D();
		public static var antiAlias:int = 2;//抗锯齿等级
		public static var effectsLev:int = 0;//游戏特效等级
		

		public static var shake3D:Vector3D = new Vector3D;
		public static var focus2D:Vector3D = new Vector3D;
		public static var lightCathPos:Vector3D=new Vector3D;
		public static var shaderDictionary:Array=new Array();

		public static var ready:Boolean=false;
		
		public static var groundBitmapData:BitmapData=new BitmapData(1024, 1024, false);
		public static var grounHightMapSize:int=1024; //存地形高度图的宽度，关联生成的
		public static var grounHightMapScale:Number=10 //比例尺//就是单位像素所代表胡真实宽度;

		public static var radd:Number=0;
		public static var gadd:Number=0;
		public static var badd:Number=0;

		public static var buildChooseTexture:Texture;
		public static var sceneLightText:Texture;
		public static var groundLightText:Texture;
		public static var shenduText:Texture;
		public static var bowenText:Texture;
		public static var bowenNrmText:Texture;

		public static var totalNum:int=0;
		public static var canScanShader:int=30;
		public static var stageWidth:int=1024;
		public static var stageHeight:int=600;
		public static var groundHightBitMapData:BitmapData//用512*512;
		public static var frameTime:Number = 1000/60;

		
		public static var sw2D:Number=1
		public static var tx2D:Number=1
		public static var ty2D:Number=1
		public static var sinAngle2D:Number=1;
		public static var mainScale:Number = 2.55;
		public static var sceneViewHW:uint=1000; //这个作为屏幕约束比例 。对于镜头存像，以及鼠拾取都有关联
		
		public static var isDevelop:Boolean = false;
		
		public static var uiCamAngle:int = 0;
		/**
		 * 缓存时间 
		 */		
		public static var cacheTime:int = 500;
		
		/**
		 * 是否使用二进制文件
		 */		
		public static var fileByteMode:Boolean = false;
		/**
		 * openGL显卡 
		 */		
		public static var isOpenGL:Boolean = false;
		
		public static function loadModeOk(str:String):void
		{
			totalNum++
		}
	}
}
