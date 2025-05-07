* redd_clone

* Models

  - User - the main entity that will use this app.
  - Submission - content of some media type that is being the start of discussion.
  - Community - category for Submission.
  - Comments - discussing messages from the members of the app to a particular Submission.
  - Subscription - members declare their interest in notifications from a particular Community.

rails g scaffold Submission title:string body:text url:string media:attachment user:references

rails console
> User.first

Useful extensions for VSCode

  - linter : bundle add standard
  - ruby formatter : gem install solargraph + Ext: solargraph (by Castwide).
  - Ext: Simple Ruby ERB (Victor Ortiz Heredia)
  - Ext: ERB Formatter/Beautify (Ali Ariff) + gem 'htmlbeautifier'
  = Source: https://railsnotes.xyz/blog/vscode-rails-setup

  "emmet.includeLanguages": {
    "ruby": "html",
    "erb": "html",
  },
  "files.associations": {
    "*.html.erb": "erb",
  },
  "vscode-erb-beautify": {
    "tab": true,
    "tabStops": 4,
    "keepBlankLines": 1,
  },
  "[erb]": {
    "editor.tabSize": 4,
  },

Dev notes

  CSS : @apply - allows to use existing css classes to define new css classes.
  - This is a postcss hook.
  - Requires "postcss-import" inside postcss.config file.
  - Debug: in case of doubt check the final app/assets/builds/application.css for correct style generation.

  --- Autoreloding a page on erb changes is vital.
  gem "rails_live_reload"
  bundle install

  create config/initializers/rails_live_reload.rb

  RailsLiveReload.configure do |config|
    # config.url = "/rails/live/reload"

    # Default watched folders & files
    # config.watch %r{app/views/.+\.(erb|haml|slim)$}
    # config.watch %r{(app|vendor)/(assets|javascript)/\w+/(.+\.(css|js|html|png|jpg|ts|jsx)).*}, reload: :always

    # More examples:
    # config.watch %r{app/helpers/.+\.rb}, reload: :always
    # config.watch %r{config/locales/.+\.yml}, reload: :always

    # config.enabled = Rails.env.development?
  end if defined?(RailsLiveReload)

  --- Tailwindcss / responsive design
  It's stupid to do desktop-first designs since tailwind sm: md: etc work with >= breakpoints.
  This means that with sm we work upward and the property will be applied for sized sm and greater.

  Setting accent-indigo-600 on the body of the document will affect all forms on the page.

  * Render with inner yield supplyind the content. Props rendering.
  <% content_for :form_wrap do %>
    ...
  <% end %>
  <%= render "devise/shared/form_wrap" %>

  * Rails provides a back button; which is implemented with JS history.
		<%= link_to "Back", :back, class: 'underline' %>
