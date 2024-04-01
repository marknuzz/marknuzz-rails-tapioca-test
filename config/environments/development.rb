# frozen_string_literal: true

require 'active_support/core_ext/integer/time'

Rails.application.configure do
  config.cache_classes = false
  config.eager_load = true
  config.consider_all_requests_local = true
  config.server_timing = true

  config.active_support.deprecation = :log
  config.active_support.disallowed_deprecation = :raise

  # Tell Active Support which deprecation messages to disallow.
  config.active_support.disallowed_deprecation_warnings = []
  config.active_record.migration_error = :page_load
  config.active_record.verbose_query_logs = true

  config.colorize_logging = true

  config.log_level = :debug

end
