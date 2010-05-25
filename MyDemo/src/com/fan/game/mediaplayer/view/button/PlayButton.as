package com.fan.game.mediaplayer.view.button
{
	import com.fan.game.common.view.HoverPanel;
	import com.fan.game.common.view.button.BaseGlowButton;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class PlayButton extends BaseGlowButton
	{
		private var _playStatus:Boolean = true;
		
		public function PlayButton()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE,addedToStageHandler);
			this.addEventListener(Event.REMOVED_FROM_STAGE,removedFromStageHandler);
		}
		/**
		 * 播放状态 
		 * @return 
		 * 
		 */		
		public function get playStatus():Boolean
		{
			return _playStatus;
		}
		/**
		 *播放状态 
		 * @param value
		 * 
		 */
		public function set playStatus(value:Boolean):void
		{
			_playStatus = value;
			value?drawPlay():drawPause();
		}

		private function addedToStageHandler(evt:Event):void{
			this.removeEventListener(Event.ADDED_TO_STAGE,addedToStageHandler);
			init();
			confingerListener();
		}
		
		private function removedFromStageHandler(evt:Event):void{
			dispose();
		}
		
		private function confingerListener():void{
			this.addEventListener(MouseEvent.CLICK,clickHandler);
		}
		
		private function dispose():void{
			this.removeEventListener(Event.REMOVED_FROM_STAGE,removedFromStageHandler);
			this.removeEventListener(MouseEvent.CLICK,clickHandler);
		}
		
		private function clickHandler(evt:MouseEvent):void{
			if(!playStatus){
				this.playStatus = true;
				drawPlay();
			}else{
				this.playStatus = false;
				drawPause();
			}
			trace(this.playStatus);
		}
		
		private function init():void{
			var bg:Sprite = new Sprite();
			bg.graphics.beginFill(0x000000);
			bg.graphics.drawRect(0,0,40,40);
			bg.graphics.endFill();
			bg.alpha = 0;
			this.addChild(bg);
			drawPlay();
			
			var hoverPanel:HoverPanel = new HoverPanel("播放/暂停");
			this.addChild(hoverPanel);
		}
		
		/**
		 * 按钮播放状态 
		 * 
		 */		
		private function drawPlay():void{
			
			this.graphics.clear();
			this.graphics.beginFill(0xffffff);
			this.graphics.drawRect(0,0,15,40);
			this.graphics.drawRect(20,0,15,40);
			this.graphics.endFill();
		}
		/**
		 *按钮暂停状态 
		 * 
		 */		
		private function drawPause():void{
			this.graphics.clear();
			this.graphics.beginFill(0xffffff);
			this.graphics.lineTo(40,20);
			this.graphics.lineTo(0,40);
			this.graphics.lineTo(0,0);
			this.graphics.endFill();
		}
		
	}
}