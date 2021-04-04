
# Careloop Challenge

This is the application I developed for the challenge for Careloop.

My approach for testing was in-browser.
The idea was to display all information in a clean and somewhat dynamic way, while preserving the seriousness and trustfulness a Health related Product should deliver.
I tried staying near the colour scheme, fonts and style from the Company's website but did not put too much effort in matching it perfectly as I expected to waste quite a bit of time in creating and managing data. 
My biggest challenges was to make it as DRY as possible and to think through on how to set the Database in a uncomplicated, fast and effective way,  and of course the conflict I had while pushing. 
I would say that what took me the most time was actually thinking through some realistic data to be displayed. 
I felt it was overall a great learning experience!

This is the second repository I had to create last time because I had database conflicts with Heroku, as when I created a new rails app I did not set Postgres as the DB and it was demanding too much time to fix that.
The former Repository is [here](https://github.com/jeanmbt/careloop-challenge) in case you want to see the process of creation and the commits and pushes.

My next steps would be to display information for closed days and for 24h days, since it is mostly set up and because of unexpected bugs I didn't find the time to finish it.



The link for the Production version of the Application is [here](https://careloop-challenge.herokuapp.com/) .

# Installing the App Locally

> ruby '2.6.6'

```
mkdir careloop-jean-battirola
cd careloop-jean-battirola
git clone https://github.com/jeanmbt/careloop/
```

* Configuration
```
bundle install
rails db:create db:migrate db:seed
```
 ...
