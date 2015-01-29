# Admin
module Admin
  # Controller for adding and removing user roles.
  class RolesController < ApplicationController
    respond_to :html

    before_action :load_user, :only => [:create, :destroy, :new]
    before_action :create_grant_role, :only => [:create, :new]
    before_action -> { authorize :user, :edit? }

    def create
      if @grant.save
        redirect_with_notice(
          admin_users_path(@grant.user),
          t('app.admin.grant_role.success',
            :role_name => @grant.name, :user_name => @grant.user.display_name))
      else
        render :new
      end
    end

    def destroy
      if @user.remove_role params[:role_name]
        translation_key = 'app.admin.revoke_role.success'
      else
        translation_key = 'app.admin.revoke_role.failure'
      end

      redirect_with_notice(
        admin_users_path(@user),
        t(translation_key,
          :role_name => params[:role_name], :user_name => @user.display_name))
    end

    def new; end

    protected

    def create_grant_role
      @grant = GrantRole.new(user_role_params.merge(:user => @user))
    end

    def load_user
      @user = User.find(params[:user_id])
    end

    def user_role_params
      params.require(:grant_role).permit(:name)
    rescue ActionController::ParameterMissing; {}
    end
  end
end
