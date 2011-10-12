class UserTwin < ActiveRecord::Base
  belongs_to :user, :primary_key => "id"
  belongs_to :twin, :class_name => "User"
end
