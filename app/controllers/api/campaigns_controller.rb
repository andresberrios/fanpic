class Api::CampaignsController < ApplicationController
  respond_to :json
  load_and_authorize_resource

  def index
    @campaigns = @campaigns.order 'updated_at DESC'
    if params[:page]
      @campaigns = @campaigns.paginate page: params[:page], per_page: 30
    end
    respond_with @campaigns
  end

  def show
    respond_with @campaign
  end

  def create
    @campaign.save
    respond_with @campaign
  end

  def update
    @campaign.update campaign_params
    respond_with @campaign
  end

  def destroy
    @campaign.destroy
    respond_with @campaign
  end


  private

  def campaign_params
    params.permit :name,
                  :description,
                  :image_url,
                  :requirements,
                  :hashtag
  end
end