package com.fan.game.mediaplayer.view.panel
{
	import com.fan.game.common.view.HoverPanel;
	import com.fan.game.common.view.button.BaseButton;
	import com.fan.game.mediaplayer.events.MusicEvent;
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	public class SoundCtrlPanel extends Sprite
	{
		private var mainLine:Sprite;
		private var slideRect:BaseButton;
		private var bg:Sprite;

		/**
		 * 发出事件改变音量大小 
		 * @param value
		 * 
		 */		
		private function set valueSize(value:Number):void
		{
			this.root.dispatchEvent(new MusicEvent(MusicEvent.CHANGE_Value,[value]));
		}

		
		public function SoundCtrlPanel()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE,addedToStageHandler);
			this.addEventListener(Event.REMOVED_FROM_STAGE,removedFromStageHandler);
		}
		
		private function addedToStageHandler(evt:Event):void{
			this.removeEventListener(Event.ADDED_TO_STAGE,addedToStageHandler);
			this.buttonMode = true;
			drawMainLine();
			drawBg();
			drawSlideRect();
			confingerListeners();
		}
		
		private function removedFromStageHandler(evt:Event):void{
			this.removeEventListener(Event.REMOVED_FROM_STAGE,removedFromStageHandler);
			dispose();
		}
		
		private function drawBg():void{
			bg = new Sprite();
			bg.graphics.beginFill(0xff0000);
			bg.graphics.drawRect(0,0,50,16);
			bg.graphics.endFill();
			bg.alpha = 0;
			this.addChild(bg);
		}
		
		private function drawSlideRect():void{
			slideRect = new BaseButton("",16,16,3); 
			slideRect.x = (mainLine.width - slideRect.width);
			valueSize = slideRect.x/34;
			this.addChild(slideRect);
			var hoverPanel:HoverPanel = new HoverPanel("音量大小");
			slideRect.addChild(hoverPanel);
		}
		
		private function drawMainLine():void{
			mainLine = new Sprite();
			mainLine.graphics.lineStyle(3,0x000000);
			mainLine.graphics.lineTo(47,0);
			mainLine.y = 7;
			mainLine.x = 1;
			this.addChild(mainLine);
		}
		
		private function dispose():void{
			slideRect.removeEventListener(MouseEvent.MOUSE_DOWN,downSlideHandler);
			bg.removeEventListener(MouseEvent.CLICK,bgClickHandler);
			slideRect.stage.removeEventListener(MouseEvent.MOUSE_UP,upSlideHandler);
			slideRect.removeEventListener(MouseEvent.MOUSE_MOVE,moveHandler);
		}
		
		
		private function confingerListeners():void{
			slideRect.addEventListener(MouseEvent.MOUSE_DOWN,downSlideHandler);
			bg.addEventListener(MouseEvent.CLICK,bgClickHandler);
		}
		
		private function bgClickHandler(evt:MouseEvent):void{
			var xLocation:Number;
			if(evt.localX - slideRect.width/2 < 0){
				xLocation = 0;
			}else if(evt.localX - slideRect.width/2 > 34){
				xLocation = 34;
			}else{
				xLocation = evt.localX - slideRect.width/2;
			}
			TweenLite.to(slideRect, 0.5, {x:xLocation, y:0});
			valueSize = xLocation/34;
		}
		
		
		private function downSlideHandler(evt:MouseEvent):void{
			slideRect.stage.addEventListener(MouseEvent.MOUSE_UP,upSlideHandler);
			slideRect.addEventListener(MouseEvent.MOUSE_MOVE,moveHandler);
			slideRect.startDrag(false,new Rectangle(0,0,34,0));
		}
		
		private function moveHandler(evt:MouseEvent):void{
			valueSize = slideRect.x/34;
		}
		
		private function upSlideHandler(evt:MouseEvent):void{
			slideRect.stopDrag();
			slideRect.removeEventListener(MouseEvent.MOUSE_UP,upSlideHandler);
			slideRect.removeEventListener(MouseEvent.MOUSE_MOVE,moveHandler);
		}
		
		
		
	}
}