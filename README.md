# Flutter Chat App #
 
This project is backed by Django Rest Framework and Django Channels.
We can add/remove freinds send/receive/decline friend requests.

## Project Requirements ##
    * Python v3.10+
    * Packages in requirements
    * Flutter v3+

## Intructions to Run Project ##
    * Create a python virtual environment.
    * Install all dependencies in requirements.txt file in the root folder.
    * Run django server with 
        * On windows
            * python manage.py runserver 0.0.0.0:8001
        * On Linux/macOs should be same as windows
    * Change IP to the machine's IP where you're running project if flutter not able to send request to server
        * In <flutter_root>/lib/configuration/conf.dart -> baseUrl 
        & <flutter_root>/lib/configuration/websocket_model.dart -> baseUrl 
## Features ##
    * Register/Login User
    * Add/Remove Friends
    * Send message to a user

## Known Issues ##
    * Connect to Server via Websocket.
    * Not able to send/receive messages via websocket directly on both sides. Sometimes it sends messages, sometimes it doesn't.