package;

import org.flixel.FlxSprite;
import org.flixel.FlxG;
import org.flixel.FlxObject;
import org.flixel.FlxGroup;
import org.flixel.FlxRect;
import org.flixel.FlxPoint;
import org.flixel.plugin.photonstorm.FlxVelocity;
import org.flixel.plugin.photonstorm.FlxMath;
import flash.Lib;

class Stages extends FlxGroup
{
	public var dynamicBounds:FlxRect;
	public var activeStage:Int;
	public var stages:Array<Floor>;	

	private var blocks:Array<FlxSprite>;
	private var currentBlock:Int;
	private var player:Player;
	public var sky:Sky;
	private var background:Floor;
	private var ground:Floor;
	private var foreground:Floor;

	private var transportPoint:FlxPoint;
	
	public function new(player:Player) {
		super();

		this.player = player;
		dynamicBounds = new FlxRect();	
		sky = new Sky(100,-70);
		background = new Floor(0, 200, player, 0xff538a82);
		ground = new Floor(0,350, player, 0xff375f59);
		foreground = new Floor(0,500, player, 0xff1b332f);
		stages = new Array();
		activeStage = 1;
		transportPoint = new FlxPoint();

		blocks = new Array();
		currentBlock = 0;

		var tempBlockB:FlxSprite = new FlxSprite(1700, background.y-100);
		tempBlockB.makeGraphic(50,100,0xff538a82);
		tempBlockB.immovable = true;
		tempBlockB.solid = true;
		background.add(tempBlockB);
		blocks.push(tempBlockB);
			
		var tempBlockR:FlxSprite = new FlxSprite(1200, ground.y-200);
		tempBlockR.makeGraphic(100,200,0xff375f59);
		tempBlockR.immovable = true;
		tempBlockR.solid = true;
		ground.add(tempBlockR);
		blocks.push(tempBlockR);

		var tempBlockG:FlxSprite = new FlxSprite(1800, foreground.y-400);
		tempBlockG.makeGraphic(200,400,0xff1b332f);
		tempBlockG.immovable = true;
		tempBlockG.solid = true;
		tempBlockG.alpha = 0.5;
		foreground.add(tempBlockG);
		blocks.push(tempBlockG);

		stages.push(background);
		stages.push(ground);
		stages.push(foreground);
		
		add(sky);
		add(background);
		add(player);
		add(ground);
		add(foreground);

		FlxG.collide(player,stages[activeStage]);
	}

	override public function update():Void {
		updateBounds();		
		FlxG.worldBounds = dynamicBounds;

		super.update();

		for (block in blocks) {
			if(FlxG.overlap(block,player) && !stages[activeStage].isChild(block)) block.alpha = 0.5;			
			else block.alpha = 1;
		}

		var rand:Float = FlxMath.randFloat(250,750);
		var rand2:Float = FlxMath.randFloat(500,850);
		if(blocks[currentBlock].x < player.x-rand) {
			blocks[currentBlock].x = player.x+rand2;
			switch (currentBlock) {
				case 0: currentBlock = 1;
				case 1: currentBlock = 2;
				case 2: currentBlock = 0;
			}
		}

		FlxG.collide(player,stages[activeStage]);
	}

	public function transport(stage:Floor):Void {
		/*
		transportPoint = new FlxPoint(player.x, stage.y-player.height-10);
		player.acceleration.y = 0;
		FlxVelocity.moveTowardsPoint(player, transportPoint, 2000);
		//*/

		player.y = stage.y-player.height;	
		this.sort();	
	}

	public function updateBounds():Void {	
		dynamicBounds = new FlxRect(background.minorX, 0, ground.totalWidth, foreground.maxY);
	}
}