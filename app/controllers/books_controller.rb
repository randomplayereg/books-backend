class BooksController < ApplicationController
  before_action :set_book, except: [:index, :create]
  before_action :require_login, only: [:update, :destroy, :create, :require_either_admin_or_same_user]
  before_action :require_either_admin_or_same_user, only: [:update, :destroy]


  # GET /books
  def index
    @books = Book.all

    render json: @books
  end

  # GET /books/1
  def show
    render json: @book
  end

  # POST /books
  def create
    @book = Book.new(book_params)

    if @book.save
      render json: @book, status: :created, location: @book
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def book_params
      params.require(:book).permit(:title, :author, :user_id)
    end

    def require_either_admin_or_same_user
      if @book.user_id != current_user.id && current_user.admin == false
        render_unauthorized("Access denied!")
      end
    end
end
