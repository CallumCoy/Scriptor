package com.scriptor;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.text.method.ScrollingMovementMethod;
import android.util.Log;
import android.view.View;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.Button;
import android.widget.TextView;

import java.io.IOException;
import java.util.ArrayList;

public class MainActivity extends AppCompatActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Toolbar toolbar = findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        openSongList();

        setTextSize();
    }

    // Sets text size to elements on Main Activity page
    public void setTextSize()
    {
        TextSize ts = new TextSize();

        // Where songs are displayed
        TextView songDisplay = findViewById(R.id.songDisplay);
        songDisplay.setTextSize(ts.getTextSize());

        // "Click to download songs" button
        TextView buttonText = findViewById(R.id.button);
        buttonText.setTextSize(ts.getTextSize());
    }

    public void openSongList()
    {
        // Activates button on home screen
        Button button = findViewById(R.id.button);

        button.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View v) {
                Button button = (Button) v;

                // Removes button so songs can be displayed without an obstacle
                button.setVisibility(View.GONE);

                // Will display database is future Sprint
                TextView songDisplay = findViewById(R.id.songDisplay);

                // Grabs selected church
                Church selectedChurch = Church.getSelectedChurch();

                ArrayList<Song> response = null;

                // Attempts to retrieve songs
                try {
                    response = selectedChurch.retrieveSongs();
                } catch (IOException e){
                    Log.e("Error:", e.toString());
                }

                // If the response is empty, display to the user there are no songs
                if(response == null || response.isEmpty())
                    songDisplay.setText("No songs available");
                else{
                    String songs = "";
                    // Transfers text
                    for(int i = 0; i < response.size(); i++)
                    {
                        songs = songs + response.get(i).getName() + "\n";
                    }
                    songDisplay.setText(songs);
                }

                // Allows scrolling ability
                songDisplay.setMovementMethod(new ScrollingMovementMethod());
            }
        });

    }



    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            startActivity(new Intent(MainActivity.this, Settings.class));
            return true;
        }

        return super.onOptionsItemSelected(item);
    }
}
