class List < ActiveRecord::Base
  
  validates :name, :presence => true
  validates_uniqueness_of :name, :on => :create, :message => "must be unique"

  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
  has_many :tasks , :dependent => :destroy

  def done_tasks
     tasks.where(:done => true).order("updated_at DESC")
  end
  
  def self.guest_lists
    where("user_id IS NULL")
  end
end
