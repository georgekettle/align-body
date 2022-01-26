class DailyWorkoutPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        []
      end
    end
  end
end
