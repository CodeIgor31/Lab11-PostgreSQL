# frozen_string_literal: true

require_relative 'spec_helper'
require_relative 'rails_helper'

# testing PalindromsController
RSpec.describe PalindromsHelper do
  context 'res_array function check' do
    it 'returns correct array' do
      expect(PalindromsHelper.result_array(11)).to eq([0, 1, 2, 3, 11])
      expect(PalindromsHelper.result_array(0)).to eq([0])
      expect(PalindromsHelper.result_array(-1)).to eq([])
    end
  end
end

RSpec.describe PalindromsController, type: :controller do
  describe 'GET index' do
    context 'check index(main) page' do
      it 'has a 200 status code' do
        get :index
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'GET check_page' do
    context 'check check_page' do
      it 'has a 200 status code' do
        get :check_page
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'GET check_exists' do
    context 'check check_exists' do
      it 'has a 200 status code' do
        get :check_exists
        expect(response.status).to eq(302)
      end
    end
  end

  describe 'GET check_xml' do
    context 'check check_data_xml' do
      it 'has a 200 status code' do
        get :check_data_xml
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'GET result' do
    context 'check result(table) page' do
      it 'has a 200 status code' do
        get :result
        expect(response.status).to eq(200)
      end
    end
  end
end

RSpec.describe PalindromsController, type: :request do
  context 'notice message test' do
    it 'return notice message' do
      get '/palindroms/result?num=-1'
      expect(flash[:notice]).to eq('Вводите числа >= 0')
    end
  end

  context 'adding to database' do
    it 'added to db' do
      row = []
      counter = 0
      if Palindrom.where(num: 101).count != 0
        counter += Palindrom.where(num: 101).count
      end
      row << {num: 101}
      Palindrom.insert_all(row)
      expect(Palindrom.where(num: 101).count).to eq(counter+1)
    end

    it 'added dupl to db' do
      row = []
      row << {num: 100}
      Palindrom.insert_all(row)
      expect(Palindrom.where(num: 100).count).to eq(1)
    end
  end

  context 'failed find in database' do
    it 'dont exist in db' do
      expect(Palindrom.where(num: -1).count).to eq(0)
    end
  end
end

RSpec.describe PalindromsController do
  include RSpec::Expectations
  before(:each) do
    @driver = Selenium::WebDriver.for :firefox
    @base_url = 'http://localhost:3000/'
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end

  after(:each) do
    @driver.quit
  end
  
  it 'should give an answer' do
    @driver.get('http://localhost:3000/palindroms/check_page')
    @driver.find_element(:id, 'check').send_keys '100'
    @driver.find_element(:id, 'btn').click
    verify { expect((@driver.find_element(:id, 'count').text)).to eq('6') }
  end

  def verify
    yield
  rescue ExpectationNotMetError => e
    @verification_errors << e
  end
end
