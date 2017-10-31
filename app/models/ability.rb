class Ability
  include CanCan::Ability

  def initialize(user)

    #
    # user ||= User.new # guest user (not logged in)
    # if user.is_admin?
    #   can :manage, :all
    # else
    #   can :read, :all
    # end
    can :manage, Idea do |idea|
      idea.user == user
    end

    can :manage, Review do |review|
      review.user == user
    end
    # cannot :manage, Review do |review|
    #   review.user != user
    # end


  end
end
