package com.scriptor;

import android.os.AsyncTask;
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
    private ArrayList<Song> songList;
    public Church(String churchName)
    {
        this.name = churchName;
        songList = new ArrayList<Song>();
    }

    public String getName()
    {
        return name;
    }
    public String getAddress()
    {
        return address;
    }

    public void displaySongList()
    {
        for(Song song: songList)
        {
            System.out.println(song);
        }
    }

    public String retrieveSongs() throws IOException {

        String response = "";
        songRequest songReq = new songRequest();
        songReq.execute(new URL("http://35.238.47.23/getData"));
        try {
            response = songReq.get();
        } catch (Exception e){
            e.printStackTrace();
        }


        int stop = 0;

        //my part...

        String songText = null;
        try {
            String responseString = response.toString();

            JSONArray jsonArr = new JSONArray(responseString);
            JSONObject jsonObj = jsonArr.getJSONObject(0);
            songText = jsonObj.getString("mainText");
            Log.i("Success!", songText);

        } catch (JSONException e){
            Log.e("Error:",e.toString());

        }
        return songText;

        //-----------


    }


}



class songRequest extends AsyncTask<URL, Integer, String> {

    @Override
    protected String doInBackground(URL... urls) {

        URL url = null;

        try {
            url = new URL("http://35.238.47.23/getData");
        } catch (MalformedURLException e){
            Log.e("Error:", e.toString());
        }
        HttpURLConnection con = null;
        try {
            con = (HttpURLConnection) url.openConnection();
        } catch (IOException e) {
            e.printStackTrace();
        }
        try {
            con.setRequestMethod("GET");
        } catch (ProtocolException e) {
            e.printStackTrace();
        }
        StringBuffer response = new StringBuffer();
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
