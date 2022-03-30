class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    alias_action :create, :read, :update, :destroy, to: :crud
    alias_action :create, :update, :destroy, to: :cud
    alias_action :create, :read, :update, :destroy, :dashboard, to: :crudd

    if user.admin?
      can :manage, :all
    else
      can :crudd, User, id: user.id
      can :crud, Facility, user_id: user.id
      can :crud, Patient
      can :read, Announcement, user_id: user.id
      can :read, :all
    end
  end
end
