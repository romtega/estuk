class BooksController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @books = Book.where(availability: true)
    respond_with(@books)
  end

  def show
    respond_with(@book)
  end

  def new
    @book = Book.new
    respond_with(@book)
  end

  def edit
    authorize! :manage, @book
  end

  def create
    @book = current_user.books.new(book_params)
    @book.save
    respond_with(@book)
  end

  def update
    authorize! :manage, @book
    @book.update(book_params)
    respond_with(@book)
  end

  def destroy
    authorize! :manage, @book
    @book.destroy
    respond_with(@book)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:name, :author, :description, :price, :availability, :image, :resource)
    end
end
