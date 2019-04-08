package com.scriptor;
import org.junit.Test;

import java.util.Date;

import static org.junit.Assert.*;

//TEST 005
public class DateSelectionTest {

    // Checks if date was changed correctly
    @Test
    public void main()
    {

        int m, d, y;
        m = 12;
        d = 13;
        y = 2018;

        SavedDate date = new SavedDate(m, d, y);

        SavedDate.setSavedDate(date);

        assertEquals((SavedDate) date, (SavedDate) SavedDate.getSavedDate());

        m = 10;
        d = 14;
        y = 2019;

        SavedDate newDate = new SavedDate(m, d, y);

        SavedDate.setSavedDate(newDate);

        assertEquals(newDate, SavedDate.getSavedDate());

    }
}
