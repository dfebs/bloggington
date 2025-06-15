# Bloggington

This is a 1-month project started to learn the Ruby ecosystem. 

## Requirements
Ruby Version: 3.2 or newer

## How to Setup and Run
1. `git clone https://github.com/dfebs/bloggington.git`
1. `cd bloggington`
1. `bundle install`
1. `bin/rails db:setup`
1. `bin/rails server`

## Done
- [x] Basic login/logout system
- [x] Dynamically create blog posts with turbo
- [x] Add register page with username/email/password
- [x] Delete own blog posts
- [x] Comment on blog posts
- [x] Add comments with turbo
- [x] Edit (update) posts with turbo
- [x] Edit (update) comments with turbo
- [x] Sort comments by descending
- [x] Sort blog posts by descending
- [x] Profile pictures
- [x] Learn that libvips (or similar) is needed for images embedded in Action Text
- [x] Block users from editing/deleting stuff they don't own
- [x] Delete comments
- [x] Add date to posts and comments
- [x] Default profile pics
- [x] Include profile pics in posts/comments

## Known Bugs (Checkmark indicates fixed)
- [x] You can submit an empty post
- [x] Editing a comment will result in a duplicate "edit comment" button
- [x] Creating comments on front page is a mess

## Todo
- [ ] Add tests

## Nice-to-haves
- [ ] Add reactions to comments or posts
- [ ] Add some formatting to make the site look better
- [ ] Possibly publish this
- [ ] Comment threads (This isn't getting done in this timeline)
- [ ] Add "are you sure" prompt when deleting anything - can be done with stimulus controller
- [ ] Add email verification when registering