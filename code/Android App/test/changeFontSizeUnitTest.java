package scriptor.com;

import org.junit.Test;

import static org.junit.Assert.*;

public class changeFontSizeUnitTest {

    @Test
    public void satisfiesChange()
    {
        // If button has been clicked, it will check to see the text is the correct font size
        // after it is pressed
        if(Settings.largeClicked)
        {
            assertEquals(Settings.LARGE, Settings.fontSize);
        }
        else if(Settings.mediumClicked)
        {
            assertEquals(Settings.MEDIUM, Settings.fontSize);
        }
        else if(Settings.normalClicked)
        {
            assertEquals(Settings.NORMAL, Settings.fontSize);
        }
        else if(Settings.smallClicked)
        {
            assertEquals(Settings.SMALL, Settings.fontSize);
        }
    }
}
