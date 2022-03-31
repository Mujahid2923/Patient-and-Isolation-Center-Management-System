class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    alias_action :create, :read, :update, :destroy, to: :crud
    alias_action :create, :update, :destroy, to: :cud
    alias_action :create, :read, :update, :destroy, :dashboard, to: :crudd
    alias_action :create, :read, :update, :destroy, :approve, to: :crudp
    alias_action :create, :read, :update, :destroy, :list, :active, :recovered, :transfered, to: :crudlart

    if user.admin?
      can :manage, :all
    else
      can :crudd, User, id: user.id
      can :crud, Facility, user_id: user.id
      can :create, Patient
      can :crudlart, Patient do |patient|
          user.facility_ids.include?(patient.facility_id)
        end
      can :crudp, Transfer
      can :read, Announcement, user_id: user.id
      can :read, :all
    end
  end
end
