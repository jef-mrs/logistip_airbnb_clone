class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  def create?
    true
  end


  def validate?
    true
  end

  def show?
    true
  end

  def update?
    true
  end

  def destroy?
    true
  end
end
