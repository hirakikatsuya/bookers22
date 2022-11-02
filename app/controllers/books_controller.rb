class BooksController < ApplicationController
  before_action:is_matching_login_user,only:[:edit,:update]

  def create
    @book=Book.new(book_params)
    @book.user_id=current_user.id
    if @book.save
      flash[:notice]="You have created book successfully"
      redirect_to book_path(@book.id)
    else
      @books=Book.all
      render :index
    end
  end

  def index
    to=Time.current.at_end_of_day
    from=(to - 6.day).at_beginning_of_day
    @books=Book.includes(:favorited_users).
      sort{|a,b|
        b.favorited_users.includes(:favorites).where(created_at:from...to).size<=>
        a.favorited_users.includes(:favorites).where(created_at:from...to).size
      }
    @book=Book.new
  end

  def show
    @book=Book.find(params[:id])
    @booknew=Book.new
    @book_comment=BookComment.new
    @user=@book.user
  end

  def edit
    @book=Book.find(params[:id])
  end

  def update
    @book=Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice]="You have updated book successfully"
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    @book=Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title,:body)
  end

  def is_matching_login_user
    book=Book.find(params[:id])
    unless book.user == current_user
      redirect_to books_path
    end
  end

end