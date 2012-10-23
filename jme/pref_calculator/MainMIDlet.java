import javax.microedition.midlet.MIDlet;
import javax.microedition.lcdui.Display;

/**
 * @author idanilov
 */
public class MainMIDlet extends MIDlet {

	private PoolCanvas canvas;

	public MainMIDlet() {
		canvas = new PoolCanvas(this);
		canvas.setFullScreenMode(true);//MIDP2.0:
	}

	public void startApp() {
		Display.getDisplay(this).setCurrent(canvas);
	}

	public void pauseApp() {
	}

	public void destroyApp(boolean unc) {
	}

	public void exitMIDlet(boolean unc) {
		destroyApp(unc);
		notifyDestroyed();
	}

}
