class MemberSerializer < ActiveModel::Serializer
  attributes :id, :email, :book_count, :book_list
  def book_count
    object.books.count
  end
  def book_list
    object.books
  end
end
