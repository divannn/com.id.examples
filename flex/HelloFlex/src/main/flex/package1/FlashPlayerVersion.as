package package1 {
import flash.system.Capabilities;

public class FlashPlayerVersion {
	/* static block */
	{
		trace("Initialising class FlashPlayerVersion");

		static var versionData:Array = Capabilities.version.split(" ");

		platform = versionData[0]; // "WIN", "MAC", "UNIX", etc.

		versionData = versionData[1].split(",");

		majorVersion = int(versionData[0]);
		minorVersion = int(versionData[1]);
		buildNumber = int(versionData[2]);
		internalBuildNumber = int(versionData[3]);

		isDebug = Capabilities.isDebugger;
	}

	public static var platform:String;

	public static var majorVersion:int;
	public static var minorVersion:int;
	public static var buildNumber:int;
	public static var internalBuildNumber:int;

	public static var isDebug:Boolean;

	public static function get fpVersion():String {
		//return platform + " " + majorVersion + "." + minorVersion + " build number " + buildNumber + " isDebug: " + isDebug;
		return Capabilities.version + " isDebug: " + Capabilities.isDebugger;
	}
}
}