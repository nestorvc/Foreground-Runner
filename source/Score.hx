package;

import org.flixel.FlxText;
import org.flixel.FlxG;
import org.flixel.FlxObject;
import org.flixel.FlxPoint;
import org.flixel.plugin.photonstorm.FlxVelocity;

class Score extends FlxText
{
	public var distance:Int;

	private var player:Player;
	private var startP:FlxPoint;

	public function new(x:Float,y:Float, width:Int, text:String, player:Player) {
		super(x,y,width,text);

		this.player = player;
		distance = 0;
		startP = new FlxPoint(0,FlxG.height/2);

		scrollFactor.x = scrollFactor.y = 0;
		size = 20;
	}

	override public function update():Void {
		updateDistance();
		/*
		switch (distance) {
			case 2000:player.colorBox = FlxG.RED; 
			FlxG.flash(FlxG.WHITE, 1); 
			FlxG.play("LevelUp");
			case 4000:player.colorBox = FlxG.BLUE; 
			FlxG.flash(FlxG.WHITE, 1); 
			FlxG.play("LevelUp");
			case 6000:player.colorBox = FlxG.GREEN; 
			FlxG.flash(FlxG.WHITE, 1); 
			FlxG.play("LevelUp");
			case 8000:player.colorBox = FlxG.PINK; 
			FlxG.flash(FlxG.WHITE, 1); 
			FlxG.play("LevelUp");
			case 10000:player.colorBox = FlxG.BLACK; 
			FlxG.flash(FlxG.WHITE, 1); 
			FlxG.play("LevelUp");
			case 12000:player.flicker(-1); 
			FlxG.flash(FlxG.WHITE, 1); 
			FlxG.play("LevelUp");
		}
		// */
		// /*
		if (distance > 22000 && distance < 22100) { 
			player.flicker(-1); 
			FlxG.flash(FlxG.WHITE, 1); 
			FlxG.play("LevelUp");
		}
		else if (distance > 18000 && distance < 18100) { 
			player.colorBox = FlxG.BLACK; 
			FlxG.flash(FlxG.WHITE, 1); 
			FlxG.play("LevelUp");
		}
		else if (distance > 14000 && distance < 14100) { 
			player.colorBox = FlxG.PINK; 
			FlxG.flash(FlxG.WHITE, 1); 
			FlxG.play("LevelUp");
		}
		else if (distance > 10000 && distance < 10100) {	
			player.colorBox = FlxG.GREEN; 
			FlxG.flash(FlxG.WHITE, 1); 
			FlxG.play("LevelUp");
		}
		else if (distance > 6000 && distance < 6100) {	
			player.colorBox = FlxG.BLUE; 
			FlxG.flash(FlxG.WHITE, 1); 
			FlxG.play("LevelUp");
		}
		else if(distance > 2000 && distance < 2100) { 
			player.colorBox = FlxG.RED; 
			FlxG.flash(FlxG.WHITE, 1); 
			FlxG.play("LevelUp");			
		}
		//*/

		super.update();
	}

	public function updateDistance():Void {
		distance = FlxVelocity.distanceToPoint(player,startP);
		this.text = distance + "m.";
	}
}