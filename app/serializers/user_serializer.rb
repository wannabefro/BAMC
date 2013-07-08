class UserSerializer < ActiveModel::Serializer
  attributes :username, :url

  def url
    "http:www.bamc.co/mc/#{username}"
  end

end
