class TrackSerializer < ActiveModel::Serializer
  attributes :id, :name, :beat_id, :track, :url

  def url
    track_url(object)
  end

end
