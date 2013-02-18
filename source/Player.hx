package;

import org.flixel.FlxSprite;
import org.flixel.FlxG;
import org.flixel.FlxObject;
import org.flixel.plugin.photonstorm.FlxControl;
import org.flixel.plugin.photonstorm.FlxControlHandler;

class Player extends FlxSprite
{
	public var state:String;
	#if flash
	public var colorBox:UInt;
	#else
	public var colorBox:Int;
	#end

	#if flash
	public function new(x:Float,y:Float, colorBox:UInt) {
	#else
	public function new(x:Float,y:Float, colorBox:Int) {
	#end

		super(x,y);
		
		this.colorBox = colorBox;
		state = "middleground";
		makeGraphic(30,30,colorBox);
		maxAngular = 1000;
		//angularAcceleration = 200;
		angularVelocity = 100;
		
		if (FlxG.getPlugin(FlxControl) == null)	FlxG.addPlugin(new FlxControl());		
		FlxControl.create(this, FlxControlHandler.MOVEMENT_ACCELERATES, FlxControlHandler.STOPPING_DECELERATES, 1, true, false);
		FlxControl.player1.setMovementSpeed(400, 0, 400, 415, 100, 0);
		FlxControl.player1.setGravity(0, 400);
	}
	
	override public function update():Void {
		super.update();
		color = colorBox;
		acceleration.x = maxVelocity.x/2;
		angularAcceleration = maxAngular/2;
	}
	
	override public function destroy():Void {	
		FlxControl.clear();			
		super.destroy();
	}

	public function jump():Void {	
		if (FlxG.mouse.pressed() && isTouching(FlxObject.FLOOR)) velocity.y = -maxVelocity.y;			
		if (!isTouching(FlxObject.FLOOR) && velocity.y < 0) if (!FlxG.mouse.pressed()) velocity.y = 10;
	}

	public function changeState(state:String):Bool {
		this.state = state;
		switch (this.state) {
			case "background": 
				makeGraphic(15,15,colorBox);
				FlxControl.player1.setMovementSpeed(400, 0, 400, 290, 100, 0);
				return true;
			case "middleground": 
				makeGraphic(30,30,colorBox);
				FlxControl.player1.setMovementSpeed(400, 0, 400, 415, 100, 0);
				return true;
			case "foreground":
				makeGraphic(60,60,colorBox);
				FlxControl.player1.setMovementSpeed(400, 0, 400, 580, 100, 0);
				return true;
			default: 
				return false;
		}
	}
}