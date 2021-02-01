# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
      user ||= User.new # guest user (not logged in)
      if user.admin?
        can :manage, :all
      else
        can :read, :all
      end
      
    alias_action(:create, :read, :update,:delete, to: :crud)

    can   (:crud), Post do |post|
      user == post.user
    end

    can   (:crud), Comment do |comment|
    user == comment.user
    end

  end
end
