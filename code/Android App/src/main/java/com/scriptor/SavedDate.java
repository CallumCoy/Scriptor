package com.scriptor;


import java.text.SimpleDateFormat;
import java.util.Date;

public class SavedDate extends Date {
    private static int month, day, year;
    private static SavedDate savedDate;

    public SavedDate()
    {
        super();
    }

    public SavedDate(int month, int day, int year)
    {
        this.month = month;
        this.day = day;
        this.year = year;
        setSavedDate(this);
    }

    public int getMonth() {
        return month;
    }

    public int getDay() {
        return day;
    }

    public int getYear() {
        return year;
    }

    public void setMonth(int month) {
        this.month = month;
    }

    public void setDay(int day) {
        this.day = day;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public static SavedDate getSavedDate()
    {
        if(savedDate == null)
        {
            SavedDate date = new SavedDate();

            SimpleDateFormat formattedDate = new SimpleDateFormat("MM/dd/yyyy");

            String dateString = formattedDate.format(date);

            int month = Integer.parseInt(dateString.substring(0,2));
            int day = Integer.parseInt(dateString.substring(3,5));
            int year = Integer.parseInt(dateString.substring(6,10));

            date.setMonth(month);
            date.setDay(day);
            date.setYear(year);

            savedDate = date;

            return date;
        }

        return savedDate;
    }

    public static void setSavedDate(SavedDate d)
    {
        savedDate = d;
        savedDate.setMonth(d.getMonth());
        savedDate.setDay(d.getDay());
        savedDate.setYear(d.getYear());
    }

    public String toString()
    {
        String monthString = "" + month;
        String dayString = "" + day;

        if(month > 0 && month < 10)
            monthString = "0" + month;
        if(day > 0 && day < 10)
            dayString = "0" + day;

        return monthString + "_" + dayString + "_" + year;
    }
}
