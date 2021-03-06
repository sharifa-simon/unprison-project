
-- USER is a reserved keyword with Postgres
-- You must use double quotes in every query that user is in:
-- ex. SELECT * FROM "user";
-- Otherwise you will have errors!


--Create Database named "unprison"


--you need to add these to the user table, the username, hashed password, and isAdmin.

--add the below after all other database tables are created


CREATE TABLE "user" (
  "id" SERIAL PRIMARY KEY,
  "username" VARCHAR(100) UNIQUE NOT NULL,
  "password" VARCHAR(255) NOT NULL,
  "is_admin" BOOLEAN DEFAULT FALSE
);

CREATE TABLE "venue" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR(255) NOT NULL,
  "street_address" VARCHAR(255),
  "city" VARCHAR(255),
  "state" VARCHAR(255),
  "country" VARCHAR(255),
  "zip" VARCHAR(255),
  "venue_type" VARCHAR (100),
  "contact_name_one" VARCHAR(255),
  "contact_phone_one" VARCHAR(255),
  "contact_email_one" VARCHAR(255),
  "contact_position_one" VARCHAR(100),
  "contact_name_two" VARCHAR(255),
  "contact_phone_two" VARCHAR(255),
  "contact_email_two" VARCHAR(255),
  "contact_position_two" VARCHAR(100),
  "contact_name_three" VARCHAR(255),
  "contact_phone_three" VARCHAR(255),
  "contact_email_three" VARCHAR(255),
  "contact_position_three" VARCHAR(100),
  "contact_name_four" VARCHAR(255),
  "contact_phone_four" VARCHAR(255),
  "contact_email_four" VARCHAR(255),
  "contact_position_four" VARCHAR(100)
);

CREATE TABLE "event" (
  "id" SERIAL PRIMARY KEY,
  "venue_id" INT NOT NULL,
  "last_date_contacted" DATE,
  "best_days_week" VARCHAR(255),
  "best_times" VARCHAR(255),
  "proposed_month" VARCHAR(1000),
  "proposed_dates" VARCHAR(1000),
  "confirmed_date" DATE,
  "desired_focus" VARCHAR(1000),
  "total_count" INT,
  "expected_attendance" INT,
  "room_location" VARCHAR(255),
  "actual_attendance" INT,
  "demographics" VARCHAR(255),
  "flyer_mailed" BOOLEAN,
  "flyer_mailed_date" DATE,
  "hear_about" VARCHAR(255),
  "event_notes" VARCHAR
);

CREATE TABLE "travel" (
  "id" SERIAL PRIMARY KEY,
  "event_id" INT NOT NULL,
  "nearest_airport" VARCHAR(255),
  "airport_code" VARCHAR(255),
  "flights_booked" BOOLEAN DEFAULT false,
  "flight_information" VARCHAR(1000),
  "flight_departure" DATE,
  "flight_return" DATE,
  "hotel_booked" BOOLEAN DEFAULT false,
  "hotel_information" VARCHAR(1000),
  "car_booked" BOOLEAN DEFAULT false,
  "car_information" VARCHAR(1000),
  "travel_notes" VARCHAR
);

CREATE TABLE "childrens_books" (
  "id" SERIAL PRIMARY KEY,
  "event_id" INT NOT NULL,
  "books_participating" BOOLEAN,
  "average_age_range" VARCHAR(255),
  "child_form_sent" BOOLEAN,
  "child_form_date_emailed" DATE,
  "child_form_date_returned" DATE,
  "total_mothers_participating" INT,
  "total_children_participating" INT,
  "total_books_needed" INT,
  "books_carryon" BOOLEAN,
  "books_shipped" DATE,
  "program_completed" DATE,
  "prison_prison_baby_donation" VARCHAR(225)
);

CREATE TABLE "reading_glasses" (
  "id" SERIAL PRIMARY KEY,
  "event_id" INT NOT NULL,
  "glasses_participating" BOOLEAN,
  "est_number_partipating" INT,
  "est_population_over_forty" INT,
  "number_glasses_donated" INT,
  "number_glasses_shipped" INT,
  "number_glasses_delivered" INT,
  "date_glasses_shipped" date,
  "date_glasses_delivered" date,
  "received_form" BOOLEAN,
  "glasses_one_half" INT,
  "glasses_two" INT,
  "glasses_two_half" INT,
  "glasses_three" INT
);

CREATE TABLE "public_event" (
  "id" SERIAL PRIMARY KEY,
  "event_id" INT NOT NULL,
  "bio_sent" BOOLEAN,
  "public_event_date_emailed" DATE,
  "public_questionnaire_sent" BOOLEAN,
  "date_questionaire_sent" DATE,
  "date_questionaire_returned" DATE,
  "other_information" VARCHAR(255),
  "book_signing" BOOLEAN,
  "book_sales" BOOLEAN,
  "total_prison_baby_needed" INT,
  "who_orders_books" VARCHAR(255),
  "books_carryon" BOOLEAN,
  "books_shipped" DATE
);

CREATE TABLE "financials" (
  "id" SERIAL PRIMARY KEY,
  "event_id" INT NOT NULL,
  "prison_contribution" NUMERIC,
  "public_event_fee_paid" NUMERIC,
  "public_event_donations" NUMERIC,
  "expenses_travel" NUMERIC,
  "expenses_air" NUMERIC,
  "expenses_hotel" NUMERIC,
  "expenses_car" NUMERIC,
  "expenses_meals" NUMERIC,
  "expenses_supplies" NUMERIC,
  "expenses_printing" NUMERIC,
  "expenses_purchases" NUMERIC,
  "expenses_prep_time_costs" NUMERIC,
  "expenses_staffing_consultants" NUMERIC,
  "financials_notes" VARCHAR
);


ALTER TABLE "event" ADD FOREIGN KEY ("venue_id") REFERENCES "venue" ("id");

ALTER TABLE "travel" ADD FOREIGN KEY ("event_id") REFERENCES "event" ("id");

ALTER TABLE "childrens_books" ADD FOREIGN KEY ("event_id") REFERENCES "event" ("id");

ALTER TABLE "reading_glasses" ADD FOREIGN KEY ("event_id") REFERENCES "event" ("id");

ALTER TABLE "public_event" ADD FOREIGN KEY ("event_id") REFERENCES "event" ("id");

ALTER TABLE "financials" ADD FOREIGN KEY ("event_id") REFERENCES "event" ("id");


ALTER TABLE "public"."childrens_books"
  DROP CONSTRAINT "childrens_books_event_id_fkey",
  ADD CONSTRAINT "childrens_books_event_id_fkey" FOREIGN KEY ("event_id") REFERENCES "public"."event"("id") ON DELETE CASCADE;

ALTER TABLE "public"."event"
  DROP CONSTRAINT "event_venue_id_fkey",
  ADD CONSTRAINT "event_venue_id_fkey" FOREIGN KEY ("venue_id") REFERENCES "public"."venue"("id") ON DELETE CASCADE;

ALTER TABLE "public"."financials"
  DROP CONSTRAINT "financials_event_id_fkey",
  ADD CONSTRAINT "financials_event_id_fkey" FOREIGN KEY ("event_id") REFERENCES "public"."event"("id") ON DELETE CASCADE;


ALTER TABLE "public"."public_event"
  DROP CONSTRAINT "public_event_event_id_fkey",
  ADD CONSTRAINT "public_event_event_id_fkey" FOREIGN KEY ("event_id") REFERENCES "public"."event"("id") ON DELETE CASCADE;

ALTER TABLE "public"."reading_glasses"
  DROP CONSTRAINT "reading_glasses_event_id_fkey",
  ADD CONSTRAINT "reading_glasses_event_id_fkey" FOREIGN KEY ("event_id") REFERENCES "public"."event"("id") ON DELETE CASCADE;

ALTER TABLE "public"."travel"
  DROP CONSTRAINT "travel_event_id_fkey",
  ADD CONSTRAINT "travel_event_id_fkey" FOREIGN KEY ("event_id") REFERENCES "public"."event"("id") ON DELETE CASCADE;


-- The following creates an administrator account which can then add or delete other users.
--Rename 'admin' to your desired username.
--The plaintext "password" you will enter on the login screen is password.
INSERT INTO "user"("username", "password", "is_admin")
VALUES ('admin', '$2b$10$iYJnw61JpnFPllPvdqRPQOc7iGdrLFBmgGiCAGqwFqdAevlIRlMDC', true);
