class Book < ApplicationRecord
   belongs_to :member

   validates :title, presence: true
   validates :author, presence: true
   validates :member_id, presence: true

   mount_base64_uploader :picture, PictureUploader

# TODO: edit get book function
   def self.get_books(params)
     @books = Book.all
     # @books.joins!(:member)
     if params[:filter_params].present?
       filter_by(params[:filter_params])
     end
     if params[:sort_params].present?
       sort_by(params[:sort_params])
     end
     @books = @books.limit(5).offset((params[:page].to_i - 1) * 5)
     @books
   end

   protected
     def self.filter_by(filter_params) # example: ("title LIKE ?", "Bendtner"), ("id = ?", "12")
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
