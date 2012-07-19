require 'app/app.rb'
require 'capybara/rspec'
require 'vcr'

Capybara.app = HtmlFivePodcatcher
VCR.configure do |c|
  c.ignore_localhost = true
end

feature "Listing all episodes from a given URL", :js => true do
  scenario "responds on /" do
    visit '/'
    page.should have_content("Hello World")
  end
  # scenario "there is a field to enter the URL" do
  #   visit '/'
  #   fill_in 'Podcast URL', :with => "http://rubyrogues.com/feed/"
  # end
end
