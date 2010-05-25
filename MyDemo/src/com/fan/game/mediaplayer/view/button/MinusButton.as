package com.fan.game.mediaplayer.view.button
{
	import com.fan.game.common.view.HoverPanel;
	import com.fan.game.common.view.button.BaseGlowButton;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class MinusButton extends BaseGlowButton
	{
		public function MinusButton()
		{
			super();
			draw();
		}
		private function draw():void{
			this.graphics.beginFill(0xffffff);
			this.graphics.drawRect(2,5,12,4);
			this.graphics.endFill();
			
			var bg:Sprite = new Sprite();
			bg.graphics.beginFill(0x000000);
			bg.graphics.drawRect(0,0,14,14);
			bg.graphics.endFill();
			bg.alpha = 0;
			this.addChild(bg);
			var hoverPanel:HoverPanel = new HoverPanel("增长播放列表");
			this.addChild(hoverPanel);
		}
		
	}
}