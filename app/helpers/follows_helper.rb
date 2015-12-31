module FollowsHelper
  def follow_to(user)
    render partial: 'follows/follow', locals: { user: user }
  end
end
