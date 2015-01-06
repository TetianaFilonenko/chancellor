# User helper methods.
module UserHelper
  def current_user_block
    content_tag :div, :class => 'foot' do
      if user_signed_in?
        safe_join([
          'Hello ',
          current_user_name,
          break_before(link_to_sign_out)])
      else
        safe_join(['Hello Guest', break_before(link_to_sign_in)])
      end
    end
  end

  def current_user_name
    content_tag :b do
      current_user.email
    end
  end

  def link_to_sign_out
    link_to 'Sign out', '/users/sign_out', :method => :delete
  end

  def link_to_sign_in
    link_to 'Sign in', '/users/sign_in'
  end

  def break_before(content)
    content_tag :br do
      content
    end
  end
end
