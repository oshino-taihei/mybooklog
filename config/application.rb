require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'amazon/ecs'

Bundler.require(*Rails.groups)

module Mybooklog
  class Application < Rails::Application
    config.i18n.default_locale = :ja
    config.active_record.raise_in_transactional_callbacks = true

    # amazon-ecs options
    Amazon::Ecs.configure do |options|
      options[:AWS_access_key_id] = ENV['AWS_ACCESS_KEY_ID']
      options[:AWS_secret_key] = ENV['AWS_SECRET_ACCESS_KEY']
      options[:associate_tag] = ENV['AWS_ASSOCIATE_TAG']
    end
  end
end
