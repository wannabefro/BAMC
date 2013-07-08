class UserSerializer < ActiveModel::Serializer
  attributes :username, :url

  def url
    user_url(object)
  end

end
