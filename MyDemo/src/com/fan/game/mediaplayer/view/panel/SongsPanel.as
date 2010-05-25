package com.fan.game.mediaplayer.view.panel
{
	import com.fan.game.mediaplayer.events.MusicEvent;
	import com.fan.game.mediaplayer.module.CurrentSong;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.SoundTransform;
	
	public class SongsPanel extends Sprite
	{
		private var _itemArr:Array;
		
		private var _currentItem:ItemPanel;

		public function set currentItem(value:ItemPanel):void
		{
			if(_currentItem){
				_currentItem.alpha = 1;
			}
			if(value){
				_currentItem = value;
				_currentItem.alpha = 0.5;
				this.root.dispatchEvent(new MusicEvent(MusicEvent.CHANGE_SONG,[_currentItem.name]));
			}else{
				this.root.dispatchEvent(new MusicEvent(MusicEvent.CHANGE_SONG,[null]));
				this.root.dispatchEvent(new MusicEvent(MusicEvent.CHANGE_PLAY_BTN_STATUS,new Array(false)));
			}
		}
		
		public function get itemArr():Array
		{
			return _itemArr;
		}

		public function set itemArr(value:Array):void
		{
			_itemArr = value;
		}
		
		public function SongsPanel()
		{
			super();
			init();
			this.addEventListener(Event.ADDED_TO_STAGE,addedToStageHandler);
			this.addEventListener(Event.REMOVED_FROM_STAGE,removedFromStageHandler);
		}
		/**
		 * 播放下一首
		 * 
		 */		
		public function playNextItem(evt:MusicEvent):void{
			var itemLength:int = _itemArr.length;
			for(var i:int = 0;i<itemLength;i++){
				if(_itemArr[i] == _currentItem){
					if(i<itemLength-1){
						currentItem = _itemArr[i+1];
					}else{
						currentItem = _itemArr[0];
					}
					return;
				}
			}
			currentItem = _itemArr[0];
		}
		
		private function addedToStageHandler(evt:Event):void{
			this.removeEventListener(Event.ADDED_TO_STAGE,addedToStageHandler);
			initItem();
			confingerListeners();
		}
		private function confingerListeners():void{
			this.root.addEventListener(MusicEvent.PLAY_NEXT,playNextItem);
			this.root.addEventListener(MusicEvent.DEL_ITEM,changePanelHandler);
			this.root.addEventListener(MusicEvent.ADD_ITEM,changePanelHandler);
			this.root.addEventListener(MusicEvent.DEL_LAST_ITEM,changePanelHandler);
			this.root.addEventListener(MusicEvent.CLEAR_ITEM,changePanelHandler);
			this.root.addEventListener(MusicEvent.RESET_ITEM,changePanelHandler);
			this.root.addEventListener(MusicEvent.PLAY_ME,changePanelHandler);
		}	
		
		private function changePanelHandler(evt:MusicEvent):void{
			switch(evt.type){
				case MusicEvent.DEL_ITEM:
					delItem(evt.target as ItemPanel);
					break;
				case MusicEvent.ADD_ITEM:
					addItem();
					break;
				case MusicEvent.DEL_LAST_ITEM:
					delLastItem();
					break;
				case MusicEvent.CLEAR_ITEM:
					clearItem();
					break;
				case MusicEvent.RESET_ITEM:
					resetItem();
					break;
				case MusicEvent.PLAY_ME:
					currentItem = evt.target as ItemPanel;
					break;
					
			}
			this.root.dispatchEvent(new MusicEvent(MusicEvent.CHANGE_SONG_NUM,[_itemArr.length]));
		}
		private function removedFromStageHandler(evt:Event):void{
			this.removeEventListener(Event.REMOVED_FROM_STAGE,removedFromStageHandler);
			dispose();
		}
		private function dispose():void{
			
		}
		private function draw():void{
			this.graphics.beginFill(0xff0000,0.1);
			this.graphics.drawRect(0,0,280,240);
			this.graphics.endFill();
		}
		private function init():void{
			draw();
			_itemArr = new Array();
		}
		private function initItem():void{
			for(var i:int = 0;i<16;i++){
				addItem();
			}
			this.root.dispatchEvent(new MusicEvent(MusicEvent.CHANGE_SONG_NUM,[_itemArr.length]));
		}
		
		/**
		 * 随机增加一首歌曲 
		 * @return 当前面版中歌曲的数量
		 * 
		 */		
		private function addItem():int{
			var itemNum:uint = MediaPlayer(this.root).songListXML.song.length();
			var random:uint = Math.random()*itemNum;
			var randomItemName:String = MediaPlayer(this.root).songListXML.song[random].name;
			var item:ItemPanel = new ItemPanel(randomItemName);
			item.y = _itemArr.length*item.height;
			this.addChild(item);
			_itemArr.push(item);
			if(_itemArr.length == 1){
				currentItem = _itemArr[0];
			}
			return _itemArr.length;
		}
		/**
		 * 删除最后一首歌曲 
		 * @return 当前面版中歌曲的数量
		 * 
		 */		
		private function delLastItem():int{
			if(this._itemArr.length>1){
				this.removeChild(_itemArr[_itemArr.length-1]);
				if(_currentItem == _itemArr.pop()){
					currentItem = null;
				}
			}
			return _itemArr.length
		}
		
		private function delItem(itemPanel:ItemPanel):int{
			this.removeChild(itemPanel);
			var delFlag:uint;
			for(var i:int = 0;i<_itemArr.length;i++){
				if(_itemArr[i] == itemPanel){
					if(_currentItem == _itemArr.splice(i,1)[0]){
						currentItem = null;
					}
					delFlag = i;
					break;
				}
			}
			//被删除以下的条目上移
			for(var j:int = delFlag;j<_itemArr.length;j++){
				_itemArr[j].y = j*itemPanel.height;
			}
			return _itemArr.length
		}
		private function clearItem():void{
			while(this.numChildren>0){
				this.removeChildAt(0);
				_itemArr.length = 0;
			}
			currentItem = null;
		}
		
		private function resetItem():void{
			clearItem();
			initItem();
		}
		
	}
}