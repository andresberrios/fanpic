class Api::V1::EntriesController < Api::V1::BaseController
  respond_to :json
  load_and_authorize_resource :campaign
  load_and_authorize_resource :entry, through: :campaign, except: [:index, :create]

  def index
    @entries = []

    if @campaign.tracking && @campaign.tracking['hashtags'].try(:any?)
      # Instagram
      instagram = []
      @campaign.tracking['hashtags'].each do |hashtag|
        page = Instagram.client.tag_recent_media hashtag
        instagram.push *page
        while page.pagination.next_max_tag_id
          page = Instagram.client.tag_recent_media hashtag, max_tag_id: page.pagination.next_max_tag_id
          instagram.push *page
        end
      end
      external_ids = instagram.map { |e| e.id }
      existing_entries = Entry.where(campaign: @campaign,
                                     external_id: external_ids).to_a
      instagram = instagram.map do |external_entry|
        existing_entry = existing_entries.select do |e|
          e.external_id == external_entry.id && e.source == 'instagram'
        end.first
        entry = if existing_entry
                  existing_entry.external_data = external_entry
                  existing_entry
                else
                  entry = Entry.from_external 'instagram', external_entry
                  entry.campaign = @campaign
                  entry
                end
        if entry.missing_usertags.any?
          entry.status = 'rejected'
        end
        entry
      end
      @entries.push *instagram
    end

    respond_with @entries
  end

  def show
    respond_with @entry
  end

  def create
    data = Instagram.client.media_item params.require(:external_id)
    @entry = Entry.from_external params.require(:source), data
    @entry.assign_attributes entry_params
    @entry.campaign = @campaign
    authorize! :create, @entry
    @entry.save
    respond_with @entry
  end

  def update
    @entry.update entry_params
    respond_with @entry
  end

  def destroy
    @entry.destroy
    respond_with @entry
  end

  private
    def entry_params
      params.permit :user_id,
                    :status,
                    :unmet_requirements,
                    :rejection_message
    end
end
