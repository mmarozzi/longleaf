# frozen_string_literal: true

RSpec.configure do |config|
  config.before(:each, type: :system) do
    # This help us to see the console logs in the test output
    #
    # it works with:
    #   console.warn()
    #   console.error()
    #
    # example:
    #
    #   uncomment # driven_by :selenium_chrome_headless_with_logs, screen_size: [1400, 1400]
    #
    #   logs = page.driver.browser.logs.get(:browser)
    #   puts logs
    #
    Capybara.register_driver :selenium_chrome_headless_with_logs do |app|
      options = Selenium::WebDriver::Chrome::Options.new(args: ["headless"])

      # Enable browser logging
      options.add_preference(:loggingPrefs, { browser: "ALL" })

      Capybara::Selenium::Driver.new(app, browser: :chrome, options:)
    end

    # default
    driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]

    # for debugging
    # driven_by :selenium_chrome_headless_with_logs, screen_size: [1400, 1400]
    # driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
  end
end
