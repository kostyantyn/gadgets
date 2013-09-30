class Product < ActiveRecord::Base
  belongs_to :user

  has_many :pictures, dependent: :destroy
  accepts_nested_attributes_for :pictures, allow_destroy: true, reject_if: :all_blank
end
