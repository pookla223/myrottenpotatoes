class ApplicationController < ActionController::Base
  #protect_from_forgery
  before_filter :set_current_user
  protected # prevents method from being invoked by a route
  def set_current_user
    # we exploit the fact that find_by_id(nil) returns nil
    @current_user ||= Moviegoer.find_by_id(session[:user_id])
    if @current_user != nil
      redirect_to login_path and return unless @current_user
    end
  end

  ## somewhat contrived example of an around-filter
  #around_filter :only => ['withdraw_money', 'transfer_money'] do
    ## log who is trying to move money around
    #start = Time.now
    #yield   # do the action
    ## note how long it took
    #logger.info params
    #logger.info (Time.now - start)
  #end
end
