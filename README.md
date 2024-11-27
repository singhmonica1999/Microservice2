# **Media Management Service**

## **About** 

This microservice is a part of project, '**MediaNest**' - It conveys the idea of a cozy, organized space (a "nest") where users can collect, manage, and track all their favorite media—movies, series, books, and games—in one place. 

It allows users to add, manage, and categorize media items such as movies, series, games, and books, while also controlling their visibility (public or private) and storing relevant metadata.

- **Features**:
  
  - **Add New Media**: Allow users or admins to add new media items with details such as title, genre, description, release year, etc. Each media item will have a `createdBy` field to track which user created it.
  
  - **Public vs. Private Media**: Each media item will have a `visibility` field (public/private) to control whether it's visible to other users or private to the creator.
  - **Media Catalog**: Allow users to browse all available media, including filtering by public/private visibility.
  - **Media Details**: Provide detailed information about each media item, including ratings, reviews, and media format (e.g., digital, DVD).
  - **Notification Triggers**: Whenever a new media item is added that matches the type or genre a user has subscribed to, send notifications to those users.
  
- **Endpoints**:
  
  - **POST /media**: Adds a new media item (movie, series, game, or book) to the system, specifying metadata like title, genre, type, and visibility (public/private).
  - **GET /media/{media_id}**: Retrieves detailed information about a specific media item by its `media_id`.
  - **GET /media**: Retrieves a list of media items with optional filters for type, genre, and pagination.
  - **PUT /media/{media_id}**: Updates the metadata (such as title, genre, type, or visibility) of an existing media item.
  - **DELETE /media/{media_id}**: Deletes a specific media item from the system by its `media_id`.
  - **GET /media/notifications**: Retrieves the notification preferences and registered notifications for the user regarding new public media additions.
  - **POST /media/notifications**: Registers a user to receive notifications when new media of a specific type or genre is added publicly.
  - **GET /media/user/{user_id}**: Retrieves all media items added by a specific user, filtering by visibility (public or private) if required.

---

## **API specification**:

------

### **1. POST /media**

**Description**: Adds a new media item (movie, series, game, or book) to the system.

#### Request:

- **Content-Type**: `application/json`

- Body

  :

  ```json
  {
    "title": "Inception",
    "genre": "Sci-Fi",
    "type": "Movie",
    "visibility": "public",
    "user_id": 10000,
    "description": "A mind-bending thriller",
    "release_date": "2010-07-16",
    "rating": 8.8
  }
  ```

#### Response:

- **Status Code**: `201 Created`

- Body

  :

  ```json
  {
    "message": "Media item created successfully",
    "media_id": 1
  }
  ```

------

### **2. GET /media/{media_id}**

**Description**: Retrieves details of a specific media item by its `media_id`.

#### Request:

- **Content-Type**: `application/json`

#### Response:

- **Status Code**: `200 OK`

- Body

  :

  ```json
  {
    "media_id": 1,
    "title": "Inception",
    "genre": "Sci-Fi",
    "type": "Movie",
    "visibility": "public",
    "user_id": 10000,
    "description": "A mind-bending thriller",
    "release_date": "2010-07-16",
    "rating": 8.8
  }
  ```

------

### **3. GET /media**

**Description**: Retrieves a list of media items with optional filters for type, genre, and pagination.

#### Request:

- **Content-Type**: `application/json`

- Query Parameters

  :

  - `type` (optional): Filter by media type (e.g., "Movie", "Series", "Game", "Book").
  - `genre` (optional): Filter by genre.
  - `page` (optional): The page number for pagination (default: 1).
  - `page_size` (optional): Number of records per page (default: 10).

#### Example Request:

```
GET /media?type=Movie&genre=Sci-Fi&page=1&page_size=10
```

#### Response:

- **Status Code**: `200 OK`

- Body

  :

  ```json
  {
    "page": 1,
    "page_size": 10,
    "total_count": 50,
    "media": [
      {
        "media_id": 1,
        "title": "Inception",
        "genre": "Sci-Fi",
        "type": "Movie",
        "visibility": "public",
        "user_id": 10000,
        "description": "A mind-bending thriller",
        "release_date": "2010-07-16",
        "rating": 8.8
      },
      {
        "media_id": 2,
        "title": "The Matrix",
        "genre": "Sci-Fi",
        "type": "Movie",
        "visibility": "public",
        "user_id": 10001,
        "description": "A computer hacker learns about the true nature of his reality.",
        "release_date": "1999-03-31",
        "rating": 8.7
      }
    ]
  }
  ```

------

### **4. PUT /media/{media_id}**

**Description**: Updates the metadata (title, genre, type, visibility) of an existing media item.

#### Request:

- **Content-Type**: `application/json`

- Body

  :

  ```json
  {
    "title": "Inception - Director's Cut",
    "genre": "Sci-Fi, Thriller",
    "type": "Movie",
    "visibility": "public",
    "description": "A mind-bending thriller with a director's cut version.",
    "release_date": "2010-07-16",
    "rating": 9.0
  }
  ```

#### Response:

- **Status Code**: `200 OK`

- Body

  :

  ```json
  {
    "message": "Media item updated successfully",
    "media_id": 1
  }
  ```

------

### **5. DELETE /media/{media_id}**

**Description**: Deletes a specific media item by its `media_id`.

#### Request:

- **Content-Type**: `application/json`

#### Response:

- **Status Code**: `204 No Content`
- **Body**: None

------

### **6. GET /media/notifications**

**Description**: Retrieves the notification preferences and registered notifications for the user regarding new public media additions.

#### Request:

- **Content-Type**: `application/json`
- **Headers**: `Authorization: Bearer {user_token}`

#### Response:

- **Status Code**: `200 OK`

- Body

  :

  ```json
  {
    "user_id": 10000,
    "notifications": [
      {
        "genre": "Sci-Fi",
        "type": "Movie",
        "enabled": true
      },
      {
        "genre": "Fantasy",
        "type": "Book",
        "enabled": false
      }
    ]
  }
  ```

------

### **7. POST /media/notifications**

**Description**: Registers a user to receive notifications when new media of a specific type or genre is added publicly.

#### Request:

- **Content-Type**: `application/json`

- Body

  :

  ```json
  {
    "genre": "Sci-Fi",
    "type": "Movie",
    "enabled": true
  }
  ```

#### Response:

- **Status Code**: `201 Created`

- Body

  :

  ```json
  {
    "message": "Notification preference added successfully",
    "user_id": 10000,
    "genre": "Sci-Fi",
    "type": "Movie",
    "enabled": true
  }
  ```

------

### **8. GET /media/user/{user_id}**

**Description**: Retrieves all media items added by a specific user, filtering by visibility (public or private).

#### Request:

- **Content-Type**: `application/json`

- Query Parameters

  :

  - `visibility` (optional): Filter by visibility, either `public` or `private`.

#### Example Request:

```
GET /media/user/10000?visibility=public
```

#### Response:

- **Status Code**: `200 OK`

- Body

  :

  ```json
  {
    "user_id": 10000,
    "media": [
      {
        "media_id": 1,
        "title": "Inception",
        "genre": "Sci-Fi",
        "type": "Movie",
        "visibility": "public",
        "user_id": 10000,
        "description": "A mind-bending thriller",
        "release_date": "2010-07-16",
        "rating": 8.8
      }
    ]
  }
  ```

------

### **Additional Considerations**:

- **Authentication**: You may require `Authorization: Bearer {user_token}` for accessing user-related endpoints (like `/media/notifications`, `/media/user/{user_id}`).
- **Error Handling**: Proper error codes (e.g., 400 for bad request, 404 for not found, 500 for internal server error) should be returned for any issues during request processing.

------

## **Database Schema**:

### Updated Database Schema for Media Management Service:

------

### **1. Media Table**

This table stores all media items (movies, series, games, books) along with relevant metadata.

```sql
CREATE TABLE media (
    media_id INT AUTO_INCREMENT PRIMARY KEY,    -- Unique identifier for each media item
    title VARCHAR(255) NOT NULL,                -- Title of the media
    genre VARCHAR(255),                         -- Genre of the media (e.g., Action, Drama, Sci-Fi)
    type ENUM('Movie', 'Series', 'Game', 'Book') NOT NULL,  -- Type of the media
    visibility ENUM('public', 'private') NOT NULL, -- Media visibility (public/private)
    description TEXT,                           -- A detailed description of the media item
    release_date DATE,                          -- Release date of the media item
    rating DECIMAL(3, 2),                       -- Average rating of the media item
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Date when media was created
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,  -- Last updated timestamp
    user_id INT NOT NULL,                       -- Foreign key to Users (from User Management Service)
    FOREIGN KEY (user_id) REFERENCES user_service.users(user_id) ON DELETE CASCADE  -- Link to Users service
);
```

------

### **2. Media Visibility Table**

This table stores the visibility status of media items, either public or private.

```sql
CREATE TABLE media_visibility (
    media_id INT NOT NULL,                       -- Foreign key to the media item
    visibility ENUM('public', 'private') NOT NULL,  -- Visibility of the media item
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Timestamp of visibility setting
    PRIMARY KEY (media_id),                       -- Composite primary key to ensure unique visibility for each media item
    FOREIGN KEY (media_id) REFERENCES media(media_id) ON DELETE CASCADE  -- Foreign key to Media table
);
```

------

### **3. Media Genre Table**

This table stores all possible genres for media items. Media items can belong to multiple genres.

```sql
CREATE TABLE media_genre (
    genre_id INT AUTO_INCREMENT PRIMARY KEY,    -- Unique identifier for each genre
    genre_name VARCHAR(255) NOT NULL UNIQUE      -- Name of the genre (e.g., Sci-Fi, Fantasy, Action)
);
```

------

### **4. Media Genre Mapping Table**

This table is used to map media items to multiple genres in a many-to-many relationship.

```sql
CREATE TABLE media_genre_mapping (
    media_id INT NOT NULL,                       -- Foreign key to media item
    genre_id INT NOT NULL,                       -- Foreign key to genre
    PRIMARY KEY (media_id, genre_id),            -- Composite primary key for many-to-many relation
    FOREIGN KEY (media_id) REFERENCES media(media_id) ON DELETE CASCADE,  -- Foreign key to Media table
    FOREIGN KEY (genre_id) REFERENCES media_genre(genre_id) ON DELETE CASCADE  -- Foreign key to Genre table
);
```

------

### **ER Diagram Overview**:

1. **Media** table is directly linked to **Media Visibility**.
2. **Media Visibility** table links each media item to its visibility status (public/private).
3. **Media Genre Mapping** establishes a many-to-many relationship between **Media** and **Media Genre** tables.
4. **User Management Service** manages user data, and **Media Management Service** manages media data (e.g., `media` table, `media_visibility` table).

------

This updated schema properly isolates user data with **User Management Service** and media data with **Media Management Service**, aligning with microservices principles. 

----

For the **Media Management Service**, you can leverage ActiveMQ for inter-service communication, particularly for sending notifications when a new media is added, and also for handling media visibility updates and tracking user preferences.

### Message Queue Overview

The Media Management Service will interact with other microservices such as **User Management Service** and **Notification Service** through the message queues. Here's a breakdown of how message queues will be used in the system:

### Message Queues & Topics

1. **Topic: `new-media-added`**

   - **Description**: This topic will be used to notify other services whenever a new media item is added to the system (movie, series, book, or game).

   - **Producer**: Media Management Service (specifically when a new media record is created).

   - Consumers

     :

     - **Notification Service**: This will listen to the topic to send notifications to users who have registered for alerts for a specific media type or genre.
     - **User Management Service**: To track the user who added the media and to ensure user preferences for notifications are respected.

   **Message Payload**:

   ```json
   {
     "media_id": "12345",
     "title": "Avengers: Endgame",
     "genre": "Action, Sci-Fi",
     "type": "Movie",
     "release_date": "2019-04-26",
     "visibility": "public",
     "user_id": "10001",
     "genre_notification": ["Action", "Sci-Fi"]
   }
   ```

2. **Topic: `media-visibility-changed`**

   - **Description**: This topic will be used to notify other services whenever the visibility of a media item changes (e.g., from private to public or vice versa).

   - **Producer**: Media Management Service (when a media visibility is updated).

   - Consumers

     :

     - **Notification Service**: To update user notifications or manage alerts if a media item they are interested in changes visibility (for example, if a media item changes from private to public).
     - **User Management Service**: To ensure that user notifications are properly managed and to re-check user preferences.

   **Message Payload**:

   ```json
   {
     "media_id": "12345",
     "new_visibility": "public",
     "previous_visibility": "private",
     "updated_at": "2024-11-27T10:00:00Z"
   }
   ```

3. **Queue: `media-progress-update`**

   - **Description**: Used to track the progress of media consumption. This queue can be consumed by the **Progress Tracking Service** to update user progress as they watch, read, or play media.
   - **Producer**: Progress Tracking Service (whenever a user updates their media progress).
   - **Consumers**: Media Management Service (to check the progress update).
   - This queue is particularly useful for integration with other services, such as showing recommendations based on progress or media history.

   **Message Payload**:

   ```json
   {
     "user_id": "10001",
     "media_id": "12345",
     "progress": "45%",
     "last_watched": "2024-11-27T10:00:00Z"
   }
   ```

4. **Queue: `user-media-preference-update`**

   - **Description**: When a user updates their media preferences (such as opting into notifications for a specific genre or media type), this queue can be used to communicate the changes to the **Notification Service** and **User Management Service**.
   - **Producer**: User Management Service (when a user updates their media preferences).
   - **Consumers**: Notification Service (to store new preferences for notifications), Media Management Service (to handle user preferences and genre-based filtering).

   **Message Payload**:

   ```json
   {
     "user_id": "10001",
     "preferred_genres": ["Action", "Sci-Fi"],
     "opted_in_notifications": true
   }
   ```

### Message Queue Flow Diagram

1. **When a New Media is Added**:
   - The **Media Management Service** creates a new media record and sends a message to the `new-media-added` topic.
   - The **Notification Service** consumes the message and checks if any users have registered for notifications on the media's genre and sends notifications accordingly.
   - The **User Management Service** consumes the message and ensures the user preferences (e.g., visibility, notifications) are respected.
2. **When Media Visibility Changes**:
   - The **Media Management Service** updates the visibility of the media (from private to public or vice versa).
   - A message is sent to the `media-visibility-changed` topic.
   - The **Notification Service** listens for changes and handles the logic for any affected notifications or alerts.
   - The **User Management Service** makes sure the user's settings are respected with regard to the visibility update.
3. **When User Progress is Updated**:
   - The **Progress Tracking Service** sends a message to the `media-progress-update` queue whenever a user updates their progress (such as watching or playing a media item).
   - The **Media Management Service** can check and update relevant media details based on the user's progress.
4. **When User Preferences are Updated**:
   - The **User Management Service** updates the user's media preferences (such as opting into notifications for certain genres).
   - A message is sent to the `user-media-preference-update` queue.
   - The **Notification Service** and **Media Management Service** both consume the message to ensure that the user's preferences are reflected in future notifications and media recommendations.

### Message Queue Benefits

- **Loose Coupling**: The services are decoupled, as they do not directly interact with each other, but rather listen to messages on queues or topics.
- **Asynchronous Communication**: Using message queues allows the services to communicate asynchronously, improving scalability and fault tolerance.
- **Real-Time Updates**: Services can react to changes in real-time, such as when a new media item is added, or when media visibility changes, and take actions such as sending notifications or updating user progress.
- **Scalability**: The message queue system helps to scale the application, especially when traffic increases and many messages need to be handled in parallel.

### Technologies

- **Message Broker**: ActiveMQ (or other message brokers like RabbitMQ, Kafka, etc.)
- **Producers**: Media Management Service, User Management Service, Progress Tracking Service.
- **Consumers**: Notification Service, User Management Service, Media Management Service.

This messaging approach ensures smooth, asynchronous communication between your microservices while keeping the services loosely coupled and highly scalable. Let me know if you need further details or adjustments!

---

## **How to Setup the Project**

**Dependencies**

- Java 17+
- Maven
- MySQL
- MQ



**Steps**

1. Clone the repository
2. Execute: mvn clean install
3. Setup database using the db-setup.sql
4. Run the jar file.

----

## **Contributors**

Thanks to the following contributors for their efforts on this project:

[![Contributors](https://contrib.rocks/image?repo=[singhmonica1999](https://github.com/singhmonica1999)/medianest)](https://github.com/[singhmonica1999](https://github.com/singhmonica1999/medianest/graphs/contributors))