class Api::EntriesController < Api::BaseController
  respond_to :json
  load_and_authorize_resource :campaign
  load_and_authorize_resource :entry, through: :campaign

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
        if existing_entry
          existing_entry.external_data = external_entry
          existing_entry
        else
          entry = Entry.from_external 'instagram', external_entry
          entry.campaign = @campaign
          entry
        end
      end
      @entries.push *instagram
    end

    respond_with @entries
  end

  private
    def entry_params
      params.permit :user_id,
                    :source,
                    :external_data,
                    :status,
                    :rejection_reason
    end
end
