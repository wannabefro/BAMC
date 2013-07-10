class TrackSerializer < ActiveModel::Serializer
  attributes :id, :name,:username, :beat_id, :url

  def url
    track_url(object)
  end

  def username
    user = self.user
    user.username
  end

end
