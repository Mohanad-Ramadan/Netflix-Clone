
# Introduction:
![Netflix clone](https://i.ibb.co/mbqCHW1/Introduction-Heroheader.jpg)

<br>

# Features:
> ### Content Display
  - Display trending, popular, coming soon, and top media.
  - Dynamic banners showcasing featured content.
    
> ### User Media Persistence
  - Persist user media for watchlists and watched trailer history using CoreData.
  - Add and remove items from the watchlist.
    
> ### Search Functionality
  - Search for movies and TV shows by title.
  - Auto-suggestions as the user types.
    
> ### Detailed Media Information
  - Provide detailed information for each movie or TV show, including synopsis, cast, and ratings.
  - Display trailers and related media with the same genres and topics.
    
> ### Network Monitoring
  - Implement network monitoring to handle connectivity changes seamlessly.
  - Add Loading views and placeholders to effectively handle slow network connections and ensure a smooth user experience.
    
> ### Attractive and Modern UI
  - Design a visually appealing and modern user interface.
  - Ensure a good user experience (UX) with intuitive navigation and interactions.

<br>
  
# Project Screens:
The following screens demonstrate the evolution of the app throughout the build phases. Each screen is presented with versions v1 and v2, showcasing the updates and improvements made during development.


- > ## **Launch Screen:**
  > *Introduced only in v2*
  
  ![](https://i.ibb.co/vsYtZx1/1-copy.png)
  
<br>

- > ## **Home Screen:**
  ![](https://i.ibb.co/gSX3GGs/2-copy.png)

<br>

- > ## **New & Hot Screen:**
  ![](https://i.ibb.co/SJftzGz/3.png)

<br>

- > ## **My Netflix Screen:**
  ![](https://i.ibb.co/WDSTzJR/4.png)

<br>

- > ## **Media Details Screen:**
  ![](https://i.ibb.co/FshjL3g/V1-15x13in.png)

<br>

- > ## **Search Screen:**
  ![](https://i.ibb.co/n6QYYzh/1.png)

<br>

- > ## **Alert Screens:**
  > *Introduced only in v2*
   
  ![](https://i.ibb.co/h13BjCH/ALerts.png)

<br>

# Technology Used:
- **UIKit:** Employed for building user interfaces programmatically without using storyboards.

- **SwiftUI:** Integrated with UIKit to exploit the strengths of both frameworks for a modern and dynamic UI.

- **Concurrency (async/await):** Employed for managing asynchronous networking operations, ensuring smooth and efficient data retrieval.

- **URL Session:** Used for making HTTP network requests.

- **HTTPURLResponse:** Handled HTTP responses from network requests.

- **Network:** Managed network requests and connectivity within the app.

- **Core Data:** Used for persisting user media, such as watchlists and watched trailer history.

- **UIHostingControllers:** Embedded SwiftUI views within UIKit view controllers.

- **Combine:** Utilized for handling asynchronous events and data streams.

- **Delegate and Protocols:** Applied for communication between different parts of the app.

- **Preference Key:** Used to pass data between SwiftUI views.

- **Observation:** Used for observing changes in data and updating the UI accordingly.

- **Path:** Utilized for custom drawing and defining shapes in SwiftUI.

- **Convenience Initializers:** Implemented to create custom objects with default values for clean and reusable code.

- **Access Control:** Used to define the visibility and access levels of classes, methods, and properties.

<br>

# Architecture and Design Pattern:
- **MVVM Architecture:** Adopted MVVM architecture for separating concerns and achieving a scalable and maintainable codebase.
- **Singleton Design Pattern:** Utilized the Singleton design pattern for ensuring a single instance of a class throughout the app's lifecycle, facilitating centralized data access and management.

<br>

# Dependency and API:
- **SDWebImage:** Integrated for efficient asynchronous image loading and caching in the app.
- **YoutubePlayerKit:** Incorporated for seamless playback of YouTube videos within the app.
- **SkeletonView:** Utilized for displaying placeholder loading animations while content is being fetched.
- **TMDB API:** Leveraged for fetching movie and TV show data, including details, images, trailers, and more, using RESTful API endpoints.

<br>

