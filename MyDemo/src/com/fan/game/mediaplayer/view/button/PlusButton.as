package com.fan.game.mediaplayer.view.button
{
	import com.fan.game.common.view.HoverPanel;
	import com.fan.game.common.view.button.BaseGlowButton;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class PlusButton extends BaseGlowButton
	{
		public function PlusButton()
		{
			super();
			draw();
		}
		
		private function draw():void{
			var bg:Sprite = new Sprite();
			bg.graphics.beginFill(0x000000);
			bg.graphics.drawRect(0,0,14,14);
			bg.graphics.endFill();
			bg.alpha = 0;
			this.addChild(bg);
			
			this.graphics.beginFill(0xffffff);
			this.graphics.drawRect(2,6,12,4);
			this.graphics.endFill();
			this.graphics.beginFill(0xffffff);
			this.graphics.drawRect(6,2,4,12);
			this.graphics.endFill();
			
			var hoverPanel:HoverPanel = new HoverPanel("缩短播放列表");
			this.addChild(hoverPanel);
		}
		
	}
}