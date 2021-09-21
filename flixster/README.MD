# flixter

flixter is an app that allows users to browse movies from the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

---

## Part 2

### User Stories

#### REQUIRED (10pts)
- [X] (5pts) User can tap a cell to see more details about a particular movie.
- [X] (5pts) User can tap a tab bar button to view a grid layout of Movie Posters using a CollectionView.

#### BONUS
- [X] (2pts) User can tap a poster in the collection view to see a detail screen of that movie.
- [ ] (2pts) In the detail view, when the user taps the poster, a new screen is presented modally where they can view the trailer.

### App Walkthrough GIF

<img src='https://github.com/nlawliet6/iOS-CodePath/blob/main/flixster/demo2.gif?raw=true' title='Video Walkthrough' width='' alt='Video Walkthrough' />

### Notes
- Movie detail view page does not look right in horizontal mode
- Movie trailer controller to be added

## Part 1


#### REQUIRED (10pts)
- [X] (2pts) User sees an app icon on the home screen and a styled launch screen.
- [X] (5pts) User can view and scroll through a list of movies now playing in theaters.
- [X] (3pts) User can view the movie poster image for each movie.

#### BONUS
- [X] (2pt) User can view the app on various device sizes and orientations.
- [ ] (1pt) Run your app on a real device.

### App Walkthrough GIF

<img src='https://github.com/nlawliet6/iOS-CodePath/blob/main/flixster/demo.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

### Notes
Finding the right margins and constraints for the Title and Synopsis labels was a challenge. 
- The title could be 2 lines or longer, which displaces the paragraphs and leaves a space buffer between synopsis and title which isn't visually appealing
- Contraints on the margins of labels require defining label size
- Constraints on text labels are tricky, can't specifiy width and height because the amount of text on them is not defined or constant.

