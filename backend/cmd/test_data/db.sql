INSERT INTO users (id, first_name, last_name, email, address) VALUES (1, 'John', 'Doe', 'john.doe@gmail.com', 'Dummy Value 1');
INSERT INTO users (id, first_name, last_name, email, address) VALUES (2, 'Ben', 'Smith', 'ben.smith@gmail.com', 'Dummy Value 2');

INSERT INTO calendars (id, title, description, time_zone, user_id) VALUES (3, 'Work Calendar', 'Dummy Value 3', 'BRT', 1);
INSERT INTO calendars (id, title, description, time_zone, user_id) VALUES (4, 'Family Calendar', 'Dummy Value 4', 'HST', 1);
INSERT INTO calendars (id, title, description, time_zone, user_id) VALUES (5, 'School Calendar', 'Dummy Value 5', 'UTC-8', 2);

INSERT INTO calendar_events (id, title, start_time, end_time, meet_link, calendar_id)
VALUES (6, 'Sprint Review', '2021-02-22 22:30:30', '2021-02-22 23:30:30', 'Dummy Value 6', 3);
INSERT INTO calendar_events (id, title, start_time, end_time, meet_link, calendar_id)
VALUES (7, 'Mobile App Project Review', '2021-02-22 22:30:30', '2021-02-22 23:30:30', 'Dummy Value 7', 5);
INSERT INTO calendar_events (id, title, start_time, end_time, meet_link, calendar_id)
VALUES (8, 'ITAndroids meeting', '2021-02-22 15:30:30', '2021-02-23 16:00:00', 'Dummy Value 8', 5);
