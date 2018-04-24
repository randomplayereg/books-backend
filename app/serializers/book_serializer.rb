class BookSerializer < ActiveModel::Serializer
  attributes :id, :title, :author, :created_at, :updated_at, :picture, :member
  # belongs_to :member
  def member
    {
      "id"        => object.member.id,
      "email"     => object.member.email,
      "book_count"=> object.member.books.count
    }
  end
end
