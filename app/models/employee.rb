class Employee < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
	has_and_belongs_to_many :skills
end
