package;

import nme.Assets;
import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.FlxState;
import org.flixel.FlxCamera;
import org.flixel.FlxText;
import com.testflightapp.TestFlight;

class ScoreState extends FlxState
{
	private var score:Int;
	private var text:FlxText;

	public function new(score:Int) {
		super();
		this.score = score;
	}

	override public function create():Void
	{
		TestFlight.passCheckpoint("ScoreState");
		TestFlight.remoteLog("LOG: Just reached ScoreState");

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

		text = new FlxText(0, FlxG.height/3, FlxG.width, score + "m");
		text.size = 100;
		text.alignment = "center";

		add(text);
	}
	
	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update():Void
	{	
		if(FlxG.keys.any() || FlxG.mouse.pressed()) FlxG.switchState(new PlayState());
		super.update();
	}	
}