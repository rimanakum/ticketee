class Ticket < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  validates :title, presence: true
  validates :description, presence: true
  mount_uploader :asset, AssetUploader
end
