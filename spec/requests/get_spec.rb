require "rails_helper"

describe "return total books is: ", type: :request do
  it "" do
    get ('/api/v1/books/total')
    puts JSON.parse(response.body)["total"]
    expect(response.status).to eql(200)
  end
end
