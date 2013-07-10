class TrackSerializer < ActiveModel::Serializer
  attributes :id, :name,:username, :beat_id, :url

  def url
    track_url(object)
  end

  def username
    user = object.user
    user.username
  end

end
