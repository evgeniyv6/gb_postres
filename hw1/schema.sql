/*
 * социальная сеть
 * таблицы наполнены через утилиту mock: // mock -a 127.0.0.1 -p 5432 -d mydb -u myuser -w secret tables -t profiles,messages,friendship_statuses,friendship,communities,communities_users -r 10
 * 
 * */



CREATE TABLE users (
  user_id serial not NULL PRIMARY KEY, 
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  phone VARCHAR(100) NOT NULL UNIQUE,
  updated timestamp NOT null default CURRENT_TIMESTAMP
);

CREATE TABLE profiles (
  user_id serial not NULL PRIMARY KEY, 
  gender CHAR(1) NOT NULL,
  birthday DATE,
  photo_id INT,
  status VARCHAR(30),
  city VARCHAR(130),
  country VARCHAR(130),
  updated timestamp NOT null default CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(user_id) ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE messages (
  id serial NOT NULL PRIMARY KEY, 
  from_user_id INT NOT NULL,
  to_user_id INT NOT NULL,
  body TEXT NOT NULL,
  is_important BOOLEAN,
  is_delivered BOOLEAN,
  updated timestamp NOT null default CURRENT_TIMESTAMP,
  FOREIGN KEY (from_user_id) REFERENCES users(user_id),
  FOREIGN KEY (to_user_id) REFERENCES users(user_id)
);

CREATE TABLE friendship_statuses (
  id serial NOT NULL PRIMARY KEY,
  name VARCHAR(150) NOT NULL UNIQUE,
  updated timestamp NOT null default CURRENT_TIMESTAMP
);

CREATE TABLE friendship (
  user_id INT NOT NULL,
  friend_id INT NOT NULL,
  status_id INT NOT NULL,
  requested_at timestamp DEFAULT NOW(),
  confirmed_at timestamp,
  updated timestamp NOT null default CURRENT_TIMESTAMP,  
  PRIMARY KEY (user_id, friend_id),
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (friend_id) REFERENCES users(user_id),
  FOREIGN KEY (status_id) REFERENCES friendship_statuses(id)
);

CREATE TABLE communities (
  id serial NOT NULL PRIMARY KEY,
  name VARCHAR(150) NOT NULL UNIQUE,
  updated timestamp NOT null default CURRENT_TIMESTAMP  
);

CREATE TABLE communities_users (
  community_id INT NOT NULL,
  user_id INT NOT NULL,
  updated timestamp NOT null default CURRENT_TIMESTAMP, 
  PRIMARY KEY (community_id, user_id),
  FOREIGN KEY (community_id) REFERENCES communities(id),
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);
