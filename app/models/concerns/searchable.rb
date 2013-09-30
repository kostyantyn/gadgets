module Searchable
  extend ActiveSupport::Concern

  def search(params = {})
    if params.has_key?(:name)
      where('name LIKE ?', "%#{params[:name]}%")
    else
      self
    end
  end
end