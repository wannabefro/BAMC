class TrackSerializer < ActiveModel::Serializer
  attributes :id, :name, :beat_id, :track, :created_at
end
