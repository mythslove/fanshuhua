package com.fan.game.mediaplayer.events
{
	import com.fan.game.common.event.BaseEvent;
	
	public class MusicEvent extends BaseEvent
	{
		public function MusicEvent(type:String, dataArray:Array=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, dataArray, bubbles, cancelable);
		}
		
		//按名字删除
		public static var DEL_ITEM:String = "delItem";
		//增加一个
		public static var ADD_ITEM:String = "addItem";
		//删除最后一个
		public static var DEL_LAST_ITEM:String = "delLastItem";
		//清空列表
		public static var CLEAR_ITEM:String = "clearItem";
		//重置列表
		public static var RESET_ITEM:String = "resetItem";
		//播放暂停
		public static var PLAY_PAUSE:String = "playPause";
		//改变歌曲数量
		public static var CHANGE_SONG_NUM:String = "changeSongNum";
		//改变播放按钮状态
		public static var CHANGE_PLAY_BTN_STATUS:String = "changePlayBtnStatus";
		//-----------------------------------------------------------------------------------
		//改变面版
		public static var PLAY_NEXT:String = "playNext";
		
		//改变歌曲
		public static var CHANGE_SONG:String = "changeSong";
		//改变音量
		public static var CHANGE_Value:String = "changeValue";
		//歌曲总时间
		public static var TOTAL_TIME:String = "totalTime";
		//歌曲当前时间
		public static var CURRENT_TIME:String = "currentTime";
		//歌曲加载完成
		public static var LOADED_SONG:String = "loadedSong";
		//改变歌曲进度
		public static var CHANGE_SONG_PROGRESS:String = "changeSongProgress";
		//播放所选歌曲
		public static var PLAY_ME:String = "playMe";
		
		
		
		
		
	}
}