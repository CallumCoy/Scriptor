package com.scriptor;

import android.content.Context;
import android.content.SharedPreferences;
import android.os.AsyncTask;
import android.preference.PreferenceManager;
import android.util.Log;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;
import java.util.ArrayList;

import org.json.*;

public class Church {
    private String name;
    private String address;
    private static Church selectedChurch;
    private ArrayList<Song> songList;

    public Church(String churchName, String churchAddress)
    {
        name = churchName;
        address = churchAddress;
        songList = new ArrayList<Song>();
    }

    public static void setCurrentChurch(Church c)
    {
        selectedChurch = c;
    }

    public static Church getSelectedChurch()
    {
        // If church has not been selected, use the first church in array as default
        if(selectedChurch == null)
        {
            selectedChurch = Settings.getChurches()[0];
        }

        return selectedChurch;
    }

    public String getName()
    {
        return name;
    }
    public String getAddress()
    {
        return address;
    }

    public String toString()
    {
        return name + ": " + address;
    }

    public static Church[] retrieveChurchInfo() throws IOException
    {
        String response = "";
        Church[] churches = null;
        String[] churchNames;
        String[] churchAddresses;

        // Opens church database
        churchRequest churchReq = new churchRequest();
        churchReq.execute(new URL("http://34.73.45.124:8080/getChurches"));

        // Checks if get request was successful
        try {
            response = churchReq.get();
        } catch (Exception e) {
            e.printStackTrace();
        }

       // Checks if response was recorded from database
        try {
            String responseString = response;

            JSONArray jsonArr = new JSONArray(responseString);
            int arrLength = jsonArr.length();
            
            churches = new Church[arrLength];
            churchNames = new String[arrLength];
            churchAddresses = new String[arrLength];

            for(int i = 0; i < arrLength; i++) {
                JSONObject jsonObj = jsonArr.getJSONObject(i);
                churchNames[i] = jsonObj.getString("name");
                churchAddresses[i] = jsonObj.getString("address");
                churches[i] = new Church(churchNames[i], churchAddresses[i]);
                Log.i("Success!", churchNames[i]);
            }


        } catch (JSONException e){
            Log.e("Error:", e.toString());
        }
        return churches;
    }

    //Creates correct format of URL for get request
    public String appendedURL()
    {
        String appendedURL = "http://34.73.45.124:8080/getData";

        String name = this.getName().replace(" ", "%20");
        //Log.i("name", name);

        String date = SavedDate.getSavedDate().toString();
        //Log.i("date", date);

        String address = this.getAddress().replace(" ", "%20");
        //Log.i("address", address);

        appendedURL = appendedURL + "?church=" + name + "&currDate=" + date + "&churchAddress=" + address;
        //Log.i("URL", appendedURL);

        return appendedURL;
    }


    public ArrayList<Song> retrieveSongs() throws IOException
    {
        ArrayList<Song> songList = new ArrayList<Song>();
        String response = "";

        URL url = new URL(appendedURL());
        // Opens song database
        songRequest songReq = new songRequest();
        songReq.execute(url);

        //Checks if get request was successful
        try {
            response = songReq.get();
        } catch (Exception e){
            e.printStackTrace();
        }

        // Checks if response was recorded
        try {
            String responseString = response;

            if(responseString.equals("N/A"))
                return null;

            //Log.i("response", responseString);

            JSONArray jsonArr = new JSONArray(responseString);
            int arrLength = jsonArr.length();
            Log.i("array length", "" + arrLength);

            for(int i = 0; i < arrLength; i++)
            {
                JSONObject jsonObj = jsonArr.getJSONObject(i);
                Song song = new Song(jsonObj.getString("mainText"));
                songList.add(song);
                //songText[i] = jsonObj.getString("mainText");
                Log.i("Success!", songList.get(i).getName());
            }

            this.setSongList(songList);
        } catch (JSONException e){
            Log.e("Error:",e.toString());
        }

        return songList;
    }

    public ArrayList<Song> getSongList() {
        return songList;
    }

    public void setSongList(ArrayList<Song> songList) {
        this.songList = songList;
    }
}

class churchRequest extends AsyncTask<URL, Integer, String> {

    @Override
    protected String doInBackground(URL... urls) {

        URL url = null;
        HttpURLConnection con = null;
        StringBuffer response = new StringBuffer();

        // Opens URL
        try {
            url = new URL("http://34.73.45.124:8080/getChurches");
        } catch (MalformedURLException e){
            Log.e("Error:", e.toString());
        }

        try {
            con = (HttpURLConnection) url.openConnection();
        } catch (IOException e) {
            e.printStackTrace();
        }

        // Get request of URL
        try {
            con.setRequestMethod("GET");
        } catch (ProtocolException e) {
            e.printStackTrace();
        }

        // Reading in the file
        try {
            BufferedReader in = new BufferedReader(
                    new InputStreamReader(con.getInputStream()));
            String inputLine;

            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();
        } catch (Exception e){
            Log.e("Error:", e.toString());
        }

        String responseString = response.toString();
        return responseString;
    }

    @Override
    protected void onPreExecute() {
        super.onPreExecute();
    }

    @Override
    protected void onPostExecute(String s) {

        super.onPostExecute(s);
    }

    @Override
    protected void onProgressUpdate(Integer... values) {
        super.onProgressUpdate(values);
    }

    @Override
    protected void onCancelled(String s) {
        super.onCancelled(s);
    }

    @Override
    protected void onCancelled() {
        super.onCancelled();
    }
}


class songRequest extends AsyncTask<URL, Integer, String> {

    @Override
    protected String doInBackground(URL... urls) {

        URL url = null;
        HttpURLConnection con = null;
        StringBuffer response = new StringBuffer();

        Church c = Church.getSelectedChurch();
        Log.i("songRequest", c.appendedURL());

        Log.d("broken", "did you break here?");
        // Opens URL
        try {
            url = new URL(c.appendedURL());
        } catch (MalformedURLException e){
            Log.e("Error:", e.toString());
        }

        try {
            con = (HttpURLConnection) url.openConnection();
        } catch (IOException e) {
            e.printStackTrace();
        }

        // Get request of URL
        try {
            con.setRequestMethod("GET");
        } catch (ProtocolException e) {
            e.printStackTrace();
        }

        // Reading in the file
        try {
            BufferedReader in = new BufferedReader(
                    new InputStreamReader(con.getInputStream()));
            String inputLine;

            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();
        } catch (Exception e){
            Log.e("Error:", e.toString());
        }

        String responseString = response.toString();
        return responseString;
    }

    @Override
    protected void onPreExecute() {
        super.onPreExecute();
    }

    @Override
    protected void onPostExecute(String s) {

        super.onPostExecute(s);
    }

    @Override
    protected void onProgressUpdate(Integer... values) {
        super.onProgressUpdate(values);
    }

    @Override
    protected void onCancelled(String s) {
        super.onCancelled(s);
    }

    @Override
    protected void onCancelled() {
        super.onCancelled();
    }
}
