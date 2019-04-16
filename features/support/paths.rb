# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name
    
    # ITERATION 2 -- NAVBAR
    when /^Home page$/
      '/'
    when /^All user page$/
      '/users'
    when /^All question page$/
      '/questions'
    when /^Scales page$/
      '/scales'
    when /^All Scenarios page$/
      '/scenarios'
    when /^Help page$/
      '/help'

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
  
  def user_id(user)
    case user
    when /^an Admin$/
      '1000'
    when /^a Decision maker$/
      '1001'
    when /^a Validator$/
      '1003'
    when /^pickle-morty$/
      '1006'
    end
  end
  
end

World(NavigationHelpers)