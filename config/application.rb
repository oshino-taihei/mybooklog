require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'amazon/ecs'

Bundler.require(*Rails.groups)

module Mybooklog
  class Application < Rails::Application
    config.i18n.default_locale = :ja
    config.time_zone = 'Tokyo'
    config.active_record.raise_in_transactional_callbacks = true
  end
end
