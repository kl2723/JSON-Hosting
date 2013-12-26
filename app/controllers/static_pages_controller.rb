class StaticPagesController < ApplicationController
  def home
    if signed_in?
      redirect_to new_response_path
    end
  end
end
