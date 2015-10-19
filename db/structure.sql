CREATE TABLE users (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  email TEXT NOT NULL,
  username TEXT NOT NULL,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  location TEXT
);

CREATE TABLE users_followers (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  followed_id INTEGER NOT NULL,
  follower_id INTEGER NOT NULL,
  FOREIGN KEY(followed_id) REFERENCES users(id),
  FOREIGN KEY(follower_id) REFERENCES users(id)
);
