class Product < ActiveRecord::Base
  belongs_to :user

  has_many :pictures, dependent: :destroy
  accepts_nested_attributes_for :pictures, allow_destroy: true, reject_if: :all_blank

  class << self
    def search(params = {})
      if params.has_key?(:name)
        where('name LIKE ?', "%#{params[:name]}%")
      else
        self
      end
    end
  end
end
