class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, [Category, Activity]

    can :manage, [Category, Activity], user_id: user.id

    return unless user&.admin?

    can :manage, :all
  end
end
