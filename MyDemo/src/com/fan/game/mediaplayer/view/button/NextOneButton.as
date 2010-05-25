package com.fan.game.mediaplayer.view.button
{
	import com.fan.game.common.view.HoverPanel;
	import com.fan.game.common.view.button.BaseGlowButton;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class NextOneButton extends BaseGlowButton
	{
		public function NextOneButton()
		{
			draw();
		}
		private function draw():void{
			var bg:Sprite = new Sprite();
			bg.graphics.beginFill(0x000000);
			bg.graphics.drawRect(0,0,30,18);
			bg.graphics.endFill();
			bg.alpha = 0;
			this.addChild(bg);
			
			var triAngle:Sprite = new Sprite();
			triAngle.graphics.beginFill(0xffffff);
			triAngle.graphics.lineTo(14,7);
			triAngle.graphics.lineTo(0,14);
			triAngle.graphics.lineTo(0,0);
			triAngle.graphics.endFill();
			this.addChild(triAngle);
			
			var triAngle2:Sprite = new Sprite();
			triAngle2.graphics.beginFill(0xffffff);
			triAngle2.graphics.lineTo(14,7);
			triAngle2.graphics.lineTo(0,14);
			triAngle2.graphics.lineTo(0,0);
			triAngle2.graphics.endFill();
			triAngle2.x = 10;
			this.addChild(triAngle2);
			
			var verticalBar:Sprite = new Sprite();
			verticalBar.graphics.beginFill(0xffffff);
			verticalBar.graphics.drawRoundRect(0,0,4,15,5,5);
			verticalBar.graphics.endFill();
			verticalBar.x = triAngle2.x + triAngle2.width;
			this.addChild(verticalBar);
			
			var hoverPanel:HoverPanel = new HoverPanel("下一首");
			this.addChild(hoverPanel);
		}
		
	}
}