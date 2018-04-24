module Api
  module V2
    class BooksController < Api::V1::BooksController
      # GET /books
      def index
        render json: Book.all, status: :ok
      end

      def create
        @book = Book.new(book_params)
        @book.member_id = current_member.id
        if @book.save
          render json: @book, status: :created
        else
          render json: @book.errors, status: :unprocessable_entity
        end
      end

      private
        def require_login
          authenticate_member!
        end

        def require_either_admin_or_same_user
          debugger
          if @book.member_id != current_member.id && current_member.admin != true
            render json: {message: "You don't have permission!"}, status: :forbidden
          end
        end
    end
  end
end
