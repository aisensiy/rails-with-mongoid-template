class Production
  include Mongoid::Document
  field :name, type: String
  field :price, type: Float
end
