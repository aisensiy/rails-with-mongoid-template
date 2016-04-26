require_relative '../rails_helper'

describe 'spec' do
  it 'now we no longer need the full url' do
    get '/productions/index'
    expect_json([])
  end
end
