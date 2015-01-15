# SemanticUserHelper
module SemanticUserHelper
  def semantic_user_block(user, options = nil)
    content_tag :div, options do
      if user_signed_in?
        safe_join(['', user_name(user), ' ', link_to_sign_out])
      else
        safe_join(['Hello Guest', link_to_sign_in])
      end
    end
  end

  def header_user_name(user, options = nil)
    return unless user_signed_in?

    content_tag :div, options do
      safe_join([
        '',
        user_name(user)])
    end
  end

  def user_name(user)
    user.display_name
  end

  def link_to_sign_out
    link_to 'Sign out', '/users/sign_out', :class => '', :method => :delete
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
