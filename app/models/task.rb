class Task < ActiveRecord::Base
    belongs_to :user, :class_name => "User", :foreign_key => "user_id"
    belongs_to :list, :class_name => "List", :foreign_key => "list_id"
    
    validates :name, :presence => true

    def self.guest_tasks
      where("user_id IS NULL")
    end
end
