package com.scriptor;

import org.junit.Test;

import static org.junit.Assert.*;

// TEST 013
public class correctChurchSelectedTest {
    public static void main(String args[])
    {
        String churchName = "St. Bonaventure";

        Church newChurch = new Church(churchName);

        assertEquals(newChurch.getName(), churchName);


    }
}
