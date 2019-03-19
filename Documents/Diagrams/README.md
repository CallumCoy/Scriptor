Populate each section with information as it applies to your project. If a section does not apply, explain why. Include diagrams (or links to diagrams) in each section, as appropriate. For example, sketches of the user interfaces along with an explanation of how the interface components will work; ERD diagrams of the database; rough class diagrams; context diagrams showing the system boundary; etc.

# Program Organization

You should have a diagram of your high level architecture in this section, along with a description of each component and a table that relates each component to one or more user stories.

[Architecture Diagram](https://github.com/CallumCoy/Scriptor/blob/Wanda's-Branch/Documents/Diagrams/High%20Level%20Architecture%20Diagram.md)


# Major Classes

You should have an UML class diagram in this section, along with a description of each class and a table that relates each component to one or more user stories. At a minimum, you need 1 diagram of your major classes. You are encouraged to also include more detailed diagrams that include all of your classes. 

---------------- no idea for the above

# Data Design

[SQL Diagram](https://github.com/CallumCoy/Scriptor/blob/Cal's-Branch/Documents/Diagrams/SQL%20Database.md)

Our diagram only consists of three different sections, the main song database where all songs the songs lie.  A churchs songs database, which will contain a list of songs the priest wants to be available to select (by default this will = the main song database). Then lastly there will be a church database, which will allow church goers and the priests to sign into their church.

# Business Rules

You should list the assumptions, rules, and guidelines from external sources that are impacting your program design.
  - This is a all ages app, so we must prevent explicit language from entering our database.
  - A large number of church goers are elderly, so all of our systems must be self explanatory, and simple to use. 

# User Interface Design

  We have 3 different user interfaces which consis of a portal UI, andriod UI, and iOS UI
  ## HTML Interface Design
  [HTML Diagrams](https://github.com/CallumCoy/Scriptor/blob/Cal's-Branch/Documents/Diagrams/htmlDiagram.md)
  
  The design will be quite simple, since it is just html, and css in the design aspect.  The main screen contains will contian two tables, containing available songs and scheduled songs.  For the date select We chose a simple drop down interface over taking the entire sprint to figuring out how to make a calender.
  
  ## Android Design
  [Android Diagrams](https://github.com/CallumCoy/Scriptor/new/Cal's-Branch/Documents/Diagrams)
  
  
  ## iOS Design

# Resource Management

  Time is an important resource for this project. It is important we balance our time as we also have other classes in the way that need focus on as well. Our computer resources won't be depleted throughout the course of this project, so there is nothing to worry about there. Luckily, money isn't involved in this project, but it is still important we attempt to be efficient with our work. 

# Security

While security does not need to be military level it does need to keep out people from pranking the church via changing the lyrics on the portal. Although our app does use 3rd party application for transfering money, we do not need to worry about them too much, as the thrid party app will require the user to sign in.

# Performance

  Does not effect us, as our app will not be resource demanding.

# Scalability
  
  This App is very Scalable, as the onlything that would need to be beefed up if it got popular, is the servers, and the size of our databases.
  
# Interoperability

  Our system will need to be best at Interoperablility, as the whole process involves the phones talking to on database while the portal must talk to two databases.

# Internationalization/Localization

  This is just going to be a English app, as the database would get too big with we started implementing religious songs from different religions.

# Input/Output

  This is a list of different types of input and output we will have on each application.

  ## HTML
  - Input
    - Sign-in Page
      - Textbox for Church Name.
      - Textbox for Password.
    - Sign-up Page
      - Textbox for Church Name.
      - Textbox for Password.
      - Textbox for Password confirm.
    - Main Page
      - Three drop down bars for selecting the date.
      - Several add buttons.
      - Several remove buttons.
      - Several textboxes to set the order of the songs.
      - A submit button to comfirm order of songs.
      - A print button to print the list of songs.
    - Add/Edit Songs
      - Several buttons to select what song you want to edit.
      - A text box to insert the name of the song.
      - A text box to insert the lyrics of the song.
      - A submit button, to submit the song/ submit the changes.
      
  - Output (Excluding page redirections)
    - Main Page
      - A table showing the available songs.
      - A table showing the order of the songs.
      - A physical page of the scheduled songs.
    - Add/Edit Songs
      - A list of available songs to edit
      - A Textbox with the lyrics of the current song

# Error Processing

  No forseeable future, however the HTML has a catch to assure that the song table does not delete itself. 

# Fault Tolerance

  Our fault tolerance will be very relaxed, as it is only following on with a script, and since some users will be used to church they will know most of the words they can beat the song going if our system messes up some data.

# Architectural Feasibility

  We believe our project is feasible. All we need to build our project is a computer with programming tools, which we all have access to as we each own a personal computer. The databases will be combining the components of the project, as the portal and phone applications will have access and use information from the database. This project seems do-able within the time we have to implement it, as it is challenging but not overbearingly difficult.

# Overengineering

  Nothing So far

# Build-vs-Buy Decisions

  We won't be needing to buy anything. Almost all the software for the project will be built by our group. The only aspect that won't be ours is if we integrate a payment service (whether it's Paypal, Apple Pay, or Google Pay), and it would be free of purchase.

# Reuse

  Nothing so far

# Change Strategy

  We may change our paypal plan to iPay, and google pay. This is due to the fact that the PayPal API seems to be out of date.
