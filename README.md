# developing_data_products_project
Developing Data Products Project: Powerball Number Suggestion based on User Favorite Number

This shiny app helps the user choose the optimal Powerball Numbers given the end user's selection of their favorite number and minimum occurance of valid numbers.

How to use the app:

The app begins assuming that the end user's favorite number is 7.  If the user's favorite number is different than 7, the user enters that number in the text fields in the top left text box, then adjusts the slider bar that limits the minimum occurance of historical powerball numbers.  The app then downloads all historical numbers from the powerball and filters all number sets based on those that include the favorite number.  From this limited set the app suggests the top number occurances from all number sets which historically included the user's favorite number.  This gives you the highest probability of winning given your favorite number is selected.