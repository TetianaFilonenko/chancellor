# Admin
module Admin
  # Controller for managing existing users
  class UsersController < ApplicationController
    respond_to :html

    before_action :find_user, :only => [:destroy, :edit, :show, :update]
    before_action :build_user_entry, :only => [:edit, :update]
    before_action -> { authorize :user }, :except => :show
    before_action -> { authorize @user }, :only => :show

    def edit; end

    def index
      @users = User.all
    end

    def show; end

    def update
      return render :edit unless @user_entry.valid?

      if @user.update_attributes(user_hash)
        redirect_with_notice(
          admin_user_path(@user),
          t('ar.success.messages.updated', :model => t('ar.models.user')))
      else
        render :edit
      end
    end

    protected

    def build_user_entry
      hash =
        @user
        .attributes
        .symbolize_keys
        .slice(:display_name, :first_name, :last_name, :is_active)
      @user_entry = UserEntry.new(hash.merge(user_params))
    end

    def find_user
      @user = User.find(params[:id])
    end

    def user_hash
      @user_entry
        .to_h
        .slice(:display_name, :first_name, :last_name, :is_active)
    end

    def user_params
      params
        .require(:user_entry)
        .permit(:display_name, :first_name, :last_name, :is_active)
    rescue ActionController::ParameterMissing; {}
    end
  end
end
