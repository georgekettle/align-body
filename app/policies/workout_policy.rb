class WorkoutPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    return user.subscribed? if record.membership?
    true
  end
end
