import org.junit.Test;

import java.util.regex.Pattern;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

public class BasicRegExps {

    @Test
    /** Standard human readable float number in decimal form. No whitespaces allowed.
     * Valid input "235.73"
     */
    public void testFloat() {
        //String plainRegex = /[+-]?\d+(\.\d+)?/;
        String regex = "[+-]?\\d+(\\.\\d+)?";//java version with escapes

        assertTrue(Pattern.matches(regex, "0"));
        assertTrue(Pattern.matches(regex, "+0"));
        assertTrue(Pattern.matches(regex, "-000"));
        assertTrue(Pattern.matches(regex, "1"));
        assertTrue(Pattern.matches(regex, "+1"));
        assertTrue(Pattern.matches(regex, "-3"));
        assertTrue(Pattern.matches(regex, "123.34"));
        assertTrue(Pattern.matches(regex, "-0.378"));
        assertTrue(Pattern.matches(regex, "+809.3"));

        assertFalse(Pattern.matches(regex, ""));
        assertFalse(Pattern.matches(regex, " "));
        assertFalse(Pattern.matches(regex, "."));
        assertFalse(Pattern.matches(regex, " 1.2"));
        assertFalse(Pattern.matches(regex, "1.2 "));
        assertFalse(Pattern.matches(regex, "++93"));
        assertFalse(Pattern.matches(regex, "3+"));
        assertFalse(Pattern.matches(regex, "9-1"));
        assertFalse(Pattern.matches(regex, "451-"));
        assertFalse(Pattern.matches(regex, ".1"));
        assertFalse(Pattern.matches(regex, "2."));
    }

    @Test
    public void testEmail() {
        //String plainRegex = /^[-\w.]+@([A-z0-9][-A-z0-9]+\.)+[A-z]{2,4}$/;
        String regex = "^[-\\w.]+@([A-z0-9][-A-z0-9]+\\.)+[A-z]{2,4}$";

        assertTrue(Pattern.matches(regex, "ivandanilov@mail.com"));
        assertTrue(Pattern.matches(regex, "ivan.danilov@mail.com"));
        assertTrue(Pattern.matches(regex, "ivan-daniov@mail.com"));
        assertTrue(Pattern.matches(regex, "ivan_daniov@mail.com"));
        assertTrue(Pattern.matches(regex, "ivandanilov@mail.ab"));
        assertTrue(Pattern.matches(regex, "ivandanilov@mail.abcd"));

        assertFalse(Pattern.matches(regex, ""));
        assertFalse(Pattern.matches(regex, "ivandanilov"));
        assertFalse(Pattern.matches(regex, "@mail.com"));
        assertFalse(Pattern.matches(regex, "ivandanilov@-mail.com"));
        assertFalse(Pattern.matches(regex, "ivandanilov@mail."));

        assertFalse(Pattern.matches(regex, "ivandanilov@mail.123"));
        assertFalse(Pattern.matches(regex, "ivandanilov@mail.a"));
        assertFalse(Pattern.matches(regex, "ivandanilov@mail.abcde"));
    }

    @Test
    public void testIPv4() {
        //String plainRegex = /((25[0-5]|2[0-4]\d|[01]?\d\d?)\.){3}(25[0-5]|2[0-4]\d|[01]?\d\d?)/;
        String regex = "((25[0-5]|2[0-4]\\d|[01]?\\d\\d?)\\.){3}(25[0-5]|2[0-4]\\d|[01]?\\d\\d?)";

        assertTrue(Pattern.matches(regex, "1.2.3.4"));
        assertTrue(Pattern.matches(regex, "250.203.122.134"));

        assertFalse(Pattern.matches(regex, "300.203.122.134"));
    }

    //UID
    //^[0-9A-Fa-f]{8}\-[0-9A-Fa-f]{4}\-[0-9A-Fa-f]{4}\-[0-9A-Fa-f]{4}\-[0-9A-Fa-f]{12}$

    //DATE    "YYYY-MM-DD"
    //[0-9]{4}-(0[1-9]|1[012])-(0[1-9]|1[0-9]|2[0-9]|3[01])

}
