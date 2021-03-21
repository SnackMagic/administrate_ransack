# Administrate Ransack [![Gem Version](https://badge.fury.io/rb/administrate_ransack.svg)](https://badge.fury.io/rb/administrate_ransack) [![CircleCI](https://circleci.com/gh/blocknotes/administrate_ransack.svg?style=svg)](https://circleci.com/gh/blocknotes/administrate_ransack)
A plugin for [Administrate](https://github.com/thoughtbot/administrate) to use [Ransack](https://github.com/activerecord-hackery/ransack) for filtering resources.

Features:
- add Ransack method via module prepend in controller;
- offer a filters bar based on the resource's attributes;
- customize searchable attributes.

## Installation
- After installing Administrate, add to *Gemfile*: `gem 'administrate_ransack'` (and execute `bundle`)
- Edit your admin resource controller adding inside the class body:
```rb
prepend AdministrateRansack::Searchable
```
- Add to your resource index view:
```erb
<%= render('administrate_ransack/filters', attribute_types: page.attribute_types) %>
```

## Usage
For associations (has many/belongs to) the label used can be customized adding an `admin_label` method to the target model which returns a string while the collection can by filtered with `admin_scope`.

Example:
```rb
class Post < ApplicationRecord
  scope :admin_scope, -> { where(published: true) }

  def admin_label
    title.upcase
  end
end
```

## Notes
- Administrate Search input works independently from Ransack searches, I suggest to disable it eventually
- Ordering by clicking on the headers of the table preserving the Ransack searches requires a change to the headers links, replacing the th links of *_collection* partial with:
```rb
sort_link(@ransack_results, attr_name) do
# ...
```

## Customizations
- Allow only some fields for the filters in the index view:
```erb
<%
attribute_types = {
  title: Administrate::Field::String,
  author: Administrate::Field::BelongsTo,
  published: Administrate::Field::Boolean
}
attribute_labels = {
  author: 'Written by',
  title: nil
}
%>
<%= render(
  'administrate_ransack/filters',
  attribute_types: attribute_types,
  attribute_labels: attribute_labels
) %>
```
- Optional basic style to setup the filters as a sidebar:
```css
.main-content__body {
  display: inline-block;
  width: calc(100% - 320px);
  vertical-align: top;
}

[data-administrate-ransack-filters] {
  display: inline-block;
  padding-left: 10px;
  padding-top: 10px;
  width: 300px;
}

[data-administrate-ransack-filters] .filter {
  margin-bottom: 10px;
}

[data-administrate-ransack-filters] .filters-buttons {
  margin-top: 30px;
}
```

Screenshot:
![screenshot](screenshot.png)

## Do you like it? Star it!
If you use this component just star it. A developer is more motivated to improve a project when there is some interest.

Or consider offering me a coffee, it's a small thing but it is greatly appreciated: [about me](https://www.blocknot.es/about-me).

## Contributors
- [Mattia Roccoberton](https://blocknot.es/): author

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
