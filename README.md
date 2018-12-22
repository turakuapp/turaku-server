# Turaku Server

## Development setup

### Dependencies

1. Ruby.
2. NodeJS.
3. PostgreSQL - On Ubuntu, you'll also need `libpq-dev`.

### Installation

1. Install the version of Ruby specified in [`.ruby-version`](https://github.com/turakuapp/turaku-server/blob/master/.ruby-version) (use [rbenv](https://github.com/rbenv/rbenv) or [rvm](https://rvm.io)).
2. Install the `bundler` gem.
3. Run `bundle install` to fetch dependencies.

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
