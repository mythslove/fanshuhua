package com.fan.game.mediaplayer.view.panel
{
	import com.fan.game.common.util.EventManger;
	import com.fan.game.common.util.TimeConvert;
	import com.fan.game.common.view.ScrollBar;
	import com.fan.game.common.view.button.BaseButton;
	import com.fan.game.mediaplayer.events.MusicEvent;
	import com.fan.game.mediaplayer.view.button.MinusButton;
	import com.fan.game.mediaplayer.view.button.NextOneButton;
	import com.fan.game.mediaplayer.view.button.PlayButton;
	import com.fan.game.mediaplayer.view.button.PlusButton;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.ui.Mouse;
	
	public class MainPanel extends Sprite
	{
		private var _playBtn:PlayButton;
		private var _nextSongBtn:NextOneButton;
		private var _soundCtrlPanel:SoundCtrlPanel;
		private var _resetBtn:BaseButton;
		private var _randomBtn:BaseButton;
		private var _clearBtn:BaseButton;
		private var _timeAreaPanel:TimeAreaPanel;
		private var _minusBtn:MinusButton;
		private var _plusBtn:PlusButton;
		private var _songsPanel:SongsPanel;
		private var _lrcPanel:LRCPanel
		private var _scrollBar:ScrollBar;

		public function get lrcPanel():LRCPanel
		{
			return _lrcPanel;
		}

		public function set lrcPanel(value:LRCPanel):void
		{
			_lrcPanel = value;
		}

		
		private var _itemNum:TextField;
		
		public function MainPanel()
		{
			super();
			drawBg();
			initChild();
			this.addEventListener(Event.ADDED_TO_STAGE,addedToStageHandler);
			this.addEventListener(Event.REMOVED_FROM_STAGE,removedFromStageHandler);
			
		}
		
		private function addedToStageHandler(evt:Event):void{
			this.removeEventListener(Event.ADDED_TO_STAGE,addedToStageHandler);
			confingerListener();
		}
		
		private function removedFromStageHandler(evt:Event):void{
			this.removeEventListener(Event.REMOVED_FROM_STAGE,removedFromStageHandler);
			dispose();
		}
		
		private function confingerListener():void{
			playBtn.addEventListener(MouseEvent.CLICK,clickHandler);
			nextSongBtn.addEventListener(MouseEvent.CLICK,clickHandler);
			resetBtn.addEventListener(MouseEvent.CLICK,clickHandler);
			randomBtn.addEventListener(MouseEvent.CLICK,clickHandler);
			clearBtn.addEventListener(MouseEvent.CLICK,clickHandler);
			minusBtn.addEventListener(MouseEvent.CLICK,clickHandler);
			plusBtn.addEventListener(MouseEvent.CLICK,clickHandler);
			
			timeAreaPanel.addEventListener(MusicEvent.CHANGE_SONG_PROGRESS,changeSongProgressHandler);
			EventManger.getInstance().addEventListener(MusicEvent.TOTAL_TIME,setTotalTimeHandler);
			timeAreaPanel.root.addEventListener(MusicEvent.CURRENT_TIME,setCurrentTimeHandler);
			this.root.addEventListener(MusicEvent.CHANGE_PLAY_BTN_STATUS,function (evt:MusicEvent):void{
				playBtn.playStatus = evt.dataArr[0];
			});
			
			_itemNum.root.addEventListener(MusicEvent.CHANGE_SONG_NUM,function(evt:MusicEvent):void{
				_itemNum.text = evt.dataArr[0]
			});
		}
		
		private function changeSongProgressHandler(evt:MusicEvent):void{
			//再传递事件
			this.root.dispatchEvent(new MusicEvent(evt.type,evt.dataArr));
		}
		
		private function setTotalTimeHandler(evt:MusicEvent):void{
			timeAreaPanel.timeMsg2 = TimeConvert.millisecondToHMS(evt.dataArr[0]);
		}
		
		private function setCurrentTimeHandler(evt:MusicEvent):void{
			timeAreaPanel.timeMsg1 = TimeConvert.millisecondToHMS(evt.dataArr[0]);
		}
		
		private function clickHandler(evt:MouseEvent):void{
			switch(evt.currentTarget){
				case playBtn:
					this.root.dispatchEvent(new MusicEvent(MusicEvent.PLAY_PAUSE,[!PlayButton(evt.currentTarget).playStatus]));
					break;
				case nextSongBtn:
					this.root.dispatchEvent(new MusicEvent(MusicEvent.PLAY_NEXT));
					break;
				case resetBtn:
					this.root.dispatchEvent(new MusicEvent(MusicEvent.RESET_ITEM));
					break;
				case randomBtn:
					break;
				case clearBtn:
					this.root.dispatchEvent(new MusicEvent(MusicEvent.CLEAR_ITEM));
					break;
				case minusBtn:
					this.root.dispatchEvent(new MusicEvent(MusicEvent.DEL_LAST_ITEM));
					break;
				case plusBtn:
					this.root.dispatchEvent(new MusicEvent(MusicEvent.ADD_ITEM));
					break;
			}
		}
		
		private function dispose():void{
			
		}
		
		public function get songsPanel():SongsPanel
		{
			return _songsPanel;
		}

		public function set songsPanel(value:SongsPanel):void
		{
			_songsPanel = value;
		}

		public function get plusBtn():PlusButton
		{
			return _plusBtn;
		}

		public function set plusBtn(value:PlusButton):void
		{
			_plusBtn = value;
		}

		public function get minusBtn():MinusButton
		{
			return _minusBtn;
		}

		public function set minusBtn(value:MinusButton):void
		{
			_minusBtn = value;
		}

		public function get timeAreaPanel():TimeAreaPanel
		{
			return _timeAreaPanel;
		}

		public function set timeAreaPanel(value:TimeAreaPanel):void
		{
			_timeAreaPanel = value;
		}

		public function get clearBtn():BaseButton
		{
			return _clearBtn;
		}

		public function set clearBtn(value:BaseButton):void
		{
			_clearBtn = value;
		}

		public function get randomBtn():BaseButton
		{
			return _randomBtn;
		}

		public function set randomBtn(value:BaseButton):void
		{
			_randomBtn = value;
		}

		public function get resetBtn():BaseButton
		{
			return _resetBtn;
		}

		public function set resetBtn(value:BaseButton):void
		{
			_resetBtn = value;
		}

		public function get soundCtrlPanel():SoundCtrlPanel
		{
			return _soundCtrlPanel;
		}

		public function set soundCtrlPanel(value:SoundCtrlPanel):void
		{
			_soundCtrlPanel = value;
		}

		public function get nextSongBtn():NextOneButton
		{
			return _nextSongBtn;
		}

		public function set nextSongBtn(value:NextOneButton):void
		{
			_nextSongBtn = value;
		}

		public function get playBtn():PlayButton
		{
			return _playBtn;
		}

		public function set playBtn(value:PlayButton):void
		{
			_playBtn = value;
		}

		private function drawBg():void{
			
			var titlePanel:Sprite = new Sprite();
			titlePanel.graphics.beginFill(0x4f6e8d);
			titlePanel.graphics.drawRoundRectComplex(0,0,280,70,10,10,0,0);
			titlePanel.graphics.endFill();
			this.addChild(titlePanel);
			titlePanel.addEventListener(MouseEvent.MOUSE_DOWN,downHandler);
			function downHandler(evt:MouseEvent):void{
				titlePanel.addEventListener(MouseEvent.MOUSE_UP,upHandler);
				startDrag();
			}
			function upHandler(evt:MouseEvent):void{
				titlePanel.removeEventListener(MouseEvent.MOUSE_UP,upHandler);
				stopDrag();
			}
			
			var menuPanel:Shape = new Shape();
			menuPanel.graphics.beginFill(0x46617e);
			menuPanel.graphics.drawRect(0,0,titlePanel.width,30);
			menuPanel.graphics.endFill();
			menuPanel.y = titlePanel.y + titlePanel.height;
			this.addChild(menuPanel);
			
			var mainPanel:Shape = new Shape();
			mainPanel.graphics.beginFill(0xffffff);
			mainPanel.graphics.drawRect(0,0,titlePanel.width,240);
			mainPanel.graphics.endFill();
			mainPanel.y = menuPanel.y + menuPanel.height;
			this.addChild(mainPanel);
			
			var bottomPanel:Shape = new Shape();
			bottomPanel.graphics.beginFill(0x46617e);
			bottomPanel.graphics.drawRoundRectComplex(0,0,titlePanel.width,menuPanel.height,0,0,10,10);
			bottomPanel.graphics.endFill();
			bottomPanel.y = mainPanel.y + mainPanel.height;
			this.addChild(bottomPanel);
			
			var playMode:TextField = new TextField();
			playMode.text = "播放模式:";
			playMode.textColor = 0xffffff;
			playMode.width = playMode.textWidth + 3;
			playMode.height = playMode.textHeight +3;
			playMode.selectable = false;
			playMode.x = 60;
			playMode.y = 345;
			playMode.alpha = 0.6;
			this.addChild(playMode);
			
			var tf:TextFormat = new TextFormat();
			tf.color = 0xffffff;
			tf.bold = true;
			tf.align = TextFormatAlign.RIGHT;
			
			_itemNum = new TextField();
			_itemNum.defaultTextFormat = tf;
			_itemNum.selectable = false;
			_itemNum.height = 20;
			_itemNum.width = 40;
			_itemNum.text = "(00)";
			_itemNum.antiAliasType = TextFormatAlign.LEFT;
			_itemNum.x = 185;
			_itemNum.y = 75;
			this.addChild(_itemNum);
		}
		
		private function initChild():void{
			playBtn = new PlayButton();
			playBtn.x = 15;
			playBtn.y = 15;
			this.addChild(playBtn);
			
			nextSongBtn = new NextOneButton();
			nextSongBtn.x = 60;
			nextSongBtn.y = 25;
			this.addChild(nextSongBtn);
			
			timeAreaPanel = new TimeAreaPanel();
			timeAreaPanel.x = 101;
			timeAreaPanel.y = 24;
			this.addChild(timeAreaPanel);
			
			resetBtn = new BaseButton("重置列表",55,20,2);
			resetBtn.x = 10;
			resetBtn.y = 75;
			this.addChild(resetBtn);
			
			randomBtn = new BaseButton("随机打乱",55,20,2);
			randomBtn.x = resetBtn.x +resetBtn.width +5;
			randomBtn.y = resetBtn.y;
			this.addChild(randomBtn);
			
			clearBtn = new BaseButton("清空列表",55,20,2);
			clearBtn.x = randomBtn.x +randomBtn.width +5;
			clearBtn.y = resetBtn.y;
			this.addChild(clearBtn);
			
			minusBtn = new MinusButton();
			minusBtn.x = 240;
			minusBtn.y = 78;
			this.addChild(minusBtn);
			
			plusBtn = new PlusButton();
			plusBtn.x = 225;
			plusBtn.y = 77;
			this.addChild(plusBtn);

			songsPanel = new SongsPanel();
			songsPanel.y = 100;
			this.addChild(songsPanel);
			
			_scrollBar = new ScrollBar();
			_scrollBar.x = 260;
			_scrollBar.y = 100;
			this.addChild(_scrollBar);
			_scrollBar.baby = _songsPanel;
//soundCtrlPanel 要在songsPanel后面 以便songsPanel可以听到soundCtrlPanel里面的音量大小
			soundCtrlPanel = new SoundCtrlPanel();
			soundCtrlPanel.x = 214;
			soundCtrlPanel.y = 26;
			this.addChild(soundCtrlPanel);
			
			_lrcPanel = new LRCPanel();
			_lrcPanel.y = 340;
			this.addChild(_lrcPanel);
			
		}
		
	}
}