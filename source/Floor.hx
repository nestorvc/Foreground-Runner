package;

import org.flixel.FlxSprite;
import org.flixel.FlxG;
import org.flixel.FlxObject;
import org.flixel.FlxGroup;
import org.flixel.FlxRect;
import flash.Lib;

class Floor extends FlxGroup
{
	public var minorX:Float;
	public var maxX:Float;
	public var minorY:Float;
	public var maxY:Float;
	public var x:Float;
	public var y:Float;
	public var totalWidth:Float;

	public var floor1:FlxSprite;
	public var floor2:FlxSprite;
	private var player:Player;
	private var currentFloor:FlxObject;	
	
	#if flash
	public function new(x:Float, y:Float, player:Player, color:UInt) {
	#else
	public function new(x:Float, y:Float, player:Player, color:Int) {
	#end	
		super();

		this.x = x;
		this.y = y;
		this.player = player;
		floor1 = new FlxSprite(x,y);
		floor1.makeGraphic(800,200,color);
		floor1.immovable = true;
		floor1.solid = true;

		floor2 = new FlxSprite(floor1.x+floor1.width,y);
		floor2.makeGraphic(800,200,color);
		floor2.immovable = true;
		floor2.solid = true;

		currentFloor = floor2;	
		totalWidth = floor1.width + floor2.width;
		minorX = floor1.x;
		maxX = floor2.x;
		minorY = floor1.y;
		maxY = floor1.y + floor1.height;

		add(floor1);
		add(floor2);
	}

	override public function update():Void {
		moveFloor();
		updateMinorMaxX();
		FlxG.overlap(player,this,updateFloors);		

		super.update();
	}

	public function updateMinorMaxX():Void {	
		if(floor1.x < floor2.x) {
			minorX = floor1.x;
			maxX = floor2.x;
		}
		else {
			minorX = floor2.x;
			maxX = floor1.x;
		}
	}

	public function isChild(object:FlxObject):Bool {	
		for (member in this.members) {
			if(object == member) return true;
		}
		return false;
	}

	public function moveFloor():Void {	
		if(currentFloor != null) {
			var relativePlayerX:Float = player.x - maxX;
			var nextFloor:FlxSprite;

			if(floor1.x == minorX) nextFloor = floor1;
			else nextFloor = floor2;

			if(relativePlayerX > currentFloor.width/2) nextFloor.x = currentFloor.x + currentFloor.width;	
		}
	}

	public function updateFloors(player:FlxObject,floor:FlxObject):Void {	
		if(floor.x == maxX) currentFloor = floor;
	}
}