class WikiPolicy < ApplicationPolicy

def index?
    true
end

def show?
    user.present?
end

def new?
    user.present?
end

def create?
    user.admin? or user.premium?
end

def update?
    user.present?
end

def edit?
    user.present?
end

def destroy?
    user.admin?
end


end