# Flicks
iOS bootcamp 2017 project 1

This is an iOS demo application for displaying the latest box office movies using the [The Movie Database API](https://www.themoviedb.org/documentation/api).

Time spent: 13 hours spent in total

Completed user stories:

 * [x] Required: User can view a list of movies currently playing in theaters from The Movie Database.
 * [x] Required: User can click on a movie in the list to bring up a details page with additional information such as synopsis
 * [x] Required: User sees loading state while waiting for movies API.
 * [x] Required: User sees an error message when there's a networking error. You may not use UIAlertController or a 3rd party library to display the error. 
 * [x] Required: User can pull to refresh the movie list.
 * [x] Optional: Add a tab bar for Now Playing or Top Rated movies, used customized icons from [iconfinder](https://www.iconfinder.com/).
 * [ ] Optional: Implement a UISegmentedControl to switch between a list view and a grid view. 
 * [ ] Optional: Add a search bar.
 * [x] Optional: Placeholder image is used for movie posters loaded in from the network
 * [x] Optional: Customized tableViewCell background, selection effect. 
 
Notes:

I was getting error "cannot convert value of type'(String) -> Bool' to expected argument type '(NSDictionary) -> Bool', I am not sure how to pass a 'NSDictionary' type for matching, since I am comparing the searchText with the movie["title"] which are both String type.

```
filteredData = searchText!.isEmpty ? movies : movies?.filter { (title: String) -> Bool in
            return title.range(of: searchText!, options: .caseInsensitive, range: nil, locale: nil) != nil
```

Walkthrough of all user stories:

![Video Walkthrough](Flicks.gif)

GIF created with [LiceCap](http://www.cockos.com/licecap/).
