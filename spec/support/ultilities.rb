include ApplicationHelper

Rspec::Matchers.define :have_title do |title|
  match do |page|
    page.should have_selector('title', text: title)
  end
end
