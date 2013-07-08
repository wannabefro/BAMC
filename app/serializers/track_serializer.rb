class TrackSerializer < ActiveModel::Serializer
  attributes :id, :name, :beat_id, :url

  def url
    track_url(object)
  end

end
