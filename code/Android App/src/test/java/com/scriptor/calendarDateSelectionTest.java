package com.scriptor;
import org.junit.Test;

import java.util.Date;

import static org.junit.Assert.*;

//TEST 005
public class calendarDateSelectionTest {

    // Checks if date was changed correctly
    public static void main(String args[])
    {
        String churchName = "St. Bonaventure";

        Church newChurch = new Church(churchName);

        int m, d, y;
        m = 12;
        d = 13;
        y = 2018;

        Date newDate = new Date(m, d, y);

//        SongActivity.changeDate(newDate);
//
//        assertEquals(newDate.month, m);
//        assertEquals(newDate.day, d);
//        assertEquals(newDate.year, y);
    }
}
