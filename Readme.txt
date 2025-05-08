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

  --- Adding a new table field
  rails g migration add_username_to_users username:string:uniq
  railg db:migrate

  # Add to application_controller.rb
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    # Needed for customary-added fields to the User resource.
    def configure_permitted_parameters
      added_attrs = [:username]
      devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
      devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    end

  # Add to User model
    validates_uniqueness_of :username
    validates_presence_of :username

  --- Quick User console
  rails c

  --- View renderer has a special directory
  The app/views/application is the last location where Rails will look to find needed things.

    <%= render "basic_layout" %>
    # or equivalently
    <%= render partial: "basic_layout" %>
  
  --- Debugging values in views
  Will nicely format hashes and arrays.
    <%= debug @submissions %>
  
  --- Unique ids for HTML elements
  <div id="<%= dom_id submission %>">

  This enables the Turbo framework to update a specific part of the page in real time.
  In this particular example it will take the entity ID and append it to submission_ string.

  --- Simplify entity paths in views
    <%= link_to submission.title, submission_path(submission) %>
    # to
    <%= link_to submission.title, submission %>
  
  --- Optional CSS class with ERB
		<div class="<%= "pl-4" if submission.media.attached? %>">
  
  --- Resizing the image
  <%= image_tag submission.media, alt: submission.title, class: '' %>
  # to
  <%= image_tag submission.media.variant(resize_to_fit: [200, 200]), alt: submission.title, class: '' %>

  --- Image processing library
  Rails 7 introduced newer image engine and requires vips to be installed.
  homebrew install vips
    -> Will take a lot of dependencies to compile it.
    -> More info: https://stackoverflow.com/a/70849216

  --- Passing variables to partials
    <%= render "form", submission: @submission %>
    # equivalent to
    <%= render "form", locals: { submission: @submission } %>

    Now the form has access to `submission` variable.
  
  --- Clunky passing the user id to update model
    <%= form.hidden_field :user_id, value: current_user.id %>

    But it's better to set inside a controller.
    - First remove the user_id from permitted params.
    - Then set the user_id manually.
      @submission.user = current_user
      # or explicitely
      @submission.user_id = current_user.id
  
  --- If you want delete confirmation you have setup for turbo also
    data: {
      confirm: "Are you sure you want to delete this submission?",
      turbo_confirm: "Are you sure?" }
  
  --- Stimulus : first contact
    In the app/javascript/controllers is the home of all stimulus controllers.
    Short tutorial https://www.youtube.com/watch?v=kCMB3-NHip0