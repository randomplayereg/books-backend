require 'rails_helper'
require 'spec_helper'
include ActionController::RespondWith

describe 'Actions that you can do with Books database', type: :request do
  context 'context: normal user privilages ' do
    before (:each) do
      @current_member = FactoryBot.create(:normal_one)
      login
      @headers = get_auth_params_from_login_response_headers(response)
    end
    it 'lets you create your own book and then edit it and delete it' do
      post "/api/v1/books",
        params: {
          title:  "testing book",
          author: "robot number 1091284539581"
        }.to_json,
        headers: @headers
      expect(response.status).to eq(201)

      put "/api/v1/books/1",
        params: {
          title:  "update",
          author: "robot number 1091284539581"
        }.to_json,
        headers: @headers
      responseData = JSON.parse(response.body)
      expect(responseData["title"]).to eq('update')

      delete "/api/v1/books/1",
        params: {},
        headers: @headers
      expect(response.status).to eq(200)
    end

    it 'doesnt let others edit your books' do
      post "/api/v1/books",
        params: {
          title:  "testing book",
          author: "robot number 1091284539581"
        }.to_json,
        headers: @headers
      expect(response.status).to eq(201)

      @current_member = FactoryBot.create(:another_one)
      login
      headers = get_auth_params_from_login_response_headers(response)
      put "/api/v1/books/1",
        params: {
          title:  "update",
          author: "robot number 1091284539581"
        }.to_json,
        headers: headers
      expect(response.status).to eq(403)

      delete "/api/v1/books/1",
        params: {},
        headers: headers
      expect(response.status).to eq(403)
    end

    it 'except admin' do
      post "/api/v1/books",
        params: {
          title:  "testing book",
          author: "robot number 1091284539581"
        }.to_json,
        headers: @headers
      expect(response.status).to eq(201)

      @current_member = FactoryBot.create(:admin)
      login
      headers = get_auth_params_from_login_response_headers(response)
      put "/api/v1/books/1",
        params: {
          title:  "update",
          author: "robot number 1091284539581"
        }.to_json,
        headers: headers
      responseData = JSON.parse(response.body)
      expect(responseData["title"]).to eq('update')

      delete "/api/v1/books/1",
        params: {},
        headers: headers
      expect(response.status).to eq(200)
    end
  end

  def login
    post "/api/v1/members/sign_in",
      params:  {
        email:    @current_member.email,
        password: '12345678' }.to_json,
      headers: {
        'CONTENT_TYPE'  => 'application/json',
        'ACCEPT'        => 'application/json'
      }
  end

  def get_auth_params_from_login_response_headers(response)
    client = response.headers['client']
    token = response.headers['access-token']
    expiry = response.headers['expiry']
    token_type = response.headers['token-type']
    uid = response.headers['uid']

    auth_params = {
      'access-token' => token,
      'client' => client,
      'uid' => uid,
      'expiry' => expiry,
      'token_type' => token_type,
      'CONTENT_TYPE'  => 'application/json',
      'ACCEPT'        => 'application/json'
    }
    auth_params
  end
end
