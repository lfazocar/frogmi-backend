# GeoJSON API

This application retrieves earthquake data from the [USGS feed](https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson), stores and processes it so another app can consume it. It can also receive comments sent to the individual features and store them in the database.

### Setup and usage

#### Connect to the database

This app uses PostgreSQL to store the retrieved data and received comments. Connection setup varies depending on environment.

- Development: Set the environment variables `POSTGRES_USER`, `POSTGRES_PASSWORD`, `POSTGRES_HOST` and `POSTGRES_PORT` to the values of your own database.
- Production: Provide a database connection URL in the `POSTGRES_URL` environment variable.

Remember to run `db:migrate` to create the models in the database before use.

#### Update data

To update the earthquake data stored in the database you have to run the task `geojson:month`. This retrieves the current data from the USGS feed and stores the new entries into the database after validating them.

#### Endpoints
- GET /api/features: Receives requests with a query containing the pagination info and magnitude types requested and sends back the corresponding features.
- POST /api/features/:id/comments: Receives requests with a JSON object containing `{ "body": "string" }` (string can't be empty) and stores it in the database associated to the feature in the path.
- GET /api/features/:id/comments: Sends back a JSON with the comments related to the feature.
- GET /api/features/comments: Sends back a JSON with all comments.

### Created with

[Rails 7.1.3](https://rubyonrails.org/)  
[PostgreSQL 16](https://www.postgresql.org/)
