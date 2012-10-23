/**
 * @author idanilov
 *
 */
public class PoolNum {

	//Must we draw it. If not- other fields are not important
	boolean draw;

	// Number (may be negative)
	public int n;

	//Position
	public int x;
	public int y;

	int up;
	int down;
	int left;
	int right;

	int color;

	public PoolNum() {
		draw = false;
		x = 0;
		y = 0;
		up = -1;
		down = -1;
		left = -1;
		right = -1;
		n = 0;
		color = 0x000000;
	}

	public void setOff() {
		draw = false;
	}

	public void set(boolean _draw, int _x, int _y, int _up, int _down, int _left, int _right,
			int _n, int _color) {
		draw = _draw;
		x = _x;
		y = _y;
		up = _up;
		down = _down;
		left = _left;
		right = _right;
		n = _n;
		color = _color;
	}

}
