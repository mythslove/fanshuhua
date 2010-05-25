package com.fan.game.mediaplayer.view.panel
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.Timer;
	import flash.utils.setInterval;
	
	/**
	 * 字幕显示类 
	 * @author fanfan
	 * 
	 */
	public class LRCPanel extends TextField
	{
		//加载进来的文件转换后的二维数组
		private var dataArr:Array;
		//记时器
		private var timer:Timer;
		//开始的播放时间，比如拖动后开始的播放时间不是0
		private var startTime:Number = 0;
		//上一次播放的位置标记
		private var lastFlag:Number = 0;
		//字幕内容
		private var rawString:String;
		
		private var _lrcName:String;
		private const baseURL:String = "../data/res/music/";

		public function set lrcName(value:String):void
		{
			_lrcName = value;
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE,loadedLrcHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR,loadedFailureHandler);
			loader.load(new URLRequest(baseURL+value));
		}
		private function loadedFailureHandler(evt:IOErrorEvent):void{
			URLLoader(evt.target).removeEventListener(Event.COMPLETE,loadedLrcHandler);
			URLLoader(evt.target).removeEventListener(IOErrorEvent.IO_ERROR,loadedFailureHandler);
			rawString = "无法找不到歌词";
		}
		private function loadedLrcHandler(evt:Event):void{
			URLLoader(evt.target).removeEventListener(Event.COMPLETE,loadedLrcHandler);
			URLLoader(evt.target).removeEventListener(IOErrorEvent.IO_ERROR,loadedFailureHandler);
			rawString = evt.target.data;
			trace(rawString);
		}

		
		/**
		 * 字幕内容 
		 * @param str
		 * 
		 */			
		public function LRCPanel()
		{
			this.border = true;
			this.autoSize = TextFieldAutoSize.LEFT;
			this.addEventListener(Event.REMOVED_FROM_STAGE,dispose);
		}
		
		/**
		 * 更新时间 
		 * @param strTime 格式00:00:00:00
		 * 
		 */		
		public function updateTime(strTime:String = "00:00:00:00"):void{
			startTime = convertTime(strTime);
			lastFlag = 0;
			if(timer){
				if(!timer.hasEventListener(TimerEvent.TIMER)){
					timer.addEventListener(TimerEvent.TIMER,updateTxt);
				}
				timer.reset();
				timer.start();
			}
			
		}
		
		/**
		 * 加载资源文件 
		 * 
		 */		
		private function init():void{
			var tempArr:Array = rawString.split("\n");
			dataArr = new Array();
			for(var i :int = 0;i<tempArr.length;i++){
				dataArr[i] = new Array();
				dataArr[i][0] = convertTime(tempArr[i].substr(0,11));
				dataArr[i][1] = convertTime(tempArr[i].substr(12,11));
				dataArr[i][2] = tempArr[i].substring(24,tempArr[i].length);
			}
		}
		/**
		 *开始显示 
		 * 
		 */		
		private function start():void{
			timer = new Timer(500);
			timer.addEventListener(TimerEvent.TIMER,updateTxt);
			timer.start();
		}
	
		/**
		 * 更新字幕
		 * @param evt
		 * 
		 */		
		private function updateTxt(evt:TimerEvent):void{
			var currentTime:Number = startTime + Timer(evt.target).currentCount*Timer(evt.target).delay;
			if(currentTime > dataArr[dataArr.length - 1][1]){
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER,updateTxt);
			}
			for(var i:int = lastFlag;i<dataArr.length;i++){
				if(currentTime<=dataArr[i][1] && currentTime>= dataArr[i][0]){
					this.text = dataArr[i][2];
					lastFlag= i;
					return;
				}
			}
		}
		
		/**
		 * 得到Number类型的时间 
		 * @param strTime
		 * @return 
		 * 
		 */		
		private function convertTime(strTime:String):Number{
			var numberTime:Number = 0;
			var arr:Array = strTime.split(":");
			numberTime = int(arr[0])*60*60*1000 + int(arr[1])*60*1000 + int(arr[2])*1000 + int(arr[3]);
			return numberTime;
		}
		
		/**
		 * 销毁 
		 * @param evt
		 * 
		 */		
		private function dispose(evt:Event):void{
			this.removeEventListener(Event.REMOVED_FROM_STAGE,dispose);
			timer.removeEventListener(TimerEvent.TIMER,updateTxt);
			dataArr = null;
			timer = null;
			rawString = null;
			startTime = NaN;
			lastFlag = NaN;
		}
		
	}
}