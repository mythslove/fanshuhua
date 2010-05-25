package com.fan.game.mediaplayer.module
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	public class CurrentSong
	{
		private var _song:SoundModule;

		public function get song():SoundModule
		{
			return _song;
		}

		private var _soundChannel:SoundChannel;

		public function get soundChannel():SoundChannel
		{
			return _soundChannel;
		}

		private var _soundTransform:SoundTransform;
		private var _sName:String;
		private var _stopPosition:Number = 0;
		
		
		public function CurrentSong(fileName:String,soundTransform:SoundTransform = null,autoPlay:Boolean = true)
		{
			this._sName = fileName;
			if(soundTransform){
				_soundTransform = soundTransform;
			}else{
				_soundTransform = new SoundTransform(1);
			}
			
			_song = new SoundModule(fileName);
			if(autoPlay){
				play(true);
			}
			
		}
		
		
		public function get sName():String
		{
			return _sName;
		}

		public function set volume(soundTransform:SoundTransform):void{
			_soundChannel.soundTransform = soundTransform;
		}
		
		
		public function changeSong(fileName:String):void{
			this._sName = fileName;
			_song = new SoundModule(fileName);
			play(true,0);
		}
		/**
		 * 开始播放 
		 * @param formHead 是否从头开始播放
		 * 
		 */		
		public function play(formHead:Boolean,pos:Number = 0):void{
			if(_soundChannel) {
				_soundChannel.stop();
			}
			if(pos != 0){
				pos = _song.length*pos;
				_stopPosition = pos;
			}
			if(formHead == true){
				_soundChannel = _song.play(0,0,null);
			}else{
				_soundChannel = _song.play(_stopPosition,0,null);
			}
			_soundChannel.soundTransform = _soundTransform;
		}
		
		public function playPosition(position:Number):void{
			if(_soundChannel) {
				_soundChannel.stop();
			}
			
			_soundChannel = _song.play(position,0,null);
			_soundChannel.soundTransform = _soundTransform;
		}
		
		public function pause():void{
			_stopPosition = _soundChannel.position;
			_soundChannel.stop();
		}
		
		public function stop():void{
			if(_soundChannel){
				_soundChannel.stop();
			}
		}
		
		
	}
}