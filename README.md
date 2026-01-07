# HoustonCMS

A very basic Admin interface

# Setup
run 
````bash 
rails generate houston_cms:install 
````
check migration
````bash
rails db:migrate
````

add .env items 
````
DOMAIN="http://localhost:3000"
APPLICATION_NAME="app.your-site.com"
PUBLIC_STORAGE_SERVICE="public"
````
## Installation

gem "houston_cms"
add admin.scss and add `@import "houston_cms";`
add admin.css to your dartsass builds:
````ruby
# yourapp/config/initializers/dartsass.rb
Rails.application.config.dartsass.builds = {
    "application.scss"        => "application.css",    
     "admin.scss" => "admin.css"
}
````

Add links to sidebar for content items (pages, menus etc): 
```` ruby
HoustonCms::Engine.config.sidebar_content_items <<  {
    name: 'Menus',
    icon: 'bi-menu-app',
    path: '/admin/menus'
  }
 ````
override _app_specific.html.erb to add admin areas for app specific items
````ruby
<ul class="admin-sidebar-menu" >
  <li class="">
    <a href="/admin/savers" class="">
      <i class="bi bi-link-45deg"></i>
      <span class="">Savers</span>
    </a>
  </li> 
</ul>
````
and add it to your routes
````ruby
  namespace :admin do
    resources :savers   
  end
````

TODO: move pages and the polymorphic content tools into houston_cms-content gem
TODO: move the templating for scafolding generators into this gem (houston_cms) 
TODO:  improve template & generators
TODO: add templating documentation- how do you add a set of controllers, views, model to houston_cms admin.  

TODO: Replace `UPDATE_WITH_YOUR_GEM_NAME_IMMEDIATELY_AFTER_RELEASE_TO_RUBYGEMS_ORG` with your gem name right after releasing it to RubyGems.org. Please do not do it earlier due to security reasons. Alternatively, replace this section with instructions to install your gem from git if you don't plan to release to RubyGems.org.

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add UPDATE_WITH_YOUR_GEM_NAME_IMMEDIATELY_AFTER_RELEASE_TO_RUBYGEMS_ORG
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install UPDATE_WITH_YOUR_GEM_NAME_IMMEDIATELY_AFTER_RELEASE_TO_RUBYGEMS_ORG
```

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/asecondwill/HoustonCMS.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).



# todo
is it site_admin or admin, align with launchpad


# debugging pagy
pagy keeps being a problem: 
uninitialized constant Pagy::Frontend errors - have you accidently gone from pagy 9 to pagy 43.  well now its all borked isnt it.  

TODO: snippets need user_id