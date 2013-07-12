class UserSerializer < ActiveModel::Serializer
  attributes :username, :url, :tracks

  def url
    "http:www.bamc.co/mcs/#{username}"
  end

  def tracks
    output = []
    object.tracks.each do |track|
      if track.state == "public"
        output << {name: track.name, url: "http://www.bamc.co/tracks/#{track.slug}"}
      end
    end
    output
  end

end
