class WelcomeController < ApplicationController
  def index
    redirect_to controller: :todos, action: :index if current_user
  end
end
