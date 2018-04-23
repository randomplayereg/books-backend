module Api
  module V1
    class BooksController < ApiController
      before_action :set_book, except: [:index, :create, :total]
      before_action :require_login, only: [:update, :destroy, :create, :require_either_admin_or_same_user]
      before_action :require_either_admin_or_same_user, only: [:update, :destroy]


      # GET /books
      def index
        render json: Book.get_books(params), status: :ok
      end

      # GET /books/1
      def show
        render json: @book
      end

      # POST /books
      def create
        @book = Book.new(book_params)
        @book.user_id = current_user.id
        if @book.save
          render json: @book, status: :created
        else
          render json: @book.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /books/1
      def update
        if @book.update(book_params)
          render json: @book
        else
          render json: @book.errors, status: :unprocessable_entity
        end
      end

      # DELETE /books/1
      def destroy
        @book.destroy
      end

      # GET /books/total
      def total
        render json: {total: Book.count}, status: :ok
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_book
          @book = Book.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def book_params
          params.require(:book).permit(:title, :author, :picture)
        end

        def require_either_admin_or_same_user
          if @book.user_id != current_user.id && current_user.admin == false
            render_unauthorized("Access denied!")
          end
        end
    end
  end
end
