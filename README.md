# Turaku Server

## Development setup

### Dependencies

1. Ruby
2. NodeJS.
3. PostgreSQL - On Ubuntu, install `libpq-dev`.

### Installation

1. Install rbenv.
2. Install Ruby verison specified in the `.ruby-version` file.
3. Install the `bundler` gem.
4. Run `bundle install` to fetch dependencies.

### Configuration

Copy `.env.example` to `.env` and fill in the blanks.

### Database setup

With the database credentials in place (see above), run the following command:

    rails db:setup

This will create the database and seed it with sample data.

### Testing

Run all specs with:

    rails spec

## Deployment instructions

TODO: Add a deploy to Heroku option.
