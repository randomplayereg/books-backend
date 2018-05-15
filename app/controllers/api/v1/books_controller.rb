module Api
  module V1
    class BooksController < ApiController
      before_action :set_book, except: [:index, :create, :total]
      before_action :require_login, only: [:update, :destroy, :create, :require_either_admin_or_same_user]
      before_action :require_either_admin_or_same_user, only: [:update, :destroy]

      # GET /books
      def index
        if params[:filter_params] != nil
          if params[:filter_params][:attr] == "member.email"
            member = Member.find_by(email: params[:filter_params][:value])

            params[:filter_params][:attr] = "member_id"
            params[:filter_params][:operator] = "="
            params[:filter_params][:value] = member.id
          end
        end
        render json: Book.get_books(params), status: :ok
      end

      # GET /books/1
      def show
        render json: @book
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
        render json: {message: "Successfully deleted!"}, status: :ok
      end

      # GET /books/total
      def total
        render json: {total: Book.count}, status: :ok
      end

      private
        def set_book
          @book = Book.find(params[:id])
        end

        def book_params
          params.permit(:title, :author, :picture)
        end

        def require_login
          authenticate_member!
        end

        def require_either_admin_or_same_user
          if @book.member_id != current_member.id && current_member.admin != true
            render json: {message: "You don't have permission!"}, status: :forbidden
          end
        end
    end
  end
end
