package com.scriptor;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import java.io.IOException;
import java.text.SimpleDateFormat;


public class Settings extends AppCompatActivity implements AdapterView.OnItemSelectedListener{

    // Various font sizes
    private static final int LARGE = 20;
    private static final int MEDIUM = 18;
    private static final int NORMAL = 14;
    private static final int SMALL = 12;

    private static SharedPreferences sharedPref;
    private static Spinner dropDown;
    public static int spinnerPosition;

    public Church selectedChurch;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_settings);
        Toolbar toolbar = findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        // Activates function
        changeFontSize();

        setTextSize();

        dropDownMenuInitializer();

        // Sets current date if not selected yet
        setCurrentDate();

        // Checks to see if new date is inputted in order to save
        saveDate();
    }

    // Sets date in settings to current date
    public void setCurrentDate()
    {
        SavedDate currentDate = new SavedDate();

        // Formats date
        SimpleDateFormat formattedDate = new SimpleDateFormat("MM/dd/yyyy");

        // Converts formatted date into a string
        String dateString = formattedDate.format(currentDate);

        // Grabs month, day, and year contents from string
        int month = Integer.parseInt(dateString.substring(0,2));
        int day = Integer.parseInt(dateString.substring(3,5));
        int year = Integer.parseInt(dateString.substring(6,10));

        // Sets everything in object
        currentDate.setMonth(month);
        currentDate.setDay(day);
        currentDate.setYear(year);

        // Sets date for future use
        SavedDate.setSavedDate(currentDate);

        TextView date = findViewById(R.id.date_input);

        // Sets text of date input box to current date
        date.setText(dateString);
    }


    public void saveDate()
    {
        // Grabs date text box
        final EditText date = findViewById(R.id.date_input);

        // Used in case of date being changed
        final SavedDate newDate = new SavedDate();

        // Saves date selected from user
        sharedPref = PreferenceManager.getDefaultSharedPreferences(this);
        date.setText(sharedPref.getString("date", newDate.toString()));

        // Gives functionality to "Save Date" button
        Button save = findViewById(R.id.saveDate);
        save.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                // Grabs what is typed in text box
                String dateString = String.valueOf(date.getText());
                Log.i("dateView", dateString);

                // Correctly grabs each part of date
                int ind = dateString.indexOf('/');
                int month = Integer.parseInt(dateString.substring(0,ind));

                int dInd = dateString.indexOf('/', ind+ 1);
                int day = Integer.parseInt(dateString.substring(ind + 1, dInd));

                int year = Integer.parseInt(dateString.substring(dInd+1));

                // Sets the date to the SavedDate object
                newDate.setMonth(month);
                newDate.setDay(day);
                newDate.setYear(year);

                SharedPreferences sharedPref = (SharedPreferences) PreferenceManager.getDefaultSharedPreferences(Settings.this);
                SharedPreferences.Editor editor = sharedPref.edit();

                // Applies info to shared preferences
                editor.putString("date", newDate.getMonth() + "/" + newDate.getDay() + "/" + newDate.getYear());
                editor.apply();

                // Sets the new date for future use
                SavedDate.setSavedDate(newDate);

                Log.d("Button clicked:", newDate.toString());
            }
        });
    }

    // Sets Text Size for all features on Settings Page
    public void setTextSize()
    {
        TextSize ts = new TextSize();

        //"Preferred Font Size" text on screen
        TextView fontSizePrompt = findViewById(R.id.fontSizePrompt);
        fontSizePrompt.setTextSize(ts.getTextSize());

        // "Select Your Church Here" text on screen
        TextView churchSelectPrompt = findViewById(R.id.churchSelectPrompt);
        churchSelectPrompt.setTextSize(ts.getTextSize());

        // "Change Date Here:" text on screen
        TextView dateSelectPrompt = findViewById(R.id.date_prompt);
        dateSelectPrompt.setTextSize(ts.getTextSize());

        // Where the date is typed
        TextView dateInput = findViewById(R.id.date_input);
        dateInput.setTextSize(ts.getTextSize());

        // "Save Date" Button
        TextView dateButton = findViewById(R.id.saveDate);
        dateButton.setTextSize(ts.getTextSize());
    }

    // Handles button commands for font size
    public void changeFontSize()
    {
        final TextSize ts = new TextSize();

        Button large = (Button) findViewById(R.id.largeSize);
        large.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v)
            {
                ts.setTextSize(LARGE);
                setTextSize();
            }
        });

        Button medium = (Button) findViewById(R.id.mediumSize);
        medium.setOnClickListener(new View.OnClickListener()
        {
            @Override
            public void onClick(View v)
            {
                ts.setTextSize(MEDIUM);
                setTextSize();
            }
        });

        Button normal = (Button) findViewById(R.id.normalSize);
        normal.setOnClickListener(new View.OnClickListener()
        {
            @Override
            public void onClick(View v)
            {
                ts.setTextSize(NORMAL);
                setTextSize();
            }
        });

        Button small = (Button) findViewById(R.id.smallSize);
        small.setOnClickListener(new View.OnClickListener()
        {
            @Override
            public void onClick(View v)
            {
                ts.setTextSize(SMALL);
                setTextSize();
            }
        });

    }

    // Retrieves churches
    static Church[] getChurches(){
        Church[] churches = null;

        try {
            churches = Church.retrieveChurchInfo();
        } catch (IOException e) {
            e.printStackTrace();
        }

        return churches;
    }

    // Converts church contents into a string array for drop down menu later
    public static String[] getChurchInfo()
    {
        Church[] churches = getChurches();
        String[] churchNames;

        churchNames = new String[churches.length];

        for(int i = 0; i < churches.length; i++)
        {
            churchNames[i] = churches[i].toString();
        }

        return churchNames;
    }

    public void dropDownMenuInitializer() {
        dropDown = (Spinner) findViewById(R.id.church_selection);

        String[] churchInfo = getChurchInfo();
        String defaultChurch = churchInfo[0];

        // Creates drop down menu of churches
        ArrayAdapter<String> adapter = new ArrayAdapter<String>(this, android.R.layout.simple_spinner_item, churchInfo);

        // Specify the layout to use when the list of choices appears
        adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);

        // Apply the adapter to the spinner
        dropDown.setAdapter(adapter);

        dropDown.setOnItemSelectedListener(this);

        // Sets default church
        sharedPref = PreferenceManager.getDefaultSharedPreferences(this);
        String church = sharedPref.getString("church", defaultChurch);

        for(int i = 0; i < churchInfo.length; i++) {
            if (getChurchInfo()[i].equalsIgnoreCase(church)) {
                Church.setCurrentChurch(getChurches()[i]);
                break;
            }
        }

        // If a new church selection is made, this will make sure it is saved
        if (!church.equalsIgnoreCase(defaultChurch)) {
            spinnerPosition = adapter.getPosition(church);
            dropDown.setSelection(spinnerPosition);
        }
    }


    @Override
    public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {

        String item = parent.getItemAtPosition(position).toString();

        // Saves newly selected item
        SharedPreferences.Editor editor = sharedPref.edit();
        editor.putString("church", dropDown.getSelectedItem().toString());
        editor.apply();

        // Finds the church selected and informs code what the current church is for future use
        for(int i = 0; i < getChurchInfo().length; i++)
        {
            if(getChurchInfo()[i].equalsIgnoreCase(item))
            {
                Church.setCurrentChurch(getChurches()[i]);
                //selectedChurch = getChurches()[i];
                break;
            }
        }

        Toast.makeText(parent.getContext(), item, Toast.LENGTH_SHORT).show();
    }

    @Override
    public void onNothingSelected(AdapterView<?> parent) {

    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_settings, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.home_button) {
            startActivity(new Intent(Settings.this, MainActivity.class));
            return true;
        }

        return super.onOptionsItemSelected(item);
    }

}
