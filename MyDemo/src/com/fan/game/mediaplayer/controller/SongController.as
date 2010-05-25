package com.fan.game.mediaplayer.controller
{
	import com.fan.game.common.util.StringUtil;
	import com.fan.game.mediaplayer.events.MusicEvent;
	import com.fan.game.mediaplayer.module.CurrentSong;
	import com.fan.game.mediaplayer.view.panel.ItemPanel;
	import com.fan.game.mediaplayer.view.panel.SongsPanel;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.SoundTransform;

	/**
	 * 歌曲控制器 
	 * @author fanfan
	 * 
	 */	
	public class SongController extends Sprite
	{
		
		private var _songsPanel:SongsPanel;
		private var _currentSong:CurrentSong;
		private var _soundTransform:SoundTransform;
		/**
		 * 歌曲列表面板 
		 * @return 
		 * 
		 */		
		public function get songsPanel():SongsPanel
		{
			return _songsPanel;
		}

		public function set songsPanel(value:SongsPanel):void
		{
			_songsPanel = value;
		}
		
		/**
		 * 构造方法 
		 * @return 
		 * 
		 */		
		public function SongController()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE,addedToStageHandler);
			this.addEventListener(Event.REMOVED,removedHandler);
		}
		
		private function addedToStageHandler(evt:Event):void{
			this.removeEventListener(Event.ADDED_TO_STAGE,addedToStageHandler);
			confingerListeners();
			this.songsPanel = MediaPlayer(this.root).mainPanel.songsPanel;
			
			init();
		}
		
		private function init():void{
			this.root.addEventListener(Event.ENTER_FRAME,enterFrameHandler);
			var songName:String = _songsPanel.itemArr[0].name;
			_currentSong = new CurrentSong(songName);
			var lrcName:String = songName.substr(0,songName.lastIndexOf("."))+".lrc";
			MediaPlayer(this.root).mainPanel.lrcPanel.lrcName = lrcName;
			_soundTransform = new SoundTransform();
		}
		
		private function removedHandler(evt:Event):void{
			dispose();
		}
		
		private function confingerListeners():void{
			this.root.addEventListener(MusicEvent.PLAY_PAUSE,playPauseHandler);
			this.root.addEventListener(MusicEvent.CHANGE_SONG,changeSongHandler);
			this.root.addEventListener(MusicEvent.CHANGE_Value,changeSongValue);
			this.root.addEventListener(MusicEvent.CHANGE_SONG_PROGRESS,changeSongProgress);
			
		}
		private function changeSongProgress(evt:MusicEvent):void{
			if(_currentSong){
				_currentSong.play(false,evt.dataArr[0]);
			}
			
			this.root.dispatchEvent(new MusicEvent(MusicEvent.CHANGE_PLAY_BTN_STATUS,new Array(true)));
		}
		
		private function changeSongValue(evt:MusicEvent):void{
			_soundTransform.volume = evt.dataArr[0] as Number;
			if(_currentSong){
				_currentSong.volume = _soundTransform
			}
		}
		
		private function dispose():void{
			this.removeEventListener(Event.REMOVED_FROM_STAGE,removedHandler);
			this.root.removeEventListener(MusicEvent.PLAY_PAUSE,playPauseHandler);
			this.root.removeEventListener(MusicEvent.CHANGE_SONG,changeSongHandler);
			this.root.removeEventListener(MusicEvent.CHANGE_Value,changeSongValue);
			this.root.removeEventListener(Event.ENTER_FRAME,enterFrameHandler);
		}
		
		private function playPauseHandler(evt:MusicEvent):void{
			if(!_currentSong){
				return;
			}
			if(evt.dataArr[0] == true){
				_currentSong.play(false);
				this.root.addEventListener(Event.ENTER_FRAME,enterFrameHandler);
			}else{
				_currentSong.pause();
				this.root.removeEventListener(Event.ENTER_FRAME,enterFrameHandler);
			}
		}
		
		private function enterFrameHandler(evt:Event):void{
			if(_currentSong){
				this.root.dispatchEvent(new MusicEvent(MusicEvent.CURRENT_TIME,[this._currentSong.soundChannel.position]));
			}
		}
		
		private function changeSongHandler(evt:MusicEvent):void{
			if(_currentSong){
				_currentSong.stop();
				_currentSong = null;
			}
			
			if(evt.dataArr[0]){
				_currentSong = new CurrentSong(evt.dataArr[0],_soundTransform);
				this.root.dispatchEvent(new MusicEvent(MusicEvent.CHANGE_PLAY_BTN_STATUS,new Array(true)));
			}
			
		}
		
	}
}