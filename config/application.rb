# frozen_string_literal: true
require_relative 'boot'

require 'csv'
require 'rails'
require 'active_record/railtie'

Bundler.require(*Rails.groups)

module ApplicationModule
  class Application < Rails::Application

  end
end
