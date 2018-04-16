class BookSerializer < ActiveModel::Serializer
  attributes :id, :title, :author, :created_at, :updated_at, :picture
  belongs_to :user
end
