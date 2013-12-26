class ResponsesController < ApplicationController
  
  before_action :signed_in_user, only: [:index]
  before_action :correct_user,   only: [:show, :edit, :update, :destroy]
  
  def new
    @response = signed_in? ? current_user.responses.build : default_user.responses.build
  end
  
  def create
    @response = signed_in? ? current_user.responses.build(response_params) : default_user.responses.build(response_params)
    
    if @response.save
      link = view_context.link_to response_url(@response, :format => :json), @response, :target => "_blank"
      flash[:success] = "JSON is uploaded: #{link}".html_safe
      if !signed_in?
        flash[:notice] = "Please, sign in to see or edit your previously uploaded JSONs.".html_safe
      end
      redirect_to root_url
    else
      render 'new'
    end
  end
  
  def show
    render :json => @response.body, :status => @response.status_code
  end
  
  def index
    @responses = current_user.responses.paginate(page: params[:page], per_page: 20)
  end
  
  def update
    if @response.update_attributes(response_params)
      flash[:success] = 'JSON updated'
      redirect_to responses_url
    else
      render 'edit'
    end
  end
  
  def destroy
    @response.destroy
    redirect_to responses_url    
  end
  
  private
  
  def response_params
    params.require(:response).permit(:title, :body, :status_code, :content_type)
  end
  
  def correct_user
    @response = Response.find_by(id: params[:id])
    redirect_to root_url if !signed_in? && @response.user != default_user
    redirect_to root_url if !current_user == @response.user && !current_user.admin
  end
  
end