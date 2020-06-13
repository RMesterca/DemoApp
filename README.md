# DemoApp
Demo App with MVVM, Pure Layout, Alamofire and no storyboards

1. Main screen that contains:
           1.1. A list of photos showing the title and thumbnail from -  ​https://jsonplaceholder.typicode.com/photos
           1.2. The list should be sorted alphabetically on the title of every photo
2. Detail screen when a user clicks the photo that contains: 
            2.1. Title
            2.2. The image (not thumbnail)
            2.3. A list of the first 20 comments found at https://jsonplaceholder.typicode.com/photos/{id}/comments
3.  Loading state on the main screen
4. Error state on the main screen (i.e. in case of no internet)
5. Pull to refresh on the main screen
6. Pull to refresh on the list of comments found in the detail screen
7. Offline availability of the list of photos:
          7.1. The list should also be available offline after fetching it once
          7.2. The thumbnails are not required to be working when offline
          7.3. Offline data should be maximal 15 minutes old - If older the error state should be shown
