package com.scriptor;

import android.content.Context;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

public class Settings extends AppCompatActivity implements AdapterView.OnItemSelectedListener{

    // Various font sizes
    public static final int LARGE = 20;
    public static final int MEDIUM = 18;
    public static final int NORMAL = 14;
    public static final int SMALL = 12;

    public SharedPreferences sharedPref;

    static int fontSize;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_settings);
        Toolbar toolbar = findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        // Activates function
        changeFontSize();

        dropDownMenuInitializer();
        //setTheme(R.style.LargeText);

    }

    public void changeFontSize()
    {
        // Gathers text info to modify
        final TextView fontSizePrompt = findViewById(R.id.fontSizePrompt);
        final TextView churchSelectPrompt = findViewById(R.id.churchSelectPrompt);

        Button large = (Button) findViewById(R.id.largeSize);
        large.setOnClickListener(new View.OnClickListener()
        {
            @Override
            public void onClick(View v)
            {
                fontSize = LARGE;
                fontSizePrompt.setTextSize(fontSize);
                churchSelectPrompt.setTextSize(fontSize);
            }
        });

        Button medium = (Button) findViewById(R.id.mediumSize);
        medium.setOnClickListener(new View.OnClickListener()
        {
            @Override
            public void onClick(View v)
            {
                fontSize = MEDIUM;
                fontSizePrompt.setTextSize(fontSize);
                churchSelectPrompt.setTextSize(fontSize);
            }
        });

        Button normal = (Button) findViewById(R.id.normalSize);
        normal.setOnClickListener(new View.OnClickListener()
        {
            @Override
            public void onClick(View v)
            {
                fontSize = NORMAL;
                fontSizePrompt.setTextSize(fontSize);
                churchSelectPrompt.setTextSize(fontSize);
            }
        });

        Button small = (Button) findViewById(R.id.smallSize);
        small.setOnClickListener(new View.OnClickListener()
        {
            @Override
            public void onClick(View v)
            {
                fontSize = SMALL;
                fontSizePrompt.setTextSize(fontSize);
                churchSelectPrompt.setTextSize(fontSize);
            }
        });
    }

    public void dropDownMenuInitializer()
    {
        Spinner dropDown = (Spinner) findViewById(R.id.church_selection);
        ArrayAdapter<CharSequence> adapter = ArrayAdapter.createFromResource(this,
                R.array.church_array, android.R.layout.simple_spinner_item);

        // Specify the layout to use when the list of choices appears
        adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);

        // Apply the adapter to the spinner
        dropDown.setAdapter(adapter);

        dropDown.setOnItemSelectedListener(this);
    }

    @Override
    public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
        String item = parent.getItemAtPosition(position).toString();

        Toast.makeText(parent.getContext(), item, Toast.LENGTH_SHORT).show();
    }

    @Override
    public void onNothingSelected(AdapterView<?> parent) {

    }

}
