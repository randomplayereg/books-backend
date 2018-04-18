class Book < ApplicationRecord
   belongs_to :user

   validates :title, presence: true
   validates :author, presence: true
   validates :user_id, presence: true

   mount_base64_uploader :picture, PictureUploader

   def self.get_books(params)
     @books = Book.all
     @books.joins!(:user)
     by_filter(params[:filter_params])
     sort_by(params[:sort_params])
     @books = @books.limit(5).offset((params[:page].to_i - 1) * 5)
     @books
   end

   protected
     def self.by_filter(filter_params) # example: ("title LIKE ?", "Bendtner"), ("id = ?", "12")
       if (filter_params[:attr] != "")
         query = filter_params[:attr] + ' ' + filter_params[:operator] + ' ?'
         @books.where!(query, filter_params[:value])
       end
     end

     def self.sort_by(sort_params) # example: ("title ASC")
       if (sort_params[:attr] != "")
         @books.order!("#{sort_params[:attr]} #{sort_params[:direction]}")
       end
     end
end
