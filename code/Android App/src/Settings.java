package scriptor.com;

import android.content.Context;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

public class Settings extends AppCompatActivity implements AdapterView.OnItemSelectedListener {
    // Various font sizes
    public static final int LARGE = 20;
    public static final int MEDIUM = 18;
    public static final int NORMAL = 14;
    public static final int SMALL = 12;

    public SharedPreferences sharedPref;

    static int fontSize;

    // Initializes activity
    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_settings);
        Toolbar toolbar = findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        // Activates function
        changeFontSize();

        dropDownMenuInitializer();
    }

    public void changeFontSize()
    {
        // Gathers text info to modify
        final TextView fontSizePrompt = findViewById(R.id.fontSizePrompt);
        View inflatedView = getLayoutInflater().inflate(R.layout.activity_main, null);
        final TextView churchInfo =  inflatedView.findViewById(R.id.churchInfo);

        Button large = (Button) findViewById(R.id.largeSize);
        large.setOnClickListener(new View.OnClickListener()
        {
            @Override
            public void onClick(View v)
            {
                fontSize = LARGE;
            }
        });

        Button medium = (Button) findViewById(R.id.mediumSize);
        medium.setOnClickListener(new View.OnClickListener()
        {
            @Override
            public void onClick(View v)
            {
                fontSize = MEDIUM;
            }
        });

        Button normal = (Button) findViewById(R.id.normalSize);
        normal.setOnClickListener(new View.OnClickListener()
        {
            @Override
            public void onClick(View v)
            {
                fontSize = NORMAL;
            }
        });

        Button small = (Button) findViewById(R.id.smallSize);
        small.setOnClickListener(new View.OnClickListener()
        {
            @Override
            public void onClick(View v)
            {
                fontSize = SMALL;
            }
        });

//        Button large = findViewById(R.id.largeSize);
//        large.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View v){
//                largeClicked = true;
//                mediumClicked = false;
//                normalClicked = false;
//                smallClicked = false;
//                fontSizePrompt.setTextSize(LARGE);
//                churchInfo.setTextSize(LARGE);
//                fontSize = (int) churchInfo.getTextSize();
//            }
//        });
//
//        Button medium = findViewById(R.id.mediumSize);
//        medium.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View v) {
//                largeClicked = false;
//                mediumClicked = true;
//                normalClicked = false;
//                smallClicked = false;
//                fontSizePrompt.setTextSize(MEDIUM);
//                churchInfo.setTextSize(MEDIUM);
//                fontSize = (int) fontSizePrompt.getTextSize();
//            }
//        });
//
//        Button normal = findViewById(R.id.normalSize);
//        normal.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View v) {
//                largeClicked = false;
//                mediumClicked = false;
//                normalClicked = true;
//                smallClicked = false;
//                fontSizePrompt.setTextSize(NORMAL);
//                churchInfo.setTextSize(NORMAL);
//                fontSize = (int) fontSizePrompt.getTextSize();
//            }
//        });
//
//        Button small = findViewById(R.id.smallSize);
//        small.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View v) {
//                largeClicked = false;
//                mediumClicked = false;
//                normalClicked = false;
//                smallClicked = true;
//                fontSizePrompt.setTextSize(SMALL);
//                churchInfo.setTextSize(SMALL);
//                fontSize = (int) fontSizePrompt.getTextSize();
//            }
//        });
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

//    public void onLargeClick(View view)
//    {
//        sharedPref = getSharedPreferences("prefID", Context.MODE_PRIVATE);
//        SharedPreferences.Editor editor = sharedPref.edit();
//        editor.putInt("fontSize", LARGE);
//        editor.apply();
//    }

    public void saveFontSize(View view)
    {
        SharedPreferences sharedPref = getSharedPreferences("fontSize", Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = sharedPref.edit();
        editor.putInt("fontSize", fontSize);
        editor.apply();

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
