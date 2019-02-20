package scriptor.com;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

public class Settings extends AppCompatActivity {
    // Various font sizes
    public static final int LARGE = 20;
    public static final int MEDIUM = 18;
    public static final int NORMAL = 14;
    public static final int SMALL = 12;

    // This is for testing purposes
    static int fontSize = NORMAL;
    static boolean largeClicked = false;
    static boolean mediumClicked = false;
    static boolean normalClicked = false;
    static boolean smallClicked = false;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_settings);
        Toolbar toolbar = findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        // Activates function
        changeFontSize();
    }

    public void changeFontSize()
    {
        // Gathers text info to modify
        final TextView fontSizePrompt = findViewById(R.id.fontSizePrompt);
        View inflatedView = getLayoutInflater().inflate(R.layout.activity_main, null);
        final TextView churchInfo =  inflatedView.findViewById(R.id.churchInfo);

        Button large = findViewById(R.id.largeSize);
        large.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v){
                largeClicked = true;
                mediumClicked = false;
                normalClicked = false;
                smallClicked = false;
                fontSizePrompt.setTextSize(LARGE);
                churchInfo.setTextSize(LARGE);
                fontSize = (int) churchInfo.getTextSize();
            }
        });

        Button medium = findViewById(R.id.mediumSize);
        medium.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                largeClicked = false;
                mediumClicked = true;
                normalClicked = false;
                smallClicked = false;
                fontSizePrompt.setTextSize(MEDIUM);
                churchInfo.setTextSize(MEDIUM);
                fontSize = (int) fontSizePrompt.getTextSize();
            }
        });

        Button normal = findViewById(R.id.normalSize);
        normal.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                largeClicked = false;
                mediumClicked = false;
                normalClicked = true;
                smallClicked = false;
                fontSizePrompt.setTextSize(NORMAL);
                churchInfo.setTextSize(NORMAL);
                fontSize = (int) fontSizePrompt.getTextSize();
            }
        });

        Button small = findViewById(R.id.smallSize);
        small.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                largeClicked = false;
                mediumClicked = false;
                normalClicked = false;
                smallClicked = true;
                fontSizePrompt.setTextSize(SMALL);
                churchInfo.setTextSize(SMALL);
                fontSize = (int) fontSizePrompt.getTextSize();
            }
        });
    }

}
