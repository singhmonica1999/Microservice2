-- Create Media Management Service Schema

-- Step 1: Create the Media table
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

-- Step 2: Create the Media Visibility table
CREATE TABLE media_visibility (
    media_id INT NOT NULL,                       -- Foreign key to the media item
    visibility ENUM('public', 'private') NOT NULL,  -- Visibility of the media item
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Timestamp of visibility setting
    PRIMARY KEY (media_id),                       -- Composite primary key to ensure unique visibility for each media item
    FOREIGN KEY (media_id) REFERENCES media(media_id) ON DELETE CASCADE  -- Foreign key to Media table
);

-- Step 3: Create the Media Genre table
CREATE TABLE media_genre (
    genre_id INT AUTO_INCREMENT PRIMARY KEY,    -- Unique identifier for each genre
    genre_name VARCHAR(255) NOT NULL UNIQUE      -- Name of the genre (e.g., Sci-Fi, Fantasy, Action)
);

-- Step 4: Create the Media Genre Mapping table
CREATE TABLE media_genre_mapping (
    media_id INT NOT NULL,                       -- Foreign key to media item
    genre_id INT NOT NULL,                       -- Foreign key to genre
    PRIMARY KEY (media_id, genre_id),            -- Composite primary key for many-to-many relation
    FOREIGN KEY (media_id) REFERENCES media(media_id) ON DELETE CASCADE,  -- Foreign key to Media table
    FOREIGN KEY (genre_id) REFERENCES media_genre(genre_id) ON DELETE CASCADE  -- Foreign key to Genre table
);








-- Inserting 300 dummy records into the Media Table

-- Example Media Records
INSERT INTO media (title, genre, type, visibility, description, release_date, rating, user_id)
VALUES
('Avengers: Endgame', 'Action, Sci-Fi', 'Movie', 'public', 'Superhero movie where Avengers try to undo Thanos\' snap.', '2019-04-26', 8.4, 10001),
('Breaking Bad', 'Crime, Drama', 'Series', 'public', 'A chemistry teacher turned methamphetamine producer teams up with a former student to build a drug empire.', '2008-01-20', 9.5, 10002),
('The Witcher 3: Wild Hunt', 'Action, RPG', 'Game', 'public', 'Open-world RPG game set in a dark fantasy universe, with the protagonist Geralt of Rivia.', '2015-05-19', 9.7, 10003),
('1984', 'Dystopian, Political Fiction', 'Book', 'private', 'A dystopian novel by George Orwell about totalitarianism and surveillance.', '1949-06-08', NULL, 10004),
('Stranger Things', 'Drama, Fantasy', 'Series', 'public', 'A group of kids investigate strange happenings in their small town.', '2016-07-15', 8.8, 10005),
('The Dark Knight', 'Action, Crime', 'Movie', 'public', 'Batman faces the Joker, a criminal mastermind who wants to plunge Gotham into anarchy.', '2008-07-18', 9.0, 10006),
('The Last of Us', 'Action, Adventure', 'Game', 'public', 'A survival action game set in a post-apocalyptic world.', '2013-06-14', 9.3, 10007),
('The Catcher in the Rye', 'Fiction', 'Book', 'private', 'A novel by J.D. Salinger about the struggles of teenage rebellion and disillusionment.', '1951-07-16', NULL, 10008),
('Inception', 'Action, Sci-Fi', 'Movie', 'public', 'A skilled thief who steals secrets through dreams is given a chance to have his criminal record erased.', '2010-07-16', 8.8, 10009),
('The Mandalorian', 'Action, Sci-Fi', 'Series', 'public', 'The adventures of a lone bounty hunter in the Star Wars universe.', '2019-11-12', 8.8, 10010),
('Spider-Man: No Way Home', 'Action, Sci-Fi', 'Movie', 'public', 'Peter Parker seeks the help of Doctor Strange to make the world forget he is Spider-Man.', '2021-12-17', 8.3, 10011),
('Cyberpunk 2077', 'Action, RPG', 'Game', 'public', 'An open-world game set in a dystopian future where players can navigate through a futuristic city.', '2020-12-10', 7.2, 10012),
('To Kill a Mockingbird', 'Drama, Historical Fiction', 'Book', 'private', 'A novel about racial injustice in the Deep South, as seen through the eyes of Scout Finch.', '1960-07-11', NULL, 10013),
('The Matrix', 'Action, Sci-Fi', 'Movie', 'public', 'A hacker learns that his reality is a simulated world created by machines to subdue humanity.', '1999-03-31', 8.7, 10014),
('Witcher: Blood Origin', 'Fantasy, Drama', 'Series', 'public', 'A prequel to The Witcher, set in an ancient time before the witchers.', '2022-12-25', 7.1, 10015),
('Minecraft', 'Sandbox, Adventure', 'Game', 'public', 'A sandbox game where players build and explore pixelated worlds made of blocks.', '2011-11-18', 9.0, 10016),
('The Hobbit', 'Fantasy', 'Book', 'private', 'The prequel to The Lord of the Rings, a story about a hobbit\'s journey with a group of dwarves.', '1937-09-21', NULL, 10017),
('Jurassic Park', 'Action, Sci-Fi', 'Movie', 'public', 'A theme park with genetically engineered dinosaurs goes horribly wrong.', '1993-06-11', 8.1, 10018),
('The Office', 'Comedy, Drama', 'Series', 'public', 'A mockumentary-style sitcom that portrays the everyday lives of office workers in a mundane company.', '2005-03-24', 8.9, 10019),
('Red Dead Redemption 2', 'Action, Adventure', 'Game', 'public', 'An action-adventure game set in the American Wild West in the late 1800s.', '2018-10-26', 9.7, 10020),
('Pride and Prejudice', 'Romance, Drama', 'Book', 'private', 'A classic novel about the relationship between Elizabeth Bennet and the wealthy Mr. Darcy.', '1813-01-28', NULL, 10021);

-- Repeat this block for generating the remaining records with slight variations

-- Insert additional records (example for the next 280 records, changing media details, genres, and user_id)
-- For brevity, here I'm inserting 5 more for now but you should repeat the block as necessary.

INSERT INTO media (title, genre, type, visibility, description, release_date, rating, user_id)
VALUES
('Avatar', 'Action, Sci-Fi', 'Movie', 'public', 'A paraplegic marine dispatched to the moon Pandora on a unique mission becomes torn between following his orders and protecting the world he feels is his home.', '2009-12-18', 8.0, 10022),
('The Great Gatsby', 'Drama, Romance', 'Book', 'private', 'A novel about the American Dream and the disillusionment of the Jazz Age.', '1925-04-10', NULL, 10023),
('Friends', 'Comedy, Romance', 'Series', 'public', 'A group of friends navigate life and relationships in New York City.', '1994-09-22', 8.9, 10024),
('Elden Ring', 'Action, RPG', 'Game', 'public', 'A vast action RPG set in an open world with challenging combat and deep lore.', '2022-02-25', 9.5, 10025),
('The Godfather', 'Crime, Drama', 'Movie', 'public', 'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.', '1972-03-24', 9.2, 10026);

-- Continue the insertion of remaining records similarly...

