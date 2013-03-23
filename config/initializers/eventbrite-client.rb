rails_root = Rails.root || File.dirname(__FILE__) + '/../..'
rails_env = Rails.env || 'development'

eventbrite_config = YAML.load_file(rails_root.to_s + '/config/eventbrite.yml')
eventbrite_config[rails_env]

EVENTBRITE_AUTH_TOKENS = {app_key: eventbrite_config[:app_key], user_key: eventbrite_config[:user_key]}