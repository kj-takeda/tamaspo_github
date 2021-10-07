require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Tamaspo
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    #バリデーションエラーメッセージ出力時の謎の空白を消す
    config.action_view.field_error_proc = Proc.new { |html_tag, instance| html_tag }
    config.load_defaults 6.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    #テーブルの日時を日本時間で表示
    config.time_zone = 'Tokyo'

    #バリデーションエラーメッセージを日本語に
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.yml').to_s]

  end
end
