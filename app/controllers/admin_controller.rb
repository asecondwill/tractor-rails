class AdminController < ApplicationController
  layout 'admin'
  include Pagy::Backend
  before_action :authenticate_admin

  def authenticate_admin        
    redirect_to '/', alert: 'Not authorized.' unless current_user.try(:site_admin)
  end

    

  helper_method :current_user
end
