class ToppagesController < ApplicationController
  def index
    search_key = params[:q]
    if search_key
      @groups = Group.where('name like ?', "%#{search_key}%")
    else
      @groups = Group.all
    end
  end
end
