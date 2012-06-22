
module SampleApp
  module Matchers

    RSpec::Matchers.define :have_error_message do |message|
      match do |page|
        page.should have_selector('div.alert.alert-error', text: message)
      end
    end

    RSpec::Matchers.define :have_title do |title|
      match do |page|
        page.should have_selector('title', text: title)
      end
    end

  end
end
