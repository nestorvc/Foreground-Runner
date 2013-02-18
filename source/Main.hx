package;

import nme.display.StageAlign;
import nme.display.StageScaleMode;
import nme.display.Sprite;
import nme.events.Event;
import nme.events.KeyboardEvent;
import nme.Lib;
import nme.ui.Keyboard;
import org.flixel.FlxGame;
import com.testflightapp.TestFlight;

class Main extends Sprite 
{
	
	public function new () 
	{
		super();
		
		if (stage != null) 
			init();
		else 
			addEventListener(Event.ADDED_TO_STAGE, init);
	}
	
	private function init(?e:Event = null):Void 
	{
		TestFlight.takeOff("f7dce3e10fde0015a85c8c58feed4c27_MTg0ODc0MjAxMy0wMi0wNyAyMToxNzo1NS40Mzg2MzQ");
		TestFlight.passCheckpoint("Open game");
		TestFlight.remoteLog("LOG: Game was opened");
		
		if (hasEventListener(Event.ADDED_TO_STAGE))
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		initialize();
		
		var demo:FlxGame = new ProjectClass();
		addChild(demo);
		
		#if (cpp || neko)
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUP);
		#end
	}
	
	#if (cpp || neko)
	private function onKeyUP(e:KeyboardEvent):Void 
	{
		if (e.keyCode == Keyboard.ESCAPE)
		{
			Lib.exit();
		}
	}
	#end
	
	private function initialize():Void 
	{
		Lib.current.stage.align = StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
	}
	
	// Entry point
	public static function main() {
		
		Lib.current.addChild(new Main());
	}
	
}