# ActionParamsPermitter

[![Code Climate](https://codeclimate.com/github/alterego-labs/action_params_permitter/badges/gpa.svg)](https://codeclimate.com/github/alterego-labs/action_params_permitter)
[![Build Status](https://travis-ci.org/alterego-labs/action_params_permitter.svg)](https://travis-ci.org/alterego-labs/action_params_permitter)
[![Test Coverage](https://codeclimate.com/github/alterego-labs/action_params_permitter/badges/coverage.svg)](https://codeclimate.com/github/alterego-labs/action_params_permitter/coverage)

Strong Parameters are the great idea to keep your models clean. But what
about controllers when form is very complex and
`params.require(:anything).permit!` does not helps?

```ruby
class AnyController
  private

  def permitted_params
    params.permit tutorial: [
      :cost, :hours, :minutes, :seconds,
      steps_attributes: [:id, :description, :order_number, :_destroy],
      tool_ids: [],
      material_ids: [],
      post_attributes: [
        :id, :title, :description, :meta_title, :meta_description,
        :feature, :user_id, tag_list: [], category_ids: []],
        media: [:id, :title, :alt, :_destroy]
    ]
  end

end
```

This code seems not so clean.

`action_params_permitter` gives you a alternative way to do permitting
more clean.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'action_params_permitter', github: 'alterego-labs/action_params_permitter'
```

And then execute:

    $ bundle

## Usage

In general provided DSL looks like follow:

```ruby
SomePermitter = ActionParamsPermitter::Base.new do
  # Your specific rules
end
```

Rules are predefined and their variation are listed below:

1. `resource`
2. `attribute`
3. `attributes`

Nesting is allowed but only for `resource` (which is quite logical). There are some statements about resource rule:

1. _Top level resource_ __always must__ accepts nestings rules otherwise
   exception will be raised.
2. _Top level resource_ may be __required__, but only one otherwise
   exception will be raised.
3. _Nested resource_ may not accepts nestings rules.

Lets define permitter for our example in the top of readme:

```ruby
TutorialsParamsPermitter = ActionParamsPermitter::Base.new do
  resource :tutorial do
    attributes :cost, :hours, :minutes, :seconds
    resource :steps_attributes do
      attributes :id, :description, :order_number, :_destroy
    end
    resource :tool_ids
    resource :material_ids
    resource :post_attributes do
      attributes :id, :title, :description, :meta_title, :meta_description
      attributes :feature, :user_id
      resource :tag_list
      resource :category_ids
    end
    resource :media do
      # Written specially for showing `attribute` rule in work
      attribute :id
      attribute :title
      attribute :alt
      attribute :_destroy
    end
  end
end
```

`TutorialsParamsPermitter` respond to `#permit(params)` method. And now
we may refactor our controller's method like this:

```ruby
class AnyController
  private

  def permitted_params
    TutorialsParamsPermitter.permit(params)
  end
end
```

## Usage with Form Object gems

There are many gems providing form objects, for example `reform`. And if you use a such one `action_params_permitter` is not helps you. Form Object gems inside carries same functional and `action_params_permitter` usage is excessive.

## What about like `params.require(:any_resource).permit!`?

Notice, please, this gem was written only for complex params permitting.
Usage for so simple example is excessive.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/action_params_permitter/action_params_permitter. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

