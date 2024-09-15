package com.scriptor;

import android.widget.TextView;

import org.junit.Test;

import static org.junit.Assert.*;

// TEST 011
public class SetTextSizeTest {
    private int LARGE = 20;
    private int MEDIUM = 18;
    private int NORMAL = 14;
    private int SMALL = 12;

    @Test
    public void main()
    {
        TextSize ts = new TextSize();

        ts.setTextSize(LARGE);
        assertEquals(ts.getTextSize(), 20);

        ts.setTextSize(MEDIUM);
        assertEquals(ts.getTextSize(), 18);

        ts.setTextSize(NORMAL);
        assertEquals(ts.getTextSize(), 14);

        ts.setTextSize(SMALL);
        assertEquals(ts.getTextSize(), 12);

    }
}
