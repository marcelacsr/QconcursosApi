# spec/support/factory_bot.rb
RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.start
  # FactoryBot.lint # strategy: :build, traits: true
  ensure
    DatabaseCleaner.clean
  end
end
