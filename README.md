# image-service

GRPC service demonstrating image upload using chunking technique over grpc streams.

![Imgur Image](https://i.imgur.com/uMm3V9k.png)

## Worth noting information about imgur

- read their [rules](https://imgur.com/rules)
- all the images are public
- default cache is 1 year (cache-control=31536000)


## Getting started

1. Generate an application on Imgur API [here](https://api.imgur.com/oauth2/addclient)

2. Create a `.env` at the root of this project with the credentials:
    ```
    IMGUR_CLIENT_ID=xxxxxxx
    IMGUR_CLIENT_SECRET=xxxxxxx
    ```

2. You can find in this repo a simple Makefile that might work by just running `make` if you have the following requirements already installed:
 - make
 - python3
 - [poetry](https://python-poetry.org/docs/#installation)
 - [grpc-tools](https://grpc.io/docs/quickstart/python/)
 - [docker](https://docs.docker.com/install/)
 - [docker-compose](https://docs.docker.com/compose/install/)



## TODO

1. Sync the upload info to a database.
    ```sql
    create database image_service;
    -- \c image_service;
    create table uploads (
        id bigserial primary key,
        upload_id text,
        created_at timestamp default now() not null,
        updated_at timestamp default now() not null,
        imgurl text,
        imgurl_small_square text generated always as (regexp_replace(imgurl, '(.*)(\.\w+)$', '\1s\2')) stored, -- (90x90)
        imgurl_big_square text generated always as (regexp_replace(imgurl, '(.*)(\.\w+)$', '\1b\2')) stored, -- (160x160)
        imgurl_small_thumbnail text generated always as (regexp_replace(imgurl, '(.*)(\.\w+)$', '\1t\2')) stored, -- (160x160)
        imgurl_medium_thumbnail text generated always as (regexp_replace(imgurl, '(.*)(\.\w+)$', '\1m\2')) stored, -- (320x320)
        imgurl_large_thumbnail text generated always as (regexp_replace(imgurl, '(.*)(\.\w+)$', '\1l\2')) stored, -- (640x640)
        imgurl_huge_thumbnail text generated always as (regexp_replace(imgurl, '(.*)(\.\w+)$', '\1h\2')) stored, -- (1024x1024)
        status text,
        upload_response jsonb
    );
    -- create index on upload_id
    ```
