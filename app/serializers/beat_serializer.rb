class BeatSerializer < ActiveModel::Serializer
  attributes :id,:name, :genre, :created_at, :beat_file_name, :beat_content_type, :beat_file_size
end
