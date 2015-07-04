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
    if @campaign.tracking && @campaign.tracking['hashtags'].try(:any?)
      @campaign.tracking['hashtags'].each do |hashtag|
        # TODO Limit the amount of pages, maybe through a parameter, etc.
        page = Instagram.client.tag_recent_media hashtag
        entries.push *page
        while page.pagination.next_max_tag_id
          page = Instagram.client.tag_recent_media hashtag, max_tag_id: page.pagination.next_max_tag_id
          entries.push *page
        end
      end
    end
    entries = entries.map do |e|
      entry = Entry.from_external 'instagram', e
      entry.campaign = @campaign
      entry
    end
    respond_with entries
  end


  private

  def campaign_params
    params.permit :name,
                  :description,
                  :image_url,
                  :cover_image_url,
                  :requirements,
                  {tracking: [{hashtags: []}, {usertags: []}]}
  end
end
