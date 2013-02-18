package;

import org.flixel.FlxSprite;
import org.flixel.FlxG;
import org.flixel.FlxObject;
import org.flixel.FlxPoint;
import org.flixel.FlxState;
import org.flixel.plugin.photonstorm.FlxControl;
import org.flixel.plugin.photonstorm.FlxVelocity;
import org.flixel.plugin.photonstorm.FlxControlHandler;

class Ghost extends FlxSprite
{
	private var player:Player;
	private var state:PlayState;

	public function new(x:Float,y:Float, player:Player, state:PlayState) {
		super(x,y);

		this.player = player;
		this.state = state;
		makeGraphic(400,400,FlxG.BLACK);
		maxAngular = 1000;
		angularAcceleration = 100;
		angularVelocity = 500;
		velocity = new FlxPoint(400,0);
		acceleration = new FlxPoint(0,0);
		maxVelocity = new FlxPoint(350,400);
		drag = new FlxPoint(100,0);

		immovable = true;
		solid = true;
	}
	
	override public function update():Void {
		flicker(-1);
		acceleration.x = maxVelocity.x/4;

		var shake:Float = (FlxVelocity.distanceBetween(this,player)-600)*-0.5*0.0001;
		if(shake >= 0) {
			FlxG.log(shake);
			state.dark.alpha = shake*40;
			FlxG.shake(shake);
			//FlxG.flash(FlxG.RED);
		}

		if(this.x + 300 > player.x ) { 	
			#if flash		
			FlxG.fade(FlxG.BLACK,0.5,nextState);
			#else
			nextState();
			#end
		}
		super.update();
	}

	override public function destroy():Void {			
		super.destroy();
	}

	public function nextState():Void {			
		state.gameOver();
	}
}