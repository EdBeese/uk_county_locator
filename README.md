# UK County Locator

## Overview

`UkCountyLocator` is a Ruby gem that determines the county of a given set of coordinates within the UK. It supports multiple county classification types, including ceremonial, historic, and current administrative boundaries. The gem also provides functionality for retrieving county boundary polygons.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'uk_county_locator'
```

Then execute:

```sh
bundle install
```

Or install it manually:

```sh
gem install uk_county_locator
```

## Usage

### Finding a County by Coordinates

```ruby
require 'uk_county_locator'

lat = 51.5074
lng = -0.1278

county = UkCountyLocator.find_county(lat: lat, lng: lng)
puts county # => "Greater London"
```
By default, the gem will return the Ceremonial County of the coordinates.

An optional `type` argument, which will accept the following supported county types:

- `:current` – Modern administrative counties and Unitary Authorities
- `:ceremonial` – Traditional ceremonial counties
- `:historic` – Historic counties
- `:all` – Includes all available types

Assuming the same coordinates above:

```ruby
county_data = UkCountyLocator.find_county(lat: 51.5074, lng: -0.1278, type: :all)
puts county_data
# => {:current_county_or_unitary_authority=>"Westminster", :ceremonial_county=>"Greater London", :historic_county=>"Middlesex"}
```
### Fetching County Boundaries
The polygons are stored as encoded strings, using the [Polylines Gem](https://github.com/joshuaclayton/polylines).

You can retrieve the encoded string, which can then be decoded using the Polylines Gem.

```ruby
polygon = UkCountyLocator.find_polygon(county: 'Greater London', type: :ceremonial)
puts polygon # => "iah@mrgyHs@tTkk@zc@jz@h{@kLnr@jo@rWal@}Rrk@za@UjMdhAb_@t|Bjn@`h@|mAzs@kMl\\h..."
```

The gem will support a number of common aliases for county names, in as far as is feasible, including shorthand abbreviations, such as 'Herts', 'Beds' and 'Bucks', as well as Welsh, Irish and Scots Gaelic languages, and more subtle alternative names.

```ruby
polygon = UkCountyLocator.find_polygon(county: 'Londonderry', type: :ceremonial)
puts polygon # => "lhhk@geboIEHA?????_eAtQi`CtL}_..."

polygon = UkCountyLocator.find_polygon(county: 'Derry', type: :ceremonial)
puts polygon # => "lhhk@geboIEHA?????_eAtQi`CtL}_..."

polygon = UkCountyLocator.find_polygon(county: 'derry', type: :ceremonial)
puts polygon # => "lhhk@geboIEHA?????_eAtQi`CtL}_..."

polygon = UkCountyLocator.find_polygon(county: 'Co Derry', type: :ceremonial)
puts polygon # => "lhhk@geboIEHA?????_eAtQi`CtL}_..."

polygon = UkCountyLocator.find_polygon(county: 'Contae Dhoire', type: :ceremonial)
puts polygon # => "lhhk@geboIEHA?????_eAtQi`CtL}_..."
```

#### Fetching the County List

It is also possible to fetch the list of counties, per type (alphabetised):
```ruby
county_list = UkCountyLocator.county_list(type: :ceremonial)
puts county_list # => ["Bedfordshire", "Berkshire", "Bristol", "Buckinghamshire", "Cambridgeshire", ...]
```

## Errors & Rescues
The gem is able to sanitize data inputs to a point, and where invalid arguments are passed in, it is designed to error loudly.

For example, string numeric values can be passed in:
```ruby
county = UkCountyLocator.find_county(lat: '51.5074', lng: '-0.1278')
puts county # => "Greater London"

county = UkCountyLocator.find_county(lat: 'foo', lng: 'bar')
# => UkCountyLocator::InvalidArgumentError (Invalid lat format: 'foo')

county = UkCountyLocator.find_county(lat: :foo, lng: :bar)
# => UkCountyLocator::InvalidArgumentError (Expected lat to be Numeric or a String, got Symbol)

county = UkCountyLocator.find_county(lat: nil, lng: nil)
# => UkCountyLocator::InvalidArgumentError (Expected lat to be Numeric or a String, got NilClass)

county = UkCountyLocator.find_county(lat: 51.5074, lng: -0.1278, type: 'Ceremonial')
puts county # => "Greater London"

county = UkCountyLocator.find_county(lat: 51.5074, lng: -0.1278, type: :postal)
# => UkCountyLocator::InvalidArgumentError (Invalid input: type must be one of :current, :ceremonial, :historic., or :all, got postal)

polygon = UkCountyLocator.find_polygon(county: 123)
# => UkCountyLocator::InvalidArgumentError (Expected county to be a String, got Integer)

polygon = UkCountyLocator.find_polygon(county: nil)
# => UkCountyLocator::InvalidArgumentError (Expected county to be a String, got NilClass)

county_list = UkCountyLocator.county_list(type: 'foo')
# => UkCountyLocator::InvalidArgumentError (Invalid input: type must be one of :current, :ceremonial, :historic., got foo)
```
Note that the gem will infer the `:ceremonial` `:type` if an explicit `nil` value passed in:
```ruby
county = UkCountyLocator.find_county(lat: 51.5074, lng: -0.1278, type: nil)
puts county # => "Greater London"

polygon = UkCountyLocator.find_polygon(county: 'Greater London', type: nil)
puts polygon # => "iah@mrgyHs@tTkk@zc@jz@h{@kLnr@jo@rWal@}Rrk@za@UjMdhAb_@t|Bjn@`h@|mAzs@kMl\\h..."

county_list = UkCountyLocator.county_list(type: nil)
puts county_list # => ["Bedfordshire", "Berkshire", "Bristol", "Buckinghamshire", "Cambridgeshire", ...]
```

## County Type Definitions
There are three sets of county data within the gem.  The definitions between the three sets will differ between the four constituent countries of the United Kingdom, but are defined as per these Wikipedia links:

### Ceremonial Counties `type: :ceremonial`
#### England
[Ceremonial counties of England](https://en.wikipedia.org/wiki/Ceremonial_counties_of_England)
#### Wales
[Preserved Counties of Wales](https://en.wikipedia.org/wiki/Preserved_counties_of_Wales)
#### Scotland
[Local government areas of Scotland (1975–1996)](https://en.wikipedia.org/wiki/Local_government_areas_of_Scotland_(1975%E2%80%931996))
#### Northern Ireland
[Counties of Northern Ireland](https://en.wikipedia.org/wiki/Counties_of_Northern_Ireland)
### Current Counties & Unitary Authorities `type: :current`
#### England
This is a combined map of the different current administrative areas, namely:

[County Councils](https://en.wikipedia.org/wiki/List_of_county_councils_in_England)

[Unitary Authorities](https://en.wikipedia.org/wiki/Unitary_authorities_of_England)

[Metropolitan Boroughs](https://en.wikipedia.org/wiki/Metropolitan_borough)

[London Boroughs](https://en.wikipedia.org/wiki/London_boroughs)
#### Wales
[Welsh Local Authorities](https://en.wikipedia.org/wiki/Local_government_in_Wales)
#### Scotland
[Council Areas of Scotland](https://simple.wikipedia.org/wiki/Council_areas_of_Scotland)
#### Northern Ireland
[Local Government Districts of Northern Ireland](https://en.wikipedia.org/wiki/Local_government_in_Northern_Ireland)
### Historic Counties `type: :historic`
#### England
[Historic Counties of England](https://en.wikipedia.org/wiki/Historic_counties_of_England)
#### Wales
[Historic Counties of Wales](https://en.wikipedia.org/wiki/Historic_counties_of_Wales)
#### Scotland
[Shire Counties of Scotland (1889-1975)](https://en.wikipedia.org/wiki/Shires_of_Scotland#Counties_from_1889_to_1975)
#### Northern Ireland
[Counties of Northern Ireland](https://en.wikipedia.org/wiki/Counties_of_Northern_Ireland)

## Considerations & Limitations
### Single Polygon Shapes
It should be noted that this gem stores the county polygons as encoded strings.  In order for these to be encoded, a polygon must be one, continuous shape, rather than a collection of separate, unconnected polygons.

To this end, the polygons may cover areas of water that connect separated land masses, such as islands.

See image of Orkney Islands polygon:

![Image of Orkney Islands Polygon](https://res.cloudinary.com/dnhuvsfil/image/upload/v1740658412/Screenshot_from_2025-02-27_11-24-31_gquyhu.png)


### Rivers, Tributaries and Coastal Lines
In order to compress the polygon areas, the boundaries that cover coastal lines have been more roughly drawn, with fewer coordinate points.  The polygons are continuous where larger rivers and tributaries cut into a county area that falls on both sides of said river.  This means that coordinates that fall in the river will return the county as a result.

For example, coordinates that fall within the river Thames, where Greater London is on both sides of the river, will return 'Greater London' as the ceremonial county.

![Excerpt of Greater London Polygon](https://res.cloudinary.com/dnhuvsfil/image/upload/v1740658346/london_ektehn.png)

This means that the gem would not be an appropriate tool to verify that given coordinates are within the land masses of the UK.

## Data Sources
The data to compile these polygon areas has been taken from a number of sources, including:
- [OpenStreetMap](https://www.openstreetmap.org/)
- [Office of National Statistics (ONS)](https://www.ons.gov.uk/aboutus)
- [UK Ceremonial Counties](https://github.com/evansd/uk-ceremonial-counties/blob/master/uk-ceremonial-counties.geojson)
- [The Association of British Counties](https://abcounties.com/)

## Performance Optimization

The gem utilizes the `Parallel` gem to speed up polygon lookups.

## Compatibility

The gem is tested against multiple versions of Rails using Appraisal, ensuring broad compatibility with different Ruby on Rails applications.

## Contributing

### Polygon Mapping
The polygons included within this gem have been generated using the data sources listed above, within an acceptable tollerance of accuracy.  However, there may be small errors at the boundaries of polygons.

If such an error is noted, pull requests to update the polygons are welcome.  Please include details of the area(s) that has been altered within a PR, in order to more efficiently confirm accuracy.

### Submitting Fixes and Improvements
These and all other bug reports and pull requests are welcome on GitHub.

1. Fork the repository
2. Create a new branch (`git checkout -b feature-branch`)
3. Commit your changes (`git commit -m 'Add new feature'`)
4. Push to the branch (`git push origin feature-branch`)
5. Create a new Pull Request

## License

This project is licensed under the MIT License.