package com.fan.game.mediaplayer.view.panel
{
	import com.fan.game.common.util.TimeConvert;
	import com.fan.game.common.view.HoverPanel;
	import com.fan.game.mediaplayer.events.MusicEvent;
	import com.greensock.TweenLite;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import org.osmf.events.TimeEvent;
	
	public class TimeAreaPanel extends Sprite
	{
		private var progressPanel:Sprite;
		private var _timeMsg1:TextField;
		private var _timeMsg2:TextField;
		
		public function set timeMsg1(timeMsg:String):void{
			_timeMsg1.text = timeMsg;
			var tempScale:Number = 1-TimeConvert.hmsTomillisecond(timeMsg)/TimeConvert.hmsTomillisecond(_timeMsg2.text);
			TweenLite.to(progressPanel, 0.5, {scaleX:tempScale});
		}
		
		public function set timeMsg2(timeMsg:String):void{
			_timeMsg2.text = timeMsg;
		}
		
		public function TimeAreaPanel()
		{
			super();
			draw();
			this.addEventListener(MouseEvent.CLICK,changeProgressHandler);
		}
		
		private function changeProgressHandler(evt:MouseEvent):void{
			var tempScale:Number = 1-evt.localX/this.width;
			TweenLite.to(progressPanel, 0.3, {scaleX:tempScale});
			//没有冒泡
			this.dispatchEvent(new MusicEvent(MusicEvent.CHANGE_SONG_PROGRESS,[1-tempScale]));
		}
		
		private function draw():void{
			this.buttonMode = true;
			this.mouseChildren = false;
			this.graphics.beginFill(0x203a53);
			this.graphics.drawRoundRect(0,0,100,20,8,8);
			this.graphics.endFill();
			
			progressPanel = new Sprite();
			progressPanel.graphics.beginFill(0x000000,0.8);
			progressPanel.graphics.drawRoundRectComplex(-100,0,100,20,0,8,0,8);
			progressPanel.graphics.endFill();
			progressPanel.x = 100;
			this.addChild(progressPanel);
			
			var tf1:TextFormat = new TextFormat();
			tf1.bold = true;
			tf1.font = "宋体";
			tf1.color = 0xffffff;
			tf1.align = TextFormatAlign.RIGHT
			_timeMsg1 = new TextField();
			_timeMsg1.defaultTextFormat = tf1;
			_timeMsg1.selectable = false;
			_timeMsg1.width = 50;
			_timeMsg1.height = 18;
			_timeMsg1.y = 2;
			_timeMsg1.text = "00:00";
			this.addChild(_timeMsg1);
			
			var tf2:TextFormat = new TextFormat();
			tf2.bold = true;
			tf2.font = "宋体";
			tf2.color = 0xffffff;
			tf2.align = TextFormatAlign.LEFT
			_timeMsg2 = new TextField();
			_timeMsg2.defaultTextFormat = tf2;
			_timeMsg2.selectable = false;
			_timeMsg2.x = 50;
			_timeMsg2.width = 50;
			_timeMsg2.height = 18;
			_timeMsg2.y = 2;
			_timeMsg2.text = "00:00";
			this.addChild(_timeMsg2);
			
			
			var line:Shape = new Shape();
			line.graphics.lineStyle(1.5,0xffffff);
			line.graphics.moveTo(51,4);
			line.graphics.lineTo(47,16);
			this.addChild(line);
			
//			var hoverPanel:HoverPanel = new HoverPanel("调整播放位置");
//			this.addChild(hoverPanel);
		}
		
	}
}