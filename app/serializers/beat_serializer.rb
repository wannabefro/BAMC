class BeatSerializer < ActiveModel::Serializer
  attributes :id,:name, :genre, :beat_file_name, :beat_file_size
end
