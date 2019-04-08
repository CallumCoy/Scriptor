package com.scriptor;

import org.junit.Test;

import static org.junit.Assert.*;

// TEST 013
public class correctChurchSelectedTest {

    @Test
    public void main()
    {
        String churchName = "St. Bonaventure";
        String churchAddress = "123 Fake Drive";

        Church newChurch = new Church(churchName, churchAddress);

        assertEquals(newChurch.getName(), churchName);
        assertEquals(newChurch.getAddress(), churchAddress);



    }
}
