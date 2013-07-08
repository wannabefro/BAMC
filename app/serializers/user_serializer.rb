class UserSerializer < ActiveModel::Serializer
  attributes :username, :url, :tracks

  def url
    "http:www.bamc.co/mc/#{username}"
  end

  def tracks
    output = []
    object.tracks.each do |track|
      if track.state == "public"
        output << track
      end
    end
    output
  end

end
