# Smart Geo-Tagged Landmarks App

## 1. Project Overview

This project is a Flutter-based Android mobile application developed for the CSE 489 Lab Exam. The application interacts with a faculty-provided REST API to manage and visualize geo-tagged landmarks. Users can view landmarks, visit them using GPS location, add new landmarks with images, and use the application even in offline scenarios.

---

## 2. Features Implemented

### Map View

* Displays all landmarks on an interactive map centered on Bangladesh
* Markers represent each landmark using latitude and longitude
* Marker color reflects score (low to high)
* Clicking a marker shows title and score

### Landmarks List

* Fetches and displays landmarks from API
* Shows title, image, and score
* Supports sorting by score
* Supports filtering by minimum score

### Visit Feature

* Allows users to visit a landmark
* Fetches current GPS location
* Sends visit request to API
* Displays calculated distance returned from server
* Supports offline visit queuing

### Activity (Visit History)

* Displays previously visited landmarks
* Shows landmark name, visit time, and distance

### Add Landmark

* Users can create a new landmark
* Inputs include title, GPS location, and image
* Image is uploaded using multipart/form-data as required by API

### Soft Delete Handling

* Deleted landmarks are not shown in the list
* App handles dynamic data changes without crashing

### Offline Support

* Landmarks are cached locally using Hive
* Cached data is shown when internet is unavailable
* Visit requests are stored offline and synced later when connection is restored

### Error Handling

* Displays success messages using Snackbar
* Handles API errors, network issues, and permission errors gracefully

---

## 3. API Usage

The application uses the faculty-provided REST API:

Base URL:
https://labs.anontech.info/cse489/exm3/api.php

Endpoints used:

* GET: action=get_landmarks
* POST: action=visit_landmark
* POST: action=create_landmark
* POST: action=delete_landmark
* POST: action=restore_landmark

Each request includes a unique student API key.

All dynamic values such as score, distance, and visit count are calculated by the server.

---

## 4. Offline Strategy

* Hive is used for local data storage
* Landmarks fetched from API are cached locally
* When offline:

  * Cached landmarks are displayed
  * Visit requests are stored in a queue
* When internet is restored:

  * Queued visit requests are automatically synchronized with the server

Note:
Map tiles may not load offline as they depend on external tile services.

---

## 5. Architecture Used

The application follows a simple layered architecture:

* UI Layer: Screens and widgets (Map, List, Add, Activity)
* State Management: Provider
* Data Layer:

  * API Service (HTTP requests)
  * Local Storage (Hive)

This structure ensures separation of concerns and maintainability.

---

## 6. Conclusion

This application demonstrates the integration of REST APIs, location services, offline data handling, and user interaction in a complete mobile application. It fulfills all core requirements of the assignment and ensures a smooth user experience both online and offline.
