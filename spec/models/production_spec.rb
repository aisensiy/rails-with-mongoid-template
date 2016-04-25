require 'rails_helper'

RSpec.describe Production, type: :model do
  it "should create new production" do
    production = Production.new name: 'test', price: 1.99
    production.save
    refetch = Production.find production.id
    expect(refetch.name).to eq(production.name)
  end
end
