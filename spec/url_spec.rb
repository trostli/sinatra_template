require_relative '../app/controllers/app'
require 'rack/test'
require 'rspec'

describe 'URL shortening' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "saves a valid URL to DB" do
    url = URL.create(url: "www.google.com")
    expect(url).to be_persisted
  end

  it "does not save an invalid URL to DB" do

  end
end


  # it "validates URL" do
  #   post '/url', {url: 'www.google.com'}
  #   expect(last_resp)

  # describe 'validations' do
  #   it "does not save if you don't provide a title" do
  #     question = Question.create
  #     expect(question).not_to be_persisted
  #   end
  #   it "saves when you do provide a title" do
  #     question = Question.create(title: "foo")
  #     expect(question).to be_persisted
  #   end

  #   it "does not save if the url is invalid"
