# TwinMaze

- Stage: Prototype
- Current Status: Not active
- Rails: 3.0
- Ruby:  1.9.2

This a web application which allows to match users' movie tastes with other users and make movie suggestions based on rating of users with similar movie taste.

## From author:

This was my first ruby on rails project. It was never designed or developed for long use, but rather to build a prototype for an idea and learn framework. It wasn't the original intention to open source it, but since my interest shifted I've decided to don't spend time on it.

## What this application can do:

The idea behind the project was quite simple. Users rate movies they've watched, system compares each user to the rest and finds other users with similar movie tastes. After you have your group of matched users (twins) the system calculates individual ratings for each movie in the database based on your twins' ratings. Such algorithm is very simple and gives quite accurate movie ratings, however it needs further improvements as it takes a lot of resources (sql query time) for movie ratings calculation. For ratings calculation and users matching background processing (delayed_job) is used. Movie data can be synchronized from themoviedb.org. Trailers are taken from youtube.com.
