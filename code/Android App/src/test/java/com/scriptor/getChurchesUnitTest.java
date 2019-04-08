package com.scriptor;

import org.junit.*;

import java.io.IOException;

import static org.junit.Assert.*;


public class getChurchesUnitTest {
    public Church[] fromDatabase;

    @Before
    public void connectToDatabase()
    {
        try {
            fromDatabase = Church.retrieveChurchInfo();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    @Test
    public void main()
    {
        Church[] churches = Settings.getChurches();

        assertArrayEquals(fromDatabase, churches);
    }
}
