class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :book_count
  def book_count
    object.books.count
  end
end
