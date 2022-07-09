# thisopenspace

## Instructions

1. Run `$ bundle install`
2. Modify and run example script: `$ ruby example.rb`

## Run in console

1. Run `$ bundle install`
2. Open the console: `$ irb`
3. Require API: `require_relative 'lib/api'`
4. Create API instance: `api = API.new`

## Sort

Spaces can be sorted by any attribute. You can provide `descending` parameter:

```ruby
api.sorted(:square_footage, descending: true)
```

## Find similar

Finds places similar to the given one. Attribute name (numeric only) and delta value must be provided:

```ruby
space = api.spaces.first
api.find_similar(space, :square_footage, delta: 100)
```
