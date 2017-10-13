class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def hello
  	render html: 'chua hieu lam'
  end
end