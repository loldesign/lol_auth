# LolAuth
Short description and motivation.

## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'lol_auth'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install lol_auth
```

## Usign Amazon S3

* create the carrierwave initialize at `config/initializers/carrierwave.rb`

```ruby
if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      :provider              => 'AWS',
      :aws_access_key_id     => ENV['S3_ACCESS_KEY_ID'],
      :aws_secret_access_key => ENV['S3_SECRET_KEY']
    }
    config.fog_directory     =  ENV['S3_BUCKET']
  end
end


```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
