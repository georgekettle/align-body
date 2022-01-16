class WorkoutPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def create?
    user.admin?
  end

  def locked?
    return !user.subscribed? if record.membership?
    false
  end

  def unlocked?
    !locked?
  end
end
