package;

import nme.Assets;
import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.FlxState;
import org.flixel.FlxCamera;
import org.flixel.FlxText;

import org.flixel.plugin.photonstorm.FlxVelocity;

class PlayState extends FlxState
{
	private var ghost:Ghost;
	private var player:Player;
	private var stages:Stages;
	private var hud:HUD;

	public var dark:FlxSprite;

	override public function create():Void
	{
		#if !neko
		FlxG.bgColor = 0xff131c1b;
		#else
		FlxG.camera.bgColor = {rgb: 0x131c1b, a: 0xff};
		#end	

		#if flash
		FlxG.mouse.show();
		#else
		FlxG.mouse.show();
		FlxG.mouse.load("assets/fakeCursor.png");
		#end		
		
		dark = new FlxSprite(0,0);
		dark.scrollFactor.x = dark.scrollFactor.y = 0;
		dark.makeGraphic(FlxG.width,FlxG.height,FlxG.BLACK);
		dark.alpha = 0;

		player = new Player(10,10, FlxG.WHITE);
		stages = new Stages(player);
		ghost = new Ghost(-1200,200, player, this);
		hud = new HUD(stages,player);

		add(stages);
		add(ghost);
		add(dark);
		add(hud);

		if(FlxG.music == null) FlxG.playMusic("Music");
		FlxG.camera.follow(player,FlxCamera.STYLE_LOCKON);
	}
	
	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update():Void
	{
		super.update();
	}	

	public function gameOver():Void
	{
		FlxG.switchState(new ScoreState(hud.score.distance));
	}	
}