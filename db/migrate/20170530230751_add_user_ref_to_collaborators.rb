class AddUserRefToCollaborators < ActiveRecord::Migration
  def change
    add_reference :collaborators, :user, index: true, foreign_key: true
    add_reference :collaborators, :wiki, index: true, foreign_key: true
  end
end
