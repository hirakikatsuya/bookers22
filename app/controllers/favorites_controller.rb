class FavoritesController < ApplicationController

  def create
    @book=Book.find(params[:book_id])
    # メンターから指示された書き方
    favorite=Favorite.new(book_id: @book.id, user_id: current_user.id)
    # だめな書き方
    # favorite=Favorite.new(book_id:book.id)
    # favorite.user_id=current_user.id
    # カリキュラムの書き方
    # favorite = current_user.favorites.new(book_id: book.id)
    favorite.save

  end

  def destroy
    @book=Book.find(params[:book_id])
    # メンターから指示された書き方
    favorite=Favorite.find_by(book_id: @book.id, user_id: current_user.id)
    # だめな書き方
    # favorite=Favorite.find_by(book_id: book.id)
    # favorite.user_id=current_user.id
    # カリキュラムの書き方
    # favorite = current_user.favorites.find_by(book_id: book.id)
    favorite.destroy

  end

end
