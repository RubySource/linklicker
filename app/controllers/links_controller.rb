class LinksController < ApplicationController
  respond_to :json
  rescue_from ActiveRecord::RecordNotFound, :with => :not_found
  api_controller

  def index
    if params[:licked]
      @links = current_user.licked_links
    elsif params[:all]
      @links = Link.all
    else
      ids = current_user.licks.empty? ? -1 : current_user.licks.map(&:link_id)
      @links = Link.where("id not in (?)", ids )
    end
    respond_with(@links)
  end

  def create
    params[:link][:user_id] = current_user.id
    @link = Link.create!(link_params)
    respond_with(@link, location: links_url, status: :created)
  end

  def destroy
    link = current_user.links.find(params[:id])  
    link.destroy
    respond_with({status: :ok}, status: :deleted)
  end

  def lick
    link = Link.find(params[:id])
    ## yeah, yeah, should put a context here or something
    lick = current_user.licks.create!(link: link)
    respond_with(link)
  end

  def unlick
    lick = current_user.licks.where(link_id: params[:id]).first
    lick.destroy if lick
    render status: 200, text: :ok, location: links_url, format: :json
  end

  private

  def link_params
    parms = params[:link]
    parms.slice!(
      :user_id,
      :url,
      :description
    )
    parms
  end

  def not_found
    render json: {error: :not_found}, status: 404
  end
end
