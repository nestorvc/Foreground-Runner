package;

import org.flixel.FlxSprite;
import org.flixel.FlxG;
import org.flixel.FlxObject;
import org.flixel.FlxGroup;
import org.flixel.plugin.photonstorm.FlxButtonPlus;
import org.flixel.plugin.photonstorm.FlxVelocity;
import org.flixel.plugin.photonstorm.FlxControl;
import flash.Lib;

class HUD extends FlxGroup
{
	private var upBtn:FlxButtonPlus;
	private var downBtn:FlxButtonPlus;
	private var restartBtn:FlxButtonPlus;
	public var score:Score;

	private var mainStages:Stages;
	private var player:Player;

	private var debugBox:FlxSprite;

	private var mOver:Bool;
	
	public function new(stages:Stages, player:Player) {
		super();

		this.mainStages = stages;
		this.player = player;
		upBtn = new FlxButtonPlus(0,FlxG.height-50, pressUp);		
		downBtn = new FlxButtonPlus(340,FlxG.height-50, pressDown);
		restartBtn = new FlxButtonPlus(FlxG.width-40,10, restart);
		score = new Score(10,10,100, "SCORE", player);
		mOver = false;

		debugBox = new FlxSprite();
		debugBox.loadGraphic("assets/fakeCursor.png",false,false,2,2);

		var uPNG:FlxSprite = new FlxSprite(0,0,"assets/upBtn.png");
		var uPNG_on:FlxSprite = new FlxSprite(0,0,"assets/upBtn_on.png");
		var dPNG:FlxSprite = new FlxSprite(0,0,"assets/downBtn.png");
		var dPNG_on:FlxSprite = new FlxSprite(0,0,"assets/downBtn_on.png");
		var rPNG:FlxSprite = new FlxSprite(0,0,"assets/restartBtn.png");
		var rPNG_on:FlxSprite = new FlxSprite(0,0,"assets/restartBtn_on.png");

		upBtn.loadGraphic(uPNG,uPNG_on);
		upBtn.setOnClickCallback(pressUp);
		upBtn.setMouseOverCallback(mouseOver);
		upBtn.setMouseOutCallback(mouseOut);
		downBtn.loadGraphic(dPNG,dPNG_on);
		downBtn.setOnClickCallback(pressDown);
		downBtn.setMouseOverCallback(mouseOver);
		downBtn.setMouseOutCallback(mouseOut);		
		restartBtn.loadGraphic(rPNG,rPNG_on);

		add(upBtn);
		add(downBtn);
		add(restartBtn);
		add(debugBox);
		add(score);
	}

	override public function update():Void {
		debugBox.x = FlxG.mouse.x;
		debugBox.y = FlxG.mouse.y;

		pressAnywhere();
		super.update();
	}

	public function pressAnywhere():Void {
		#if flash
		if(!mOver && FlxG.mouse.pressed()) player.jump();
		#else
		if(!FlxG.overlap(debugBox,upBtn) || !FlxG.overlap(debugBox,downBtn)) player.jump();
		#end
	}

	public function pressUp():Void {
		switch (mainStages.activeStage) {
			case 1: mainStages.activeStage = 0;
					player.changeState("background");
					mainStages.transport(mainStages.stages[mainStages.activeStage]);
			case 2: mainStages.activeStage = 1;
					player.changeState("middleground");
					mainStages.transport(mainStages.stages[mainStages.activeStage]);					
		}
	}

	public function pressDown():Void {
		switch (mainStages.activeStage) {
			case 0: mainStages.activeStage = 1;
					player.changeState("middleground");
					mainStages.transport(mainStages.stages[mainStages.activeStage]);
			case 1: mainStages.activeStage = 2;
					player.changeState("foreground");
					mainStages.transport(mainStages.stages[mainStages.activeStage]);
		}		
	}

	public function mouseOut():Void {
		mOver = false;
	}

	public function mouseOver():Void {
		mOver = true;
	}

	public function restart():Void {
		FlxG.resetState();	
	}

}