rails_root = Rails.root.to_s || File.dirname(__FILE__) + '/../..'
rails_env = Rails.env || 'development'

eventbrite_config = YAML.load_file(rails_root + '/config/eventbrite.yml')
config = eventbrite_config[rails_env]

EventbriteImporter.const_set(:EVENTBRITE_AUTH_TOKENS, {app_key: config['app_key'], user_key: config['user_key']})