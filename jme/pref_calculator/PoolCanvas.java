import javax.microedition.lcdui.Canvas;
import javax.microedition.lcdui.Choice;
import javax.microedition.lcdui.ChoiceGroup;
import javax.microedition.lcdui.Command;
import javax.microedition.lcdui.CommandListener;
import javax.microedition.lcdui.Display;
import javax.microedition.lcdui.Displayable;
import javax.microedition.lcdui.Font;
import javax.microedition.lcdui.Form;
import javax.microedition.lcdui.Graphics;
import javax.microedition.lcdui.TextField;
import javax.microedition.midlet.MIDlet;

/**
 * @author idanilov
 *
 */
public class PoolCanvas extends Canvas
		implements CommandListener {

	public MainMIDlet m_MIDlet;
	public Display m_Display;

	public static final int P_NORTH = 0;
	public static final int P_SOUTH = 1;
	public static final int P_WEST = 2;
	public static final int P_EAST = 3;

	public int m_iColorNames;
	public int m_iColorScore;

	public Font m_FontNames;
	public Font m_FontScore;
	public Font m_FontNums;

	// NOTE: Order of players is N, S, W, E (look up)
	public PlayerScore m_PScores[] = new PlayerScore[4];

	// ALL RECORDS on the Pool
	public PoolNum m_PNum[] = new PoolNum[20];

	// Active PoolNum, -1 == none active
	public int m_iActive;

	public int m_iNamesH;
	public int m_iScoreH;

	public static final int MAX_NUMBER = 9999;

	// True till first call of paint()
	private boolean bPaintFirstTime = true;

	// ------------------------------------------------------------------------
	public static final  int LANG_ENG = 0;
	public static final int LANG_RUS = 1;

	public int m_iLang; // Language

	// ------------------------------------------------------------------------
	public static final int THREE_MEN = 0;
	public static final int FOUR_MEN = 1;

	public static final int LENINGRAD = 0;
	public static final int SOCHI = 1;
	public static final int ROSTOV = 2;

	public int m_iType; // How many people playes the game, no it's only 3
	public int m_iGame; // What type of game- leningradka, rostovka, sochinka

	// ------------------------------------------------------------------------
	private Command cmdOpts;
	private Command cmdHelp;
	private Command cmdRules;
	private Command cmdAbout;
	private Command cmdExit;

	private Form FormAbout;
	private Command cmdAboutOk;

	private Form FormHelp;
	private Command cmdHelpOk;

	private Form FormRules;
	private Command cmdRulesOk;

	private Form FormOpts;
	private Command cmdOptsOk;

	private ChoiceGroup cgType;
	private ChoiceGroup cgGame;
	private ChoiceGroup cgLang;

	// I may use array, but decided not to.
	private TextField tfSouth;
	private TextField tfWest;
	private TextField tfEast;
	private TextField tfNorth;

	// ------------------------------------------------------------------------

	public PoolCanvas(MIDlet midlet) {
		// TODO:!! check screen size is enough

		m_MIDlet = (MainMIDlet) midlet;
		m_Display = Display.getDisplay(m_MIDlet);

		// set up the listener
		setCommandListener(this);

		m_iLang = LANG_RUS; // by Sean
		m_iType = THREE_MEN; // by Sean
		m_iGame = SOCHI; // by Sean

		// Names section -------------------
		m_PScores[P_NORTH] = new PlayerScore("North");
		m_PScores[P_SOUTH] = new PlayerScore("South");
		m_PScores[P_WEST] = new PlayerScore("West");
		m_PScores[P_EAST] = new PlayerScore("East");

		// Fonts and colors ----------------
		m_iColorNames = 0xFF0000;
		m_iColorScore = 0x0000FF;

		for (int i = 0; i < 20; i++) {
			m_PNum[i] = new PoolNum();
                }

		m_iActive = 5; // South's pool is active at the begining

		// Making GUI and menus -----------------------------------
		MenuMakeAll();
	}

	public void commandAction(Command c, Displayable d) {
		if (c == cmdExit) {
			m_MIDlet.exitMIDlet(true);
		} else if (c == cmdOpts) {
			m_Display.setCurrent(FormOpts);
			FormOpts.setCommandListener(this);
		} else if (c == cmdOptsOk) {
			m_PScores[P_SOUTH].playerName = tfSouth.getString();
			m_PScores[P_WEST].playerName = tfWest.getString();
			m_PScores[P_EAST].playerName = tfEast.getString();
			m_PScores[P_NORTH].playerName = tfNorth.getString();

			boolean bTypeChanged = false;
			if (m_iType != cgType.getSelectedIndex()) {
				m_iType = cgType.getSelectedIndex();
				bTypeChanged = true;
			}

			boolean bLangChanged = false;
			if (m_iLang != cgLang.getSelectedIndex()) {
				m_iLang = cgLang.getSelectedIndex();
				bLangChanged = true;
			}

			boolean bGameChanged = false;
			if (m_iGame != cgGame.getSelectedIndex()) {
				m_iGame = cgGame.getSelectedIndex();
				bGameChanged = true;
			}

			m_Display.setCurrent(this);

			if (bTypeChanged) {
				m_iActive = 5; // South's pool is active
				initGraphics();
				CountScores();
			}
			if (bGameChanged) {
				CountScores();
			}

			if (bLangChanged) {
				MenuApplyLanguage();
			}
			repaint();
		} else if (c == cmdAbout) {
			m_Display.setCurrent(FormAbout);
			FormAbout.setCommandListener(this);
		} else if (c == cmdAboutOk) {
			m_Display.setCurrent(this);
		}
		if (c == cmdHelp) {
			m_Display.setCurrent(FormHelp);
			FormHelp.setCommandListener(this);
		} else if (c == cmdHelpOk) {
			m_Display.setCurrent(this);
		} else if (c == cmdRules) {
			m_Display.setCurrent(FormRules);
			FormRules.setCommandListener(this);
		} else if (c == cmdRulesOk) {
			m_Display.setCurrent(this);
		}
	}

	public void paint(Graphics g) {
		// Because getWidth() get right result only after painting and not in costructor when using MIDP2's setFullScreenMode()
		if (bPaintFirstTime) {
			initGraphics();
			bPaintFirstTime = false;
		}

		g.setColor(0xFFFFFF);
		g.fillRect(0, 0, getWidth(), getHeight());

		drawAll(g, 0, 0, getWidth(), getHeight());
	}

	private void initGraphics() {
		m_FontNames = Font.getFont(Font.FACE_SYSTEM, Font.STYLE_PLAIN, Font.SIZE_SMALL);
		m_FontScore = Font.getFont(Font.FACE_SYSTEM, Font.STYLE_PLAIN, Font.SIZE_SMALL);
		m_FontNums = Font.getFont(Font.FACE_SYSTEM, Font.STYLE_PLAIN, Font.SIZE_SMALL);

		m_iNamesH = m_FontNames.getHeight();
		m_iScoreH = m_FontScore.getHeight();

		// Because getWidth() get right result only after painting and not in costructor when using MIDP2's setFullScreenMode()
		FillNumbersOfPool(0, m_iScoreH, getWidth(), getHeight() - m_iNamesH - m_iScoreH);
	}

	public void keyPressed(int code) {
		switch (code) {
			case Canvas.KEY_NUM0:
				AddNumToActive(0);
				break;
			case Canvas.KEY_NUM1:
				AddNumToActive(1);
				break;
			case Canvas.KEY_NUM2:
				AddNumToActive(2);
				break;
			case Canvas.KEY_NUM3:
				AddNumToActive(3);
				break;
			case Canvas.KEY_NUM4:
				AddNumToActive(4);
				break;
			case Canvas.KEY_NUM5:
				AddNumToActive(5);
				break;
			case Canvas.KEY_NUM6:
				AddNumToActive(6);
				break;
			case Canvas.KEY_NUM7:
				AddNumToActive(7);
				break;
			case Canvas.KEY_NUM8:
				AddNumToActive(8);
				break;
			case Canvas.KEY_NUM9:
				AddNumToActive(9);
				break;
			case Canvas.KEY_STAR:
				DeleteNumFromActive();
				break;
			case Canvas.KEY_POUND:
				ChangeSignOfActive();
				break;
			default: // Here other codes supported by GameAction
				int key = getGameAction(code);
				switch (key) {
					case Canvas.UP:
						if (m_iActive != -1) {
							if (m_PNum[m_iActive].up != -1)
								m_iActive = m_PNum[m_iActive].up;
						}
						repaint();
						break;
					case Canvas.DOWN:
						if (m_iActive != -1) {
							if (m_PNum[m_iActive].down != -1)
								m_iActive = m_PNum[m_iActive].down;
						}
						repaint();
						break;
					case Canvas.LEFT:
						if (m_iActive != -1) {
							if (m_PNum[m_iActive].left != -1)
								m_iActive = m_PNum[m_iActive].left;
						}
						repaint();
						break;
					case Canvas.RIGHT:
						if (m_iActive != -1) {
							if (m_PNum[m_iActive].right != -1)
								m_iActive = m_PNum[m_iActive].right;
						}
						repaint();
						break;
					case Canvas.FIRE:
						//						m_MIDlet.exitMIDlet(true);
						break;
					default:
						break;
				}
				break;
		}
	}

	public void drawAll(Graphics g, int x, int y, int w, int h) {
		drawPool(g, x, y + m_iScoreH, w, h - m_iNamesH - m_iScoreH);

		drawScoresAndNames(g, x, y, w, h);

		DrawNumbersOfPool(g);
	}

	public void drawPool(Graphics g, int x, int y, int w, int h) {
		if (m_iType == THREE_MEN) {
			g.setColor(0x000000);

			// Drawing main lines -------
			g.drawLine(x, y + h, x + w / 2, y + h / 2);
			g.drawLine(x + w, y + h, x + w / 2, y + h / 2);
			g.drawLine(x + w / 2, y, x + w / 2, y + h / 2);
			// Drawing west player -------
			g.drawLine(x + w / 6, y, x + w / 6, y + h - w * h / 6 / w); // TRICK: Some strange order w*w/6/h  division in the end for not to loose digits
			g.drawLine(x + w / 3, y, x + w / 3, y + h - w * h / 3 / w);
			g.drawLine(x, y + h / 2, x + w / 6, y + h / 2);
			// Drawing east player -------
			g.drawLine(x + w * 4 / 6, y, x + w * 4 / 6, y + h - h / 3); // TRICK: the trick the same as upper
			g.drawLine(x + w * 5 / 6, y, x + w * 5 / 6, y + h - h / 6);
			g.drawLine(x + w * 5 / 6, y + h / 2, x + w, y + h / 2);
			// Drawing south player -------
			g.drawLine(x + w / 6, y + h - h / 6, x + w * 5 / 6, y + h - h / 6);
			g.drawLine(x + w / 3, y + h - h / 3, x + w * 4 / 6, y + h - h / 3);
			g.drawLine(x + w / 2, y + h - h / 6, x + w / 2, y + h);
		} else if (m_iType == FOUR_MEN) {
			g.setColor(0x000000);

			// Drawing main lines -------
			g.drawLine(x, y + h, x + w / 2, y + h / 2);
			g.drawLine(x + w, y + h, x + w / 2, y + h / 2);
			g.drawLine(x, y, x + w / 2, y + h / 2);
			g.drawLine(x + w, y, x + w / 2, y + h / 2);
			// Drawing west player -------
			g.drawLine(x + w / 6, y + h / 6, x + w / 6, y + h - h / 6);
			g.drawLine(x + w / 3, y + h / 3, x + w / 3, y + h - h / 3);
			g.drawLine(x, y + h * 1 / 3, x + w / 6, y + h * 1 / 3);
			g.drawLine(x, y + h * 2 / 3, x + w / 6, y + h * 2 / 3);
			// Drawing east player -------
			g.drawLine(x + w * 4 / 6, y + w * h / 3 / w, x + w * 4 / 6, y + h - w * h / 3 / w);
			g.drawLine(x + w * 5 / 6, y + w * h / 6 / w, x + w * 5 / 6, y + h - w * h / 6 / w);
			g.drawLine(x + w * 5 / 6, y + h * 1 / 3, x + w, y + h * 1 / 3);
			g.drawLine(x + w * 5 / 6, y + h * 2 / 3, x + w, y + h * 2 / 3);
			// Drawing south player -------
			g.drawLine(x + w / 6, y + h - h / 6, x + w * 5 / 6, y + h - h / 6);
			g.drawLine(x + w / 3, y + h - h / 3, x + w * 4 / 6, y + h - h / 3);
			g.drawLine(x + w * 1 / 3, y + h - h / 6, x + w * 1 / 3, y + h);
			g.drawLine(x + w * 2 / 3, y + h - h / 6, x + w * 2 / 3, y + h);
			// Drawing north player -------
			g.drawLine(x + w / 6, y + h / 6, x + w * 5 / 6, y + h / 6);
			g.drawLine(x + w / 3, y + h / 3, x + w * 4 / 6, y + h / 3);
			g.drawLine(x + w * 1 / 3, y + h / 6, x + w * 1 / 3, y);
			g.drawLine(x + w * 2 / 3, y + h / 6, x + w * 2 / 3, y);
		}
	}

	public void drawScoresAndNames(Graphics g, int x, int y, int w, int h) {
		if (m_iType == THREE_MEN) {
			// Printing player's names (only 3 from array) ---------------------------
			g.setFont(m_FontNames);
			g.setColor(m_iColorNames);
			g.drawString(m_PScores[P_WEST].playerName, x + 2, y + h
					- (m_iNamesH - m_FontNames.getHeight()) / 2, g.BOTTOM | g.LEFT);
			g.drawString(m_PScores[P_EAST].playerName, x + w - 2, y + h
					- (m_iNamesH - m_FontNames.getHeight()) / 2, g.BOTTOM | g.RIGHT);
			g.drawString(m_PScores[P_SOUTH].playerName, x + w / 2, y + h
					- (m_iNamesH - m_FontNames.getHeight()) / 2, g.BOTTOM | g.HCENTER);

			// Printing player's scores (only 3 from array) ---------------------------
			g.setFont(m_FontScore);
			g.setColor(m_iColorScore);
			g.drawString("" + m_PScores[P_WEST].score, x + 2, y
					+ (m_iScoreH + m_FontScore.getHeight()) / 2, g.BOTTOM | g.LEFT);
			g.drawString("" + m_PScores[P_EAST].score, x + w - 2, y
					+ (m_iScoreH + m_FontScore.getHeight()) / 2, g.BOTTOM | g.RIGHT);
			g.drawString("" + m_PScores[P_SOUTH].score, x + w / 2, y
					+ (m_iScoreH + m_FontScore.getHeight()) / 2, g.BOTTOM | g.HCENTER);
		} else if (m_iType == FOUR_MEN) {
			// Printing player's names -----------------------------------------------
			g.setFont(m_FontNames);
			g.setColor(m_iColorNames);
			g.drawString(m_PScores[P_WEST].playerName, x + 2, y + h
					- (m_iNamesH - m_FontNames.getHeight()) / 2, g.BOTTOM | g.LEFT);
			g.drawString(m_PScores[P_EAST].playerName, x + w - 2, y + h
					- (m_iNamesH - m_FontNames.getHeight()) / 2, g.BOTTOM | g.RIGHT);
			g.drawString(m_PScores[P_NORTH].playerName, x + w / 4, y + h
					- (m_iNamesH - m_FontNames.getHeight()) / 2, g.BOTTOM | g.LEFT);
			g.drawString(m_PScores[P_SOUTH].playerName, x + w * 3 / 4, y + h
					- (m_iNamesH - m_FontNames.getHeight()) / 2, g.BOTTOM | g.RIGHT);

			// Printing player's scores (only 3 from array) ---------------------------
			g.setFont(m_FontScore);
			g.setColor(m_iColorScore);
			g.drawString("" + m_PScores[P_WEST].score, x + 2, y
					+ (m_iScoreH + m_FontScore.getHeight()) / 2, g.BOTTOM | g.LEFT);
			g.drawString("" + m_PScores[P_EAST].score, x + w - 2, y
					+ (m_iScoreH + m_FontScore.getHeight()) / 2, g.BOTTOM | g.RIGHT);
			g.drawString("" + m_PScores[P_NORTH].score, x + w / 4, y
					+ (m_iScoreH + m_FontScore.getHeight()) / 2, g.BOTTOM | g.LEFT);
			g.drawString("" + m_PScores[P_SOUTH].score, x + w * 3 / 4, y
					+ (m_iScoreH + m_FontScore.getHeight()) / 2, g.BOTTOM | g.RIGHT);
		}

	}

	public void FillNumbersOfPool(int x, int y, int w, int h) {
		//Note somewhere for more goodlooking is used:
		//Horizontal and Vertical steps (very little)
		int hs = w * 1 / 24;
		int vs = h * 1 / 24;
		// I use these steps for more pomfortable-looking places of labels
		if (m_iType == THREE_MEN) {
			// Make for North fist. There is no such player, so it's easy: ---------------
			m_PNum[0].setOff(); // pool
			m_PNum[1].setOff(); // gora
			m_PNum[2].setOff(); // whist on E
			m_PNum[3].setOff(); // whist on S
			m_PNum[4].setOff(); // whist on W
			// Make for South: -----------------------------------------------------------
			m_PNum[5].set(true, x + w / 2, y + h - 5 * h / 12 + vs / 2, -1, 6, 10, 15, 0, 0xC80000);
			m_PNum[6].set(true, x + w / 2, y + h - 3 * h / 12, 5, 7, 11, 16, 0, 0x00C800);
			m_PNum[7].set(true, x + w / 4 + hs, y + h - 1 * h / 12, 6, -1, 14, 9, 0, 0x000000);
			m_PNum[8].setOff();
			m_PNum[9].set(true, x + w * 3 / 4 - hs, y + h - 1 * h / 12, 6, -1, 7, 17, 0, 0x000000);
			// Make for West: -----------------------------------------------------------
			m_PNum[10].set(true, x + w * 5 / 12, y + h / 2 - vs * 2, -1, 5, 11, 15, 0, 0xC80000);
			m_PNum[11].set(true, x + w * 3 / 12, y + h / 2, -1, 6, 13, 10, 0, 0x00C800);
			m_PNum[12].setOff();
			m_PNum[13].set(true, x + w / 12, y + h / 4 + vs, -1, 14, -1, 11, 0, 0x000000);
			m_PNum[14].set(true, x + w / 12, y + h * 3 / 4 - vs, 13, 7, -1, 11, 0, 0x000000);
			// Make for East: -----------------------------------------------------------
			m_PNum[15].set(true, x + w * 7 / 12, y + h / 2 - vs * 2, -1, 5, 10, 16, 0, 0xC80000);
			m_PNum[16].set(true, x + w * 9 / 12, y + h / 2, -1, 6, 15, 18, 0, 0x00C800);
			m_PNum[17].set(true, x + w * 11 / 12, y + h * 3 / 4 - vs, 18, 9, 16, -1, 0, 0x000000);
			m_PNum[18].set(true, x + w * 11 / 12, y + h / 4 + vs, -1, 17, 16, -1, 0, 0x000000);
			m_PNum[19].setOff();
			// --------------------------------------------------------------------------
		} else if (m_iType == FOUR_MEN) {
			// Make for North fist. There is no such player, so it's easy: ---------------
			m_PNum[0].set(true, x + w / 2, y + 5 * h / 12 - vs * 3 / 5, 1, 5, 10, 15, 0, 0xC80000);
			m_PNum[1].set(true, x + w / 2, y + 3 * h / 12, 3, 0, 11, 16, 0, 0x00C800);
			m_PNum[2].set(true, x + w * 5 / 6 - hs, y + 1 * h / 12, -1, 1, 3, 19, 0, 0x000000);
			m_PNum[3].set(true, x + w * 3 / 6, y + 1 * h / 12, -1, 1, 4, 2, 0, 0x000000);
			m_PNum[4].set(true, x + w * 1 / 6 + hs, y + 1 * h / 12, -1, 1, 12, 3, 0, 0x000000);
			// Make for South: -----------------------------------------------------------
			m_PNum[5].set(true, x + w / 2, y + h - 5 * h / 12 + vs * 3 / 5, 0, 6, 10, 15, 0,
					0xC80000);
			m_PNum[6].set(true, x + w / 2, y + h - 3 * h / 12, 5, 8, 11, 16, 0, 0x00C800);
			m_PNum[7].set(true, x + w * 1 / 6 + hs, y + h - 1 * h / 12, 6, -1, 14, 8, 0, 0x000000);
			m_PNum[8].set(true, x + w * 3 / 6, y + h - 1 * h / 12, 6, -1, 7, 9, 0, 0x000000);
			m_PNum[9].set(true, x + w * 5 / 6 - hs, y + h - 1 * h / 12, 6, -1, 18, 17, 0, 0x000000);
			// Make for West: -----------------------------------------------------------
			m_PNum[10].set(true, x + w * 5 / 12 - hs / 2, y + h / 2, 0, 5, 11, 15, 0, 0xC80000);
			m_PNum[11].set(true, x + w * 3 / 12, y + h / 2, 1, 6, 13, 10, 0, 0x00C800);
			m_PNum[12].set(true, x + w / 12, y + h * 1 / 6 + vs, 4, 13, -1, 11, 0, 0x000000);
			m_PNum[13].set(true, x + w / 12, y + h * 3 / 6, 12, 14, -1, 11, 0, 0x000000);
			m_PNum[14].set(true, x + w / 12, y + h * 5 / 6 - vs, 13, 7, -1, 11, 0, 0x000000);
			// Make for East: -----------------------------------------------------------
			m_PNum[15].set(true, x + w * 7 / 12 + hs / 2, y + h / 2, 0, 5, 10, 16, 0, 0xC80000);
			m_PNum[16].set(true, x + w * 9 / 12, y + h / 2, 1, 6, 15, 18, 0, 0x00C800);
			m_PNum[17].set(true, x + w * 11 / 12, y + h * 5 / 6 - vs, 18, 9, 16, -1, 0, 0x000000);
			m_PNum[18].set(true, x + w * 11 / 12, y + h * 3 / 6, 19, 17, 16, -1, 0, 0x000000);
			m_PNum[19].set(true, x + w * 11 / 12, y + h * 1 / 6 + vs, 2, 18, 16, -1, 0, 0x000000);
			// --------------------------------------------------------------------------
		}
	}

	private void DrawNumbersOfPool(Graphics g) {
		for (int i = 0; i < 20; i++) {
			if (m_PNum[i].draw) {
				g.setFont(m_FontNums);
				g.setColor(m_PNum[i].color);
				g.drawString("" + m_PNum[i].n, m_PNum[i].x, m_PNum[i].y - m_FontNums.getHeight()
						/ 2, g.TOP | g.HCENTER);

			}
		}
		if (m_iActive != -1) {
			g.setColor(0x000088);
			g.drawRoundRect(m_PNum[m_iActive].x - m_FontNums.stringWidth("" + m_PNum[m_iActive].n)
					/ 2 - 4, m_PNum[m_iActive].y - m_FontNums.getHeight() / 2 - 2, m_FontNums
					.stringWidth("" + m_PNum[m_iActive].n) + 6, m_FontNums.getHeight() + 2,
					m_FontNums.getHeight() * 2 / 3, m_FontNums.getHeight() * 2 / 3);
		}

	}

	public void AddNumToActive(int i) {
		if (m_iActive != -1) {
			if (Math.abs(m_PNum[m_iActive].n * 10 + SignOfInt(m_PNum[m_iActive].n) * i) <= MAX_NUMBER)
				m_PNum[m_iActive].n = m_PNum[m_iActive].n * 10 + SignOfInt(m_PNum[m_iActive].n) * i;
		}
		UpdateAll();
	}

	public void DeleteNumFromActive() {
		if (m_iActive != -1) {
			m_PNum[m_iActive].n = m_PNum[m_iActive].n / 10; // integer devision
		}
		UpdateAll();
	}

	public void ChangeSignOfActive() {
		if (m_iActive != -1) {
			m_PNum[m_iActive].n = -m_PNum[m_iActive].n;
		}
		UpdateAll();
	}

	// NOTE: Only 1 or -1. Never 0!
	public int SignOfInt(int i) {
		if (i >= 0)
			return 1;
		else
			return -1;
	}

	public void UpdateAll() {
		CountScores();
		repaint();
	}

	public void CountScores() {
		if (m_iType == THREE_MEN) {
			// We use int devision because CLDC1.0 do not allow double/float
			if (m_iGame == LENINGRAD) {
				// Counting in Leningradka
				// Counting for South: -------------------------------------------------------
				m_PScores[P_SOUTH].score = m_PNum[7].n
						+ m_PNum[9].n
						- m_PNum[14].n
						- m_PNum[17].n // Whist his and on him
						+ (-(m_PNum[5].n - 2 * m_PNum[6].n) * 20
								+ (m_PNum[10].n - 2 * m_PNum[11].n) * 10 + (m_PNum[15].n - 2 * m_PNum[16].n) * 10)
						/ 3; // His gora and on him
				// Counting for West: --------------------------------------------------------
				m_PScores[P_WEST].score = m_PNum[13].n
						+ m_PNum[14].n
						- m_PNum[7].n
						- m_PNum[18].n
						+ (+(m_PNum[5].n - 2 * m_PNum[6].n) * 10
								- (m_PNum[10].n - 2 * m_PNum[11].n) * 20 + (m_PNum[15].n - 2 * m_PNum[16].n) * 10)
						/ 3;
				// Counting for East: --------------------------------------------------------
				m_PScores[P_EAST].score = m_PNum[17].n
						+ m_PNum[18].n
						- m_PNum[9].n
						- m_PNum[13].n
						+ (+(m_PNum[5].n - 2 * m_PNum[6].n) * 10
								+ (m_PNum[10].n - 2 * m_PNum[11].n) * 10 - (m_PNum[15].n - 2 * m_PNum[16].n) * 20)
						/ 3;
			} else if (m_iGame == ROSTOV || m_iGame == SOCHI) {
				// Counting for South: -------------------------------------------------------
				m_PScores[P_SOUTH].score = m_PNum[7].n
						+ m_PNum[9].n
						- m_PNum[14].n
						- m_PNum[17].n // Whist his and on him
						+ (-(m_PNum[5].n - m_PNum[6].n) * 20 + (m_PNum[10].n - m_PNum[11].n) * 10 + (m_PNum[15].n - m_PNum[16].n) * 10)
						/ 3; // His gora and on him
				// Counting for West: --------------------------------------------------------
				m_PScores[P_WEST].score = m_PNum[13].n
						+ m_PNum[14].n
						- m_PNum[7].n
						- m_PNum[18].n
						+ (+(m_PNum[5].n - m_PNum[6].n) * 10 - (m_PNum[10].n - m_PNum[11].n) * 20 + (m_PNum[15].n - m_PNum[16].n) * 10)
						/ 3;
				// Counting for East: --------------------------------------------------------
				m_PScores[P_EAST].score = m_PNum[17].n
						+ m_PNum[18].n
						- m_PNum[9].n
						- m_PNum[13].n
						+ (+(m_PNum[5].n - m_PNum[6].n) * 10 + (m_PNum[10].n - m_PNum[11].n) * 10 - (m_PNum[15].n - m_PNum[16].n) * 20)
						/ 3;
			}
			// ------------------------------------------------------------------------------------------------
			// Then making the summary ==0. We use way that winner may get one whits less or looser may loose one whist less.
			// One whist- is very little correction for pool good looking ))
			// Variants need this: 0.6 0.6 -1.3 and -1.0 0.6 0.3 (+ two the same but all values negative)
			if (m_PScores[P_SOUTH].score + m_PScores[P_WEST].score + m_PScores[P_EAST].score == 1) {
				// Decrease prize of winner
				if (m_PScores[P_SOUTH].score >= m_PScores[P_EAST].score
						&& m_PScores[P_SOUTH].score >= m_PScores[P_WEST].score)
					m_PScores[P_SOUTH].score--;
				else if (m_PScores[P_WEST].score >= m_PScores[P_EAST].score
						&& m_PScores[P_WEST].score >= m_PScores[P_SOUTH].score)
					m_PScores[P_WEST].score--;
				else
					m_PScores[P_EAST].score--;
			} else if (m_PScores[P_SOUTH].score + m_PScores[P_WEST].score + m_PScores[P_EAST].score == -1) {
				// Increase loss of looser
				if (m_PScores[P_SOUTH].score <= m_PScores[P_EAST].score
						&& m_PScores[P_SOUTH].score <= m_PScores[P_WEST].score)
					m_PScores[P_SOUTH].score++;
				else if (m_PScores[P_WEST].score <= m_PScores[P_EAST].score
						&& m_PScores[P_WEST].score <= m_PScores[P_SOUTH].score)
					m_PScores[P_WEST].score++;
				else
					m_PScores[P_EAST].score++;
			}
			// ------------------------------------------------------------------------------------------------

		} else if (m_iType == FOUR_MEN) {
			// We use int devision because CLDC1.0 do not allow double/float

			if (m_iGame == LENINGRAD) {
				// Counting in Leningradka
				// Counting for South: -------------------------------------------------------
				m_PScores[P_SOUTH].score = m_PNum[7].n
						+ m_PNum[8].n
						+ m_PNum[9].n
						- m_PNum[14].n
						- m_PNum[3].n
						- m_PNum[17].n // Whist his and on him
						+ (-(m_PNum[5].n - 2 * m_PNum[6].n) * 30 + (m_PNum[0].n - 2 * m_PNum[1].n)
								* 10 + (m_PNum[10].n - 2 * m_PNum[11].n) * 10 + (m_PNum[15].n - 2 * m_PNum[16].n) * 10)
						/ 4; // His gora and on him
				// Counting for West: -------------------------------------------------------
				m_PScores[P_WEST].score = m_PNum[12].n
						+ m_PNum[13].n
						+ m_PNum[14].n
						- m_PNum[4].n
						- m_PNum[7].n
						- m_PNum[18].n // Whist his and on him
						+ (-(m_PNum[10].n - 2 * m_PNum[11].n) * 30
								+ (m_PNum[0].n - 2 * m_PNum[1].n) * 10
								+ (m_PNum[5].n - 2 * m_PNum[6].n) * 10 + (m_PNum[15].n - 2 * m_PNum[16].n) * 10)
						/ 4; // His gora and on him
				// Counting for East: -------------------------------------------------------
				m_PScores[P_EAST].score = m_PNum[17].n
						+ m_PNum[18].n
						+ m_PNum[19].n
						- m_PNum[2].n
						- m_PNum[13].n
						- m_PNum[9].n // Whist his and on him
						+ (-(m_PNum[15].n - 2 * m_PNum[16].n) * 30
								+ (m_PNum[0].n - 2 * m_PNum[1].n) * 10
								+ (m_PNum[10].n - 2 * m_PNum[11].n) * 10 + (m_PNum[5].n - 2 * m_PNum[6].n) * 10)
						/ 4; // His gora and on him
				// Counting for North: -------------------------------------------------------
				m_PScores[P_NORTH].score = m_PNum[2].n
						+ m_PNum[3].n
						+ m_PNum[4].n
						- m_PNum[12].n
						- m_PNum[8].n
						- m_PNum[19].n // Whist his and on him
						+ (-(m_PNum[0].n - 2 * m_PNum[1].n) * 30 + (m_PNum[5].n - 2 * m_PNum[6].n)
								* 10 + (m_PNum[10].n - 2 * m_PNum[11].n) * 10 + (m_PNum[15].n - 2 * m_PNum[16].n) * 10)
						/ 4; // His gora and on him
			} else if (m_iGame == ROSTOV || m_iGame == SOCHI) {
				// Counting in Sochi or Rostov
				// Counting for South: -------------------------------------------------------
				m_PScores[P_SOUTH].score = m_PNum[7].n
						+ m_PNum[8].n
						+ m_PNum[9].n
						- m_PNum[14].n
						- m_PNum[3].n
						- m_PNum[17].n // Whist his and on him
						+ (-(m_PNum[5].n - m_PNum[6].n) * 30 + (m_PNum[0].n - m_PNum[1].n) * 10
								+ (m_PNum[10].n - m_PNum[11].n) * 10 + (m_PNum[15].n - m_PNum[16].n) * 10)
						/ 4; // His gora and on him
				// Counting for West: -------------------------------------------------------
				m_PScores[P_WEST].score = m_PNum[12].n
						+ m_PNum[13].n
						+ m_PNum[14].n
						- m_PNum[4].n
						- m_PNum[7].n
						- m_PNum[18].n // Whist his and on him
						+ (-(m_PNum[10].n - m_PNum[11].n) * 30 + (m_PNum[0].n - m_PNum[1].n) * 10
								+ (m_PNum[5].n - m_PNum[6].n) * 10 + (m_PNum[15].n - m_PNum[16].n) * 10)
						/ 4; // His gora and on him
				// Counting for East: -------------------------------------------------------
				m_PScores[P_EAST].score = m_PNum[17].n
						+ m_PNum[18].n
						+ m_PNum[19].n
						- m_PNum[2].n
						- m_PNum[13].n
						- m_PNum[9].n // Whist his and on him
						+ (-(m_PNum[15].n - m_PNum[16].n) * 30 + (m_PNum[0].n - m_PNum[1].n) * 10
								+ (m_PNum[10].n - m_PNum[11].n) * 10 + (m_PNum[5].n - m_PNum[6].n) * 10)
						/ 4; // His gora and on him
				// Counting for North: -------------------------------------------------------
				m_PScores[P_NORTH].score = m_PNum[2].n
						+ m_PNum[3].n
						+ m_PNum[4].n
						- m_PNum[12].n
						- m_PNum[8].n
						- m_PNum[19].n // Whist his and on him
						+ (-(m_PNum[0].n - m_PNum[1].n) * 30 + (m_PNum[5].n - m_PNum[6].n) * 10
								+ (m_PNum[10].n - m_PNum[11].n) * 10 + (m_PNum[15].n - m_PNum[16].n) * 10)
						/ 4; // His gora and on him
			}
			// ------------------------------------------------------------------------------------------------

			// Then making the summary ==0. We use way that winner may get one whits less or looser may loose one whist less.
			// One whist- is very little correction for pool good looking ))

			if (m_PScores[P_SOUTH].score + m_PScores[P_WEST].score + m_PScores[P_EAST].score
					+ m_PScores[P_NORTH].score == 1) {
				// Decrease prize of winner
				if (m_PScores[P_NORTH].score >= m_PScores[P_EAST].score
						&& m_PScores[P_NORTH].score >= m_PScores[P_WEST].score
						&& m_PScores[P_NORTH].score >= m_PScores[P_SOUTH].score)
					m_PScores[P_NORTH].score--;
				else if (m_PScores[P_WEST].score >= m_PScores[P_EAST].score
						&& m_PScores[P_WEST].score >= m_PScores[P_SOUTH].score
						&& m_PScores[P_WEST].score >= m_PScores[P_NORTH].score)
					m_PScores[P_WEST].score--;
				else if (m_PScores[P_SOUTH].score >= m_PScores[P_EAST].score
						&& m_PScores[P_SOUTH].score >= m_PScores[P_WEST].score
						&& m_PScores[P_SOUTH].score >= m_PScores[P_NORTH].score)
					m_PScores[P_SOUTH].score--;
				else
					m_PScores[P_EAST].score--;
			} else if (m_PScores[P_SOUTH].score + m_PScores[P_WEST].score + m_PScores[P_EAST].score
					+ m_PScores[P_NORTH].score == 2) {
				// Decrease prize of winner
				if (m_PScores[P_NORTH].score >= m_PScores[P_EAST].score
						&& m_PScores[P_NORTH].score >= m_PScores[P_WEST].score
						&& m_PScores[P_NORTH].score >= m_PScores[P_SOUTH].score)
					m_PScores[P_NORTH].score -= 2;
				else if (m_PScores[P_WEST].score >= m_PScores[P_EAST].score
						&& m_PScores[P_WEST].score >= m_PScores[P_SOUTH].score
						&& m_PScores[P_WEST].score >= m_PScores[P_NORTH].score)
					m_PScores[P_WEST].score -= 2;
				else if (m_PScores[P_SOUTH].score >= m_PScores[P_EAST].score
						&& m_PScores[P_SOUTH].score >= m_PScores[P_WEST].score
						&& m_PScores[P_SOUTH].score >= m_PScores[P_NORTH].score)
					m_PScores[P_SOUTH].score -= 2;
				else
					m_PScores[P_EAST].score -= 2;
			} else if (m_PScores[P_SOUTH].score + m_PScores[P_WEST].score + m_PScores[P_EAST].score == -1) {
				// Increase loss of looser
				if (m_PScores[P_NORTH].score <= m_PScores[P_EAST].score
						&& m_PScores[P_NORTH].score <= m_PScores[P_WEST].score
						&& m_PScores[P_NORTH].score <= m_PScores[P_SOUTH].score)
					m_PScores[P_NORTH].score++;
				else if (m_PScores[P_WEST].score <= m_PScores[P_EAST].score
						&& m_PScores[P_WEST].score <= m_PScores[P_SOUTH].score
						&& m_PScores[P_WEST].score <= m_PScores[P_NORTH].score)
					m_PScores[P_WEST].score++;
				else if (m_PScores[P_SOUTH].score <= m_PScores[P_EAST].score
						&& m_PScores[P_SOUTH].score <= m_PScores[P_WEST].score
						&& m_PScores[P_SOUTH].score <= m_PScores[P_NORTH].score)
					m_PScores[P_SOUTH].score++;
				else
					m_PScores[P_EAST].score++;

			}
			// ------------------------------------------------------------------------------------------------

		}

	}

	public void MenuApplyLanguage() {
		MenuRemoveAll();
		MenuMakeAll();
	}

	public void MenuRemoveAll() {
		if (cmdOpts != null)
			removeCommand(cmdOpts);
		if (cmdHelp != null)
			removeCommand(cmdHelp);
		if (cmdRules != null)
			removeCommand(cmdRules);
		if (cmdAbout != null)
			removeCommand(cmdAbout);
		if (cmdExit != null)
			removeCommand(cmdExit);

		if (FormOpts != null) {
			if (cmdOptsOk != null) {
				FormOpts.removeCommand(cmdOptsOk);
				cmdOptsOk = null;
			}
			for (int i = 0; i < FormOpts.size(); i++)
				FormOpts.delete(i);
			FormOpts = null;
		}
		if (FormAbout != null) {
			if (cmdAboutOk != null) {
				FormAbout.removeCommand(cmdAboutOk);
				cmdAboutOk = null;
			}
			for (int i = 0; i < FormAbout.size(); i++)
				FormAbout.delete(i);
			FormAbout = null;
		}
		if (FormHelp != null) {
			if (cmdHelpOk != null) {
				FormHelp.removeCommand(cmdHelpOk);
				cmdHelpOk = null;
			}
			for (int i = 0; i < FormHelp.size(); i++)
				FormHelp.delete(i);
			FormHelp = null;
		}
		if (FormRules != null) {
			if (cmdRulesOk != null) {
				FormRules.removeCommand(cmdRulesOk);
				cmdRulesOk = null;
			}
			for (int i = 0; i < FormRules.size(); i++)
				FormRules.delete(i);
			FormRules = null;
		}
	}

	// Makes all menus in selected language
	public void MenuMakeAll() {
		if (m_iLang == LANG_ENG) {
			// Making GUI and menus -----------------------------------
			cmdOpts = new Command("Options", Command.SCREEN, 1);
			cmdHelp = new Command("Help", Command.SCREEN, 2);
			cmdRules = new Command("Rules", Command.SCREEN, 3);
			cmdAbout = new Command("About", Command.SCREEN, 4);
			cmdExit = new Command("Exit", Command.EXIT, 5);
			addCommand(cmdOpts);
			addCommand(cmdHelp);
			addCommand(cmdRules);
			addCommand(cmdAbout);
			addCommand(cmdExit);

			// Making Options screen ------------------------
			FormOpts = new Form("Options");
			cgType = new ChoiceGroup("Quantity of players", Choice.EXCLUSIVE);
			cgType.append("3 players", null);
			cgType.append("4 players", null);
			cgType.setSelectedIndex(m_iType, true);
			FormOpts.append(cgType);

			cgGame = new ChoiceGroup("Game variant", Choice.EXCLUSIVE);
			cgGame.append("Leningrad", null);
			cgGame.append("Sochi", null);
			cgGame.append("Rostov", null);
			cgGame.setSelectedIndex(m_iGame, true);
			FormOpts.append(cgGame);

			FormOpts.append("Names (S,W,E,N):");
			tfSouth = new TextField(null, m_PScores[P_SOUTH].playerName, 20, TextField.ANY);
			tfWest = new TextField(null, m_PScores[P_WEST].playerName, 20, TextField.ANY);
			tfEast = new TextField(null, m_PScores[P_EAST].playerName, 20, TextField.ANY);
			tfNorth = new TextField(null, m_PScores[P_NORTH].playerName, 20, TextField.ANY);
			FormOpts.append(tfSouth);
			FormOpts.append(tfWest);
			FormOpts.append(tfEast);
			FormOpts.append(tfNorth);

			cmdOptsOk = new Command("Ok", Command.OK, 1);
			FormOpts.addCommand(cmdOptsOk);

			cgLang = new ChoiceGroup("Language", Choice.EXCLUSIVE);
			cgLang.append("English", null);
			cgLang.append("Russian", null);
			cgLang.setSelectedIndex(m_iLang, true);
			FormOpts.append(cgLang);

			// Making About screen --------------------------
			FormAbout = new Form("About");
			FormAbout
					.append("PrefCounter 1.0\n\nAuthor: Zakhar Semenov\n\nEx-site company, 2006\n\nPlease report about bugs and wishes on\nitsbbox@gorodok.net"
							+ "\n\nThank You for using it.\n\nThe program is FREE and opensource.\nIt CAN NOT be sold.\nThe program is distributed AS IT IS.\nAuthor DOES NOT accounting for anything.\nIf You are not agree, please remove programm.\n");
			cmdAboutOk = new Command("Back", Command.OK, 1);
			FormAbout.addCommand(cmdAboutOk);

			// Making Help screen --------------------------
			FormHelp = new Form("Help");
			FormHelp
					.append("Hotkeys:\n\n*-backspace\n#-Turn sign\nUse joy to move\nUse Numbers to type values.\nAlso You should change options in menu.\n");
			cmdHelpOk = new Command("Back", Command.OK, 1);
			FormHelp.addCommand(cmdHelpOk);

			// Making Rules screen --------------------------
			FormRules = new Form("Rules");
			FormRules
					.append("Counting pool. Rules\n"
							+ "This text is base on Marriage for Windows rules. We recommend You to look full game rules there.\n\n"
							+ "Intro: For each player there is top part of pool - GORA, middle - POOL, and lower's 2 or 3 - WHISTs\n\n"
							+ "Leningradka variant.\n"
							+ "0)First You need to subtract double pool from GORA for each player. Then You won't use pool any more.\n"
							+ "1)Then You should do Amnesty - add some number(the same for each!) to each GORA to make one player's GORA equal to 0. It's not necessary but it's easier to count after.\n"
							+ "2)For each player take his GORA multiply on 10 and divide by quantity of players."
							+ "and add it to whist fields of his opponents(select part of whist field related to this player).\n"
							+ "4)Now total result of each player is sum of his whist on other's minus other's whist on him\n"
							+ "5)The total sum of result must be equal to 0. Check it.\n\n");
			cmdRulesOk = new Command("Back", Command.OK, 1);
			FormRules.addCommand(cmdRulesOk);
		} else if (m_iLang == LANG_RUS) {
			// Making GUI and menus -----------------------------------
			cmdOpts = new Command("Опции", Command.SCREEN, 1);
			cmdHelp = new Command("Помощь", Command.SCREEN, 2);
			cmdRules = new Command("Правила", Command.SCREEN, 3);
			cmdAbout = new Command("О программе", Command.SCREEN, 4);
			cmdExit = new Command("Выход", Command.EXIT, 5);
			addCommand(cmdOpts);
			addCommand(cmdHelp);
			addCommand(cmdRules);
			addCommand(cmdAbout);
			addCommand(cmdExit);

			// Making Options screen ------------------------
			FormOpts = new Form("Опции");
			cgType = new ChoiceGroup("Кол-во игроков", Choice.EXCLUSIVE);
			cgType.append("3 игрока", null);
			cgType.append("4 игрока", null);
			cgType.setSelectedIndex(m_iType, true);
			FormOpts.append(cgType);

			cgGame = new ChoiceGroup("Разновидность", Choice.EXCLUSIVE);
			cgGame.append("Ленинградка", null);
			cgGame.append("Сочинка", null);
			cgGame.append("Ростовчанка", null);
			cgGame.setSelectedIndex(m_iGame, true);
			FormOpts.append(cgGame);

			FormOpts.append("Имена (S,W,E,N):");
			tfSouth = new TextField(null, m_PScores[P_SOUTH].playerName, 20, TextField.ANY);
			tfWest = new TextField(null, m_PScores[P_WEST].playerName, 20, TextField.ANY);
			tfEast = new TextField(null, m_PScores[P_EAST].playerName, 20, TextField.ANY);
			tfNorth = new TextField(null, m_PScores[P_NORTH].playerName, 20, TextField.ANY);
			FormOpts.append(tfSouth);
			FormOpts.append(tfWest);
			FormOpts.append(tfEast);
			FormOpts.append(tfNorth);

			cmdOptsOk = new Command("Ok", Command.OK, 1);
			FormOpts.addCommand(cmdOptsOk);

			cgLang = new ChoiceGroup("Language", Choice.EXCLUSIVE);
			cgLang.append("English", null);
			cgLang.append("Russian", null);
			cgLang.setSelectedIndex(m_iLang, true);
			FormOpts.append(cgLang);

			// Making About screen --------------------------
			FormAbout = new Form("О программе");
			FormAbout
					.append("PrefCounter 1.0\n\nАвтор: Захар Семёнов\n\nEx-site company, 2006\n\nПожалуйста, сообщайте об ошибках и пожеланиях на\nitsbbox@gorodok.net"
							+ "\n\nСпасибо за Ваш выбор!\n\nПрограмма БЕСПЛАТНА и с открытым кодом.\nОна НЕ МОЖЕТ быть продана.\nПрограмма распространяется КАК ЕСТЬ.\nАвтор НЕ НЕСЁТ никакой ответственности за что бы то ни было.\nЕсли Вы с этим не согланы, удалите программу.\n");
			cmdAboutOk = new Command("Назад", Command.OK, 1);
			FormAbout.addCommand(cmdAboutOk);

			// Making Help screen --------------------------
			FormHelp = new Form("Help");
			FormHelp
					.append("Управление:\n\n*-Стереть символ\n#-Сменить знак\nДжостиком перемещаться\nЦифры для ввода.\nТак же следует менять опции в меню.\n");
			cmdHelpOk = new Command("Back", Command.OK, 1);
			FormHelp.addCommand(cmdHelpOk);

			// Making Rules screen --------------------------
			FormRules = new Form("Рассчёт пули");
			FormRules
					.append("Рассчёт пули. Правила.\n"
							+ "Данный текст основан на правилах Марьяж для Windows. Мы рекомендуем посмотреть полные правила там.\n\n"
							+ "Вступление: У каждого игрока есть своя часть пули, в которой вверху - ГОРА, в середине - ПУЛЯ и внизу - ВИСТЫ.\n\n"
							+ "Разновидность Ленинградка.\n"
							+ "0)Сперва вычтите удвоенную ПУЛЮ из ГОРЫ для каждого игрока. Более Вам не понадобиться ПУЛЯ.\n"
							+ "Далее - одинаково для всех вариантов.\n"
							+ "1)Далее делается Амнистия - у каждого игрока к горе добавляется одно и тоже число, чтобы у одного из игроков ГОРА стала нулевой, а у остальных положительные. Это не обязательно, но вычислять так становиться проще.\n"
							+ "2)Для каждого игрока возмите его гору и умножьте на 10 и разделите на количество игроков. "
							+ "Получившееся число добавьте в графы вистов всем остальным на этого игрока.\n"
							+ "3)Теперь суммарный выигрыш каждого - это сумма его вистов минус висты других игроков на него.\n"
							+ "4)Сумма всех выигрышей должна равняться нулю. Всегда проверяйте это.\n\n");
			cmdRulesOk = new Command("Назад", Command.OK, 1);
			FormRules.addCommand(cmdRulesOk);
		}
		// --------------------------------------------------------
	}

}
