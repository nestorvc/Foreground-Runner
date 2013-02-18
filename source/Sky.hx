package ;
import nme.Assets;
import org.flixel.FlxTilemap;
import org.flixel.FlxG;
import org.flixel.FlxObject;

/**
 * ...
 * @author Nestor
 */

class Sky extends FlxTilemap
{
	
	public function new(x:Float, y:Float) 
	{
		super();
		this.x = x;
		this.y = y;
		loadMap(Assets.getText("assets/sky.csv"),"assets/backdrop.png", 192, 336);
		setTileProperties(1, FlxObject.NONE);
		scrollFactor.x = 0.1;
	}

	override public function update():Void 
	{
		super.update();
	}
}