class Ability
  include CanCan::Ability

  def initialize(user)
    # Guest currentUser (not logged in)
    user ||= User.new

    if user.has_role? :admin
      can :manage, :all
    elsif user.has_role? :advertiser
      can :manage, Campaign, user_id: user.id
    end
  end
end
