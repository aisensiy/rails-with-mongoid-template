require_relative '../rails_helper'

describe 'spec' do
  it 'can access production list' do
    get '/productions/index'
    expect_json([])
  end
end
