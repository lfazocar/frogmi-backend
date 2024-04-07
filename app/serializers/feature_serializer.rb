class FeatureSerializer
  include JSONAPI::Serializer

  attributes :external_id, :magnitude, :place, :time, :tsunami, :mag_type, :title

  attribute :coordinates do |object| {
    'longitude': object.longitude,
    'latitude': object.latitude
  } end

  link :external_url, :url
end
