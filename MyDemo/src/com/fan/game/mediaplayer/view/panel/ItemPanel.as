package com.fan.game.mediaplayer.view.panel
{
	import com.fan.game.common.view.HoverPanel;
	import com.fan.game.common.view.button.BaseButton;
	import com.fan.game.mediaplayer.events.MusicEvent;
	import com.greensock.TweenLite;
	import com.greensock.plugins.TintPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class ItemPanel extends Sprite
	{
		private var txt:TextField;
		private var bg:Sprite;
		private var playBtn:BaseButton;
		private var delBtn:BaseButton;
		private var storeBtn:BaseButton;
		
		private var label:TextField = new TextField();
		
		public function ItemPanel(fileName:String)
		{
			this.name = fileName;
			super();
			draw();
			label.text = fileName;
			confingerListeners();
			this.addEventListener(Event.REMOVED_FROM_STAGE,removedFromStageHandler);
			
		}
		public function removedFromStageHandler(evt:Event):void{
			dispose();
		}
		
		private function confingerListeners():void{
			this.addEventListener(MouseEvent.MOUSE_OVER,overHandler);
			this.addEventListener(MouseEvent.MOUSE_OUT,outHandler);
			delBtn.addEventListener(MouseEvent.CLICK,delSelfHandler);
			playBtn.addEventListener(MouseEvent.CLICK,playSelfHandler);
			storeBtn.addEventListener(MouseEvent.CLICK,storeHandler);
		}
		private function dispose():void{
			this.removeEventListener(MouseEvent.MOUSE_OVER,overHandler);
			this.removeEventListener(MouseEvent.MOUSE_OUT,outHandler);
			delBtn.removeEventListener(MouseEvent.CLICK,delSelfHandler);
			playBtn.removeEventListener(MouseEvent.CLICK,playSelfHandler);
			storeBtn.removeEventListener(MouseEvent.CLICK,storeHandler);
			
			txt = null;
			bg = null;
			playBtn = null;
			delBtn = null;
			storeBtn = null;
		}
		
		private function storeHandler(evt:MouseEvent):void{
		}
		private function playSelfHandler(evt:MouseEvent):void{
			this.dispatchEvent(new MusicEvent(MusicEvent.PLAY_ME,[],true));
		}
		private function delSelfHandler(evt:MouseEvent):void{
			this.dispatchEvent(new MusicEvent(MusicEvent.DEL_ITEM,[],true));
		}
		
		private function overHandler(evt:MouseEvent):void{
			playBtn.visible = true;
			delBtn.visible = true;
			storeBtn.visible = true;
			TweenPlugin.activate([TintPlugin]);
			TweenLite.to(bg, 0.4, {tint:0xfedb65});
		}
		
		private function outHandler(evt:MouseEvent):void{
			playBtn.visible = false;
			delBtn.visible = false;
			storeBtn.visible = false;
			TweenPlugin.activate([TintPlugin]);
			TweenLite.to(bg, 0.4, {tint:0xffffff});
		}
		
		private function draw():void{
			bg = new Sprite();
			bg.graphics.beginFill(0xffffff);
			bg.graphics.drawRect(0,0,280,24);
			bg.graphics.endFill();
			this.addChild(bg);
			
			var rect:Shape = new Shape();
			rect.graphics.beginFill(0x000000);
			rect.graphics.drawRect(0,0,4,4);
			rect.graphics.endFill();
			rect.x = 10;
			rect.y = 10;
			this.addChild(rect);
			
			label = new TextField();
			label.x = 24;
			label.y = 3;
			label.text = "";
			label.width = 255;
			label.height = 21;
			label.selectable = false;
			this.addChild(label);
			
			playBtn = new BaseButton("",18,18);
			playBtn.visible = false;
			playBtn.x = 180;
			playBtn.y = 3;
			this.addChild(playBtn);
			var playBtnCore:Shape = new Shape();
			playBtnCore.graphics.beginFill(0x49637c);
			playBtnCore.graphics.lineTo(0,12);
			playBtnCore.graphics.lineTo(6,6);
			playBtnCore.graphics.lineTo(0,0);
			playBtnCore.graphics.endFill();
			playBtnCore.x  = 6;
			playBtnCore.y  = 2.5;
			playBtn.addChild(playBtnCore);
			
			storeBtn  = new BaseButton("",18,18);
			storeBtn.visible = false;
			storeBtn.x = playBtn.x +playBtn.width+5;
			storeBtn.y = 3;
			this.addChild(storeBtn);
			var storeBtnCore:Shape = new Shape();
			storeBtnCore.graphics.lineStyle(2,0x49537c);
			storeBtnCore.graphics.drawCircle(5,5,5);
			storeBtnCore.x  = 4;
			storeBtnCore.y  = 4;
			storeBtn.addChild(storeBtnCore);
			
			delBtn  = new BaseButton("",18,18);
			delBtn.visible = false;
			delBtn.x = storeBtn.x +storeBtn.width+5;
			delBtn.y = 3;
			this.addChild(delBtn);
			var delBtnCore:Shape = new Shape();
			delBtnCore.graphics.lineStyle(2,0x49537c);
			delBtnCore.graphics.lineTo(8,8);
			delBtnCore.graphics.moveTo(8,0);
			delBtnCore.graphics.lineTo(0,8);
			delBtnCore.x  = 5;
			delBtnCore.y  = 5;
			delBtn.addChild(delBtnCore);
			
		}
		
		
	}
}