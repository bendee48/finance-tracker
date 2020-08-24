class FriendshipsController < ApplicationController
  def index
    @friends = current_user.friends
  end

  def create
    friendship = current_user.friendships.build(friend_id: params[:friend])
    if friendship.save
      flash.notice = "You are now friends."
    else
      flash.notice = "Something went wrong."
    end
    redirect_to friends_path
  end

  def search
    if params[:friend].present?
      @users = User.search(params[:friend], current_user)
      if @users.present?
        respond_to do |format|
          format.js { render partial: 'friendships/result' }
        end
      else
        respond_to do |format|
          flash.now.alert = "User not found. Check spelling."
          format.js { render partial: 'friendships/result' }
        end
      end
    else
      respond_to do |format|
        flash.now.alert = "Search field can't be blank."
        format.js { render partial: 'friendships/result' }
      end
    end
  end

  def destroy
    friendship = Friendship.find_by(friend_id: params[:id])
    friendship.destroy
    flash.notice = "Friendship removed."
    redirect_to friends_path
  end
end
