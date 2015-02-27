RSpec.configure do |config|
  config.before(:suite) do
    Promiscuous.without_promiscuous { DatabaseCleaner.clean_with(:truncation) }
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    Promiscuous.without_promiscuous { DatabaseCleaner.start }
  end

  config.after(:each) do
    Promiscuous.without_promiscuous { DatabaseCleaner.clean }
  end
end
