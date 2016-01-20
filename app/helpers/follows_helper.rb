module FollowsHelper
  def follow_to(user)
    render 'follows/follow', user: user
  end
end
