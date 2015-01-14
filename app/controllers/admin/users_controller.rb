# Admin
module Admin
  # Controller for managing existing users
  class UsersController < ApplicationController
    respond_to :html

    before_action :load_user, :only => [:destroy, :edit, :show, :update]
    before_action -> { authorize :user }, :except => :show
    before_action -> { authorize @user }, :only => :show

    def edit; end

    def index
      @users = User.all
    end

    def show
    end

    def update
      if @user.update_attributes(user_params)
        redirect_with_notice(
          admin_users_path(@entity),
          t('activerecord.successful.messages.updated',
            :model => @user.class.model_name.human))
      else
        render :edit
      end
    end

    protected

    def load_user
      @user = User.find(params[:id])
    end

    def user_params
      params
        .require(:user)
        .permit(:display_name, :first_name, :last_name, :is_active)
    rescue ActionController::ParameterMissing; {}
    end
  end
end
