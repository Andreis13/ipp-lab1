
# IPP Lab 1

### OAuth provider prototype

This repository contains a Rails app that illustrates the concept of an
OAuth provider in the simplest instance possible and is not intended
for actual use.

There are three routes, for registration, login, and getting the time of
last login. Although the requirements specified that the method GET is
to be used for all routes, I couldn't help it and used the POST method
for registration and login.

| Method | Route             | Params                  | Resulting params | Description                               |
|--------|-------------------|-------------------------|------------------|-------------------------------------------|
| POST   | /oauth/register   | email, password, app_id | code, token      | Registers a user with Email and Password  |
| POST   | /oauth/login      | email, password, app_id | code, token      | Signs In the user with Email and Password |
| GET    | /oauth/last_login | email, app_id, token    | code, time       |                                           |

The app includes a couple of tests to cover the functionality described
above plus some failing cases like invalid input.

### Running the app and tests

- install ruby
- clone the repository
- `cd` to the created folder
- run `bundle install`
- `RAILS_ENV=test rake db:migrate`
- execute `rake test` to run the tests
- to prepare development environment run `RAILS_ENV=development rake db:setup`

### Things to change/add in the theoretical development of such a project.

#### Security measures

Such a service often deals with people's personal information, therefore
it should employ different mechanisms to provide appropriate security.
For instance, it is desirable that the passwords are hashed before being
saved to the database.

#### Input data validation.

In order to provide a service of a decent quality, the whole protocol
should be designed in such a way that if something goes wrong, nothing
explodes to hard. An important part of the protocol is the specification
of input data and the description of what should happen if some or all
of this data is invalid or not present at all. The simplest example is
format validation of an email address.

#### Token expiration.

At the moment the tokens are issued for an unlimited period of time.
In practice it is necessary to invalidate tokens upon the expiration
of some predefined time interval, this would imply the presence of
a background job that would check the database for out-dated tokens.

#### General concept

Perhaps a service that provides only authentication is not very viable
compared to such giants like Google and Facebook, which have as their
main product something else rather then only authentication. Having said
that, I believe that in order to be practical, this app should pe a part
of a bigger system and not a service in itself.
