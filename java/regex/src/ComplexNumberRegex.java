import org.junit.Test;

import java.util.regex.Pattern;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

public class ComplexNumberRegex {

    @Test
    public void complexReg() {
        //compNums=compNum(,compNum)*
        //compNum=float|floatI|(float)(floatI)
        //float=+
        String complexNumberRegex = "^(([+-]?\\d+(\\.\\d+)?)|([+-]?\\d+(\\.\\d+)?i)|(([+-]?\\d+(\\.\\d+)?)([+-]?\\d+(\\.\\d+)?i)))(,([+-]?\\d+(\\.\\d+)?)|([+-]?\\d+(\\.\\d+)?i)|(([+-]?\\d+(\\.\\d+)?)([+-]?\\d+(\\.\\d+)?i)))*$";
        assertTrue(Pattern.matches(complexNumberRegex, "+1i"));
        assertTrue(Pattern.matches(complexNumberRegex, "1i"));
        assertTrue(Pattern.matches(complexNumberRegex, "123.34i"));
        assertTrue(Pattern.matches(complexNumberRegex, "-0.378i"));
        assertTrue(Pattern.matches(complexNumberRegex, "+0.378i"));
        assertTrue(Pattern.matches(complexNumberRegex, "-000i"));

        assertTrue(Pattern.matches(complexNumberRegex, "3"));
        assertTrue(Pattern.matches(complexNumberRegex, "-6"));
        assertTrue(Pattern.matches(complexNumberRegex, "45.34"));
        assertTrue(Pattern.matches(complexNumberRegex, "+45.34"));
        assertTrue(Pattern.matches(complexNumberRegex, "-45.34"));

        assertTrue(Pattern.matches(complexNumberRegex, "3+6i"));
        assertTrue(Pattern.matches(complexNumberRegex, "3-6i"));
        assertTrue(Pattern.matches(complexNumberRegex, "-3-6i"));
        assertTrue(Pattern.matches(complexNumberRegex, "-3+6i"));
        assertTrue(Pattern.matches(complexNumberRegex, "-5.13+67.232i"));

        assertTrue(Pattern.matches(complexNumberRegex, "1+2i,7.1,4.5-34i,-18i,-1.1-90.2i"));


        assertFalse(Pattern.matches(complexNumberRegex, ""));
        //assertTrue(Pattern.matches(complexNumberRegex, "i"));//TODO
    }
}
