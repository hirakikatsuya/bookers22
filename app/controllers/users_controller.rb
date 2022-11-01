class UsersController < ApplicationController
  before_action:is_matching_login_user,only:[:edit,:update]

  def index
    @users=User.all
    @book=Book.new
  end

  def show
    @user=User.find(params[:id])
    @books=@user.books
    @book=Book.new
    @today_book=@books.created_today
    @yesterday_book=@books.created_yesterday
    @two_days_ago_book=@books.created_two_days_ago
    @three_days_ago_book=@books.created_three_days_ago
    @four_days_ago_book=@books.created_four_days_ago
    @five_days_ago_book=@books.created_five_days_ago
    @six_days_ago_book=@books.created_six_days_ago
    @this_week_book=@books.created_this_week
    @last_week_book=@books.created_last_week
  end

  def edit
    @user=User.find(params[:id])
  end

  def update
    @user=User.find(params[:id])
    if @user.update(user_params)
      flash[:notice]="You have updated user successfully"
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  def search_count
    @user = User.find(params[:user_id])
    @books = @user.books
    @book = Book.new
    if params[:created_at] == ""
      @search_book = "年/月/日"#①
    else
      create_at = params[:created_at]
      @search_book = @books.where(['created_at LIKE ? ', "#{create_at}%"]).count#②
    end
  end

  private

  def user_params
    params.require(:user).permit(:name,:introduction,:profile_image)
  end

  def is_matching_login_user
    user=User.find(params[:id])
    unless user == current_user
      redirect_to user_path(current_user)
    end
  end
end
