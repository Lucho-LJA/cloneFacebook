# CloneFacebook

## Description

CloneFacebook is a Web page about [Odin Projet](https://www.theodinproject.com/lessons/ruby-on-rails-rails-final-project) built with Ruby on Rails. The project is a simple social network similar to facebook where a person can sign up with a email and password or external account of facebook, google or github. The users can post, comment the post, add a friend and like post, comments and receive the notification.

The web page you can see and test online in `CloneFacebook`

## Requeriments

- ruby 3.1.2p20
- rails 7
- Credentials to Auth (Facebook, google and github)
- Credentials to Bucket of AWS

## Instructions

1. Clone the repository with `git clone https://github.com/Lucho-LJA/cloneFacebook.git` 
2. Got to the root folder and run comand `bundle install`
3. Run the command `bundle exec figaro install`
4. Go to the created file config/application.yml and add the credential as this script
```ruby
development:

facebook_api_key: "<API ID OF FB>"
facebook_api_secret: "<API SECRET KEY OF FB>"

google_api_key: "<API ID OF GOOGLE>"
google_api_secret: "<API SECRET KEY OF  GOOGLE>"

github_api_key: "<API ID OF GITHUB>"
github_api_secret: "<API SECRET KEY OF GITHUB>"

aws_api_key: "<API ID OF AWS>"
aws_api_secret: "<API SECRET KEY OF AWS>"
```
5. Run the comand `rails db:create`
6. Run the comand `rails db:migrate`
7. Run the command `rails s`
8. go to: `http://localhost:3000/`