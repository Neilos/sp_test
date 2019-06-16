# Log Parsing View and Visit Counter

A script that can process a simple webserver.log of the following format...

```
/help_page/1 126.318.035.038
/contact 184.123.665.067
/home 184.123.665.067
/about/2 444.701.448.104
/help_page/1 929.398.951.889
etc...
```

...and count views and unique visits

## Dependencies

* Ruby - see _.ruby-version_ file for version number
* Gems - Run `bundle` to install

## Usage

- `./bin/parser.rb webserver.log` returns a list of webpages with their page views. The list of paths is ordered from most page views to least page views.
  - e.g.:
  ```
  /home 90 visits
  /index 80 visits
  etc...
  ```

- It also produces a list of webpages with their unique page views. The list of paths is ordered from most unique visits to least unique visits.
  - e.g.:
  ```
  /about/2 8 unique views
  /index 5 unique views
  etc...
  ```

## Specs

To run specs:

```
rspec spec
```
