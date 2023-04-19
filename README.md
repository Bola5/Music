# Music
## Onboarding
## Requirements
1. Please use the last version from Xcode 13 or bigger

## API
[here](https://developer.apple.com/library/archive/documentation/AudioVideo/Conceptual/iTuneSearchAPI/Searching.html#//apple_ref/doc/uid/TP40017632-CH5-SW1)

## Acceptance Criteria
1. The user to enter the search string and will show a list of matching results
2. The search results must be limited to Denmark.
3. Each result item should display the music track "TrackName", "artWork", "artistName", "Description" and "ReleaseDate".

## Description "PR description"
- The response from the API comes with all of the data except the description not come with the payload when I search using media=music, so as I mentioned before I will use collectionName instead of description [EndPoint](https://itunes.apple.com/search?term=jam&media=music&country=dk&limit=20).
- No storyboards or Xibs files.
- Building the music list with a search bar to allow the user to search for songs and display them in the tableView.
- Every cell contains all of the details beside the info button to display the description in an alert.
- Adding pagination to get all of the music.
- Adding the scroll to top button to help the user to move to the top when he scrolls in the tableView.
- Adding unit tests.

## Project Structure (MVVM)
The project with MVVM structure
- Models - for parsing the response on it
- DataSources(Remote and Local) - for fetch the data from network or database
- LayoutViewModels - for the map from models to be ready to use for the UI
- ViewModels - for handle the business logic
- ViewContoller - for the present the data into the UI controllers
- Unit tests

## Project Diagram
[Diagram](https://lucid.app/lucidchart/2f79dd1b-cd4c-4f80-b303-ab64ef619f95/edit?viewport_loc=-11%2C-11%2C2048%2C1203%2C0_0&invitationId=inv_81b6f980-83f1-41b3-903a-1530b7335265#)

## Video record for the app in run time
[Video](https://www.mediafire.com/file/i4t1jsdug04xzvt/Simulator+Screen+Recording+-+iPhone+14+-+2023-04-19+at+15.00.38.mp4/file)

## Version
1.0
