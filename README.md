# Source Control repository
    https://github.com/AnthonyALu/terminal-application

# Software Development Plan

## Description
    This application is a typing game that will allow users to put their typing skills to the test. In this application, the user will first decide how many words they wish to attempt to type. The game will then output random words for the user to type, repeating until reaching the designated number of words that the user jas cjpsem/ After the designated number of words are attempted, the user will be given their results. These results will include typing speed, accuracy and the top 3 letters that they are most unfamiliar with on the keyboard. Registration will be required to allow for multiple users to play the game on the same computer. Users can then compare their typing speeds with the leaderboards function.

## What will it solve?
    In a world where technology is rapidly developing and working from home is very common, there is a high possibility that the average person will need to know how to use a computer. Using a computer will require some basic skills such as typing and navigating with the mouse, but what if a pandemic occurs and someone who is not familiar with the keyboard is forced to work from home? That person will only be able to work as fast as their fingers will allow them to. Touch-typing refers to the practice of using one's fingers to type with a keyboard without using the keys. It is an extremely useful skill to have as it will not only improve productivity but also concentration and general health. This application will help the user with their touch-typing by testing their typing speed and providing feedback on how fast they type and which keys they struggle with most. On the other hand, this application can also be a fun time-waster for competitive people. 

## Target audience
    The target audience consists of students, workers and anyone looking to increase their typing skills. The internet has contributed to the way we communicate and work significantly. Because of this, the target audience is broad as anyone can benefit from learning to type with better speed and accuracy.

## How do I use this application?
    1. Start the application
    2. Use the keyboard to navigation to 'Register' and press enter
    3. Login using the registered name (case-sensitive)
    4. Press enter on the 'Play' option
    5. Enter how many words you want to type (enter a number from 5-500)
    6. Type the words that appear in the terminal
    7. See results when typing is finished
    8. Play again or log out to check if you have made the leaderboards!


# Features
    - Stores data of multiple users
        - Saves user data each session so that data can be compared with other users. This data will be saved inside a class variable to be accessed to display leaderboards. 
    - User login and registration
        - Prevents multiple users from using the same username and ensures that each unique user will have their own username and statistics
    - Generates random words for you to type
        - Utilises a randomising Ruby gem to generate random words so that the user won't be able to predict what they are required to type. 
    - Receives input from user to check words typed
        - Receives the user input then stores the data to calculate the user's statistics later.
    - Leaderboards for local users
        - Allows local users to compare scores to see who is faster
    - Word count that the user will decide for themselves
        - Some users may prefer to have shorter test while some people would prefer to test their typing over longer periods of time. 
    - Calculates wpm and accuracy - Wpm will be calculated based on characters per minute then multiplied by 2. The reason it is multiplied by 2 is because unlike normal typing tests, this application uses very random words and requires the user to press the enter button once a word is completed. This reduces the user's speed by about half as they must stop to process the next word they are given. 
    - Stats of typing test including typing speed and accuracy
        - Returns the typing speed in words per minute and displays how accurate the user is with their words.
    - Tells the user which letters they are the least efficient with
        - Returns the top letters included in words that they have typed incorrectly. 


