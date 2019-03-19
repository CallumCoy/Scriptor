package com.scriptor;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;
import java.util.ArrayList;

public class Song {
    String name;
    String lyrics;
    private ArrayList<Song> songList;

    public Song(String name){
        this.name = name;
    }

    public void setLyrics(String lyrics)
    {
        this.lyrics = lyrics;
    }

}
