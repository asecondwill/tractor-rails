# HoustonCMS — Copilot instructions

Purpose: help AI coding agents become productive quickly in this Rails engine.

- **Big picture:** This repo is a Rails engine that mounts itself into a host app under `/admin`.
  - See `lib/houston_cms.rb` (engine class) where routes are prepended and the engine is mounted.
  - The engine provides an admin UI (controllers in `app/controllers/admin`, views in `app/views/admin`).

- **Key integration points**
  - Engine mount and defaults: `lib/houston_cms.rb` (look for `config.after_initialize` and `config.sidebar_content_items`).
  - Host routes: `config/routes.rb` defines the admin namespaced routes used in tests and examples.
  - Initializers: `config/initializers/*` (e.g., `shortcode.rb`) configure global behavior (shortcodes, pagy, etc.).

- **Project dependencies & runtime expectations**
  - The engine requires and uses gems like `pagy`, `friendly_id`, `simple_form`, `ransack`, `shortcode`, `marksmith`, `breadcrumbs_on_rails`, `acts_as_list`, and `ancestry` (see `lib/houston_cms.rb`).
  - Tests and local development assume a typical Rails test setup; use `bin/setup` then `rake test` (README).

- **Assets & CSS workflow**
  - Stylesheets live under `app/assets/stylesheets`. The engine appends its stylesheets path in `lib/houston_cms.rb`.
  - README documents how host apps should wire `admin.scss` into Dartsass builds — prefer updating the host app's `config/initializers/dartsass.rb` as shown.

- **Generators & installation**
  - There is an install generator at `lib/generators/houston_cms/install_generator.rb` — use it as the canonical setup flow.
  - Migrations live under `db/migrate`; host apps must run `rails db:migrate` after installation (README examples).

- **Patterns and conventions to follow**
  - Admin UI code is namespaced under `admin`; add new admin controllers under `app/controllers/admin` and views under `app/views/admin`.
  - Add sidebar items by pushing entries to `HoustonCms::Engine.config.sidebar_content_items` (example in README and `lib/houston_cms.rb`).
  - When adding features that depend on third-party gems, register/require them in the engine's `load_dependencies` initializer (see `lib/houston_cms.rb`).

- **Testing and validation**
  - Run `bin/setup` then `rake test`. Use `bin/console` for interactive debugging inside the gem environment.
  - Prefer small, focused tests that exercise engine routes, controllers, and generators.

- **Release and versioning notes**
  - Bump the version in `lib/houston_cms/version.rb` and use `bundle exec rake release` (README) to publish — follow existing release tasks.

- **Files to inspect for context or examples**
  - `lib/houston_cms.rb` — engine wiring, asset path, dependency loading.
  - `config/routes.rb` — admin routes used by the engine and tests.
  - `config/initializers/shortcode.rb` — shortcode setup example and template binding.
  - `lib/generators/houston_cms/install_generator.rb` — installation flow and templates.
  - `app/views/admin/shared/_admin_custom_head.html.erb` — example of head partials and customization points.

- **What to avoid / gotchas**
  - Do not change the gemspec or version without coordinating release steps; follow `README` release instructions.
  - Asset pipeline and Dartsass configuration must be adjusted in the host app — changes only in the engine may not affect host builds without configuration updates.
  - `pagy` version mismatches have caused runtime errors in the past (see README debugging notes). Confirm compatible `pagy` version when editing pagination code.

If anything here is unclear or you want additional examples (controller, generator, or release steps), tell me which area to expand. I'll iterate on this file.
