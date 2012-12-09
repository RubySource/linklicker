class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  protect_from_forgery

  def self.api_controller
    self.responder = ApiResponder
    respond_to :json 
  end
end
