class SavePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def toggle?
    record.user == user
  end
end
