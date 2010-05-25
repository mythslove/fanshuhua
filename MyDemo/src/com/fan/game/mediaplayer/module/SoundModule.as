package com.fan.game.mediaplayer.module
{
	import com.fan.game.common.util.EventManger;
	import com.fan.game.mediaplayer.events.MusicEvent;
	
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.media.Sound;
	import flash.media.SoundLoaderContext;
	import flash.net.URLRequest;
	
	public class SoundModule extends Sound
	{
		private const baseURL:String = "../data/res/music/";
		
		public function SoundModule(fileName:String,context:SoundLoaderContext = null)
		{
			super();
			this.load(new URLRequest(baseURL+fileName));
			
			this.addEventListener(Event.COMPLETE, completeHandler);
			this.addEventListener(ProgressEvent.PROGRESS, progressHandler);
		}
		
		private function completeHandler(event:Event):void {
			this.removeEventListener(Event.COMPLETE, completeHandler);
			this.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
		}
		
		private function progressHandler(event:ProgressEvent):void {
			EventManger.getInstance().dispatchEvent(new MusicEvent(MusicEvent.TOTAL_TIME,[this.length]));
//			trace(TimeConvert.millisecondToHMS(this.length));
		}
	}
}