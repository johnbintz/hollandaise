# Hollandaise sauce is a delicious delicacy.

    TODO: Easily take a bunch of screenshots using Sauce Labs or with your local browsers
    FIXME: The method for instantiating Sauce Labs Selenium WebDriver browsers
    TODO: Run all the screenshot taking in parallel for SPEEDS
    BUG: Find them and destroy them!

## Preparation and Serving

* `gem install hollandaise`
* Create a ~/.sauce/ondemand.yml with:

    username: my-sauce-labs-username
    access_key: my-secret-access-key

* `hollandaise sauce http://my.cool.website/url/to/test/ browser browser ...`

Browsers! Locally, using Selenium:

* `firefox`
* `chrome`

On Sauce labs:

* `ie7`
* `ie8`
* `ie9`
* `chromewin`
* `ffwin10`

Make more on the `Hollandaise::Browsers` module! All sorts of flavors!

## Adding your own ingredients

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
6. Be *awesome*.
