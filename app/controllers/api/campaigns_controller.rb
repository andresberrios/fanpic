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
    @campaign.user = current_user
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

  def entries
    entries = []
    if @campaign.tracking['hashtags'].try(:any?)
      @campaign.tracking['hashtags'].each do |hashtag|
        entries.push *Instagram.client.tag_recent_media(hashtag)
      end
    end
    respond_with entries
  end


  private

  def campaign_params
    params.permit :name,
                  :description,
                  :image_url,
                  :requirements,
                  {tracking: [{hashtags: []}, {usertags: []}]}
  end
end
