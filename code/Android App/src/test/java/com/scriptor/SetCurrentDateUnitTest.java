package com.scriptor;

import org.junit.Test;

import java.util.Date;

import static org.junit.Assert.*;

public class SetCurrentDateUnitTest {

    @Test
    public void main()
    {
        // Both should have contents of current date in real time
        SavedDate savedDate = new SavedDate();

        Date date = new Date();

        assertEquals(date, savedDate);
    }
}
