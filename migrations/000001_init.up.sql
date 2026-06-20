CREATE SCHEMA article;

CREATE TABLE article.users (
    id SERIAL PRIMARY KEY,
    uid VARCHAR(255) NOT NULL UNIQUE,
    display_name VARCHAR(255) NOT NULL,
    email_address VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    photo_url VARCHAR(255)
);

CREATE TABLE article.organizations (
    id SERIAL PRIMARY KEY,
    title_in_ru VARCHAR(255) NOT NULL,
    title_in_en VARCHAR(255) NOT NULL
);


CREATE TABLE article.authors (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL UNIQUE REFERENCES article.users(id),
    last_name_in_ru VARCHAR(255) NOT NULL,
    last_name_in_en VARCHAR(255) NOT NULL,
    first_name_in_ru VARCHAR(255) NOT NULL,
    first_name_in_en VARCHAR(255) NOT NULL,
    middle_name_in_ru VARCHAR(255),
    middle_name_in_en VARCHAR(255),
    organization_id INTEGER NOT NULL REFERENCES article.organizations(id),
    posts TEXT[],
    academic_degree TEXT,
    academic_title TEXT
);