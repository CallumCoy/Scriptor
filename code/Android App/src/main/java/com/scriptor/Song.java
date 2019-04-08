package com.scriptor;

import java.util.ArrayList;

public class Song {

    private String name;
    private String lyrics;

    public Song(String name){
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public String getLyrics() {
        return lyrics;
    }

    public void setLyrics(String lyrics)
    {
        this.lyrics = lyrics;
    }

}
