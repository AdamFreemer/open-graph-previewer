# Open Graph Previewer

## Installation

What you'll need installed:
* Ruby 2.7.0
* Postres (12 or greater)

From your command line:

    $ git clone https://github.com/AdamFreemer/open-graph-previewer.git
    $ cd open-graph-previewer
    $ bundle install
    $ rake db:create;rake db:migrate
    $ rails s

You'll then be able to view the app in your web browser at: 

```
http://localhost:3000
```

## Usage

Simply copy any fully qualified URL, place it in text entry field and click `Submit` or press `Enter`.

The Open Graph image URL along with a preview of image will then be displayed below, if the URL entered has an Open Graph image tag.

## Running Specs

```
$ bundle exec rspec
```

## Design Notes

* A RESTful design approach was taken in the resource / controller design.
* For the view, some basic jquery was used to actively post to the back-end and update the skeleton preview section upon data fetch.
* Nokogiri is used to scrape the page for the og_image tag, with logic to prevent errors when either a tag isn't present, or the tag is present without an actual image url.
* ActiveJob is used to offload the image fetch on the backend to a background job.
* The page resource has 3 fields: `page_url`, `og_image_url` and `processed`.
* `page_url` is the user submitted URL.
* `og_image_url` is the returned open graph image URL if it exists on the submitted page URL.
* `processed` is a boolean that defaults to false on record creation.
* When the Nokogiri job is completed, the field is updated to true.
* If no image URL is returned, a nil value for the `og_image_url` delineates this for the front-end logic.
  