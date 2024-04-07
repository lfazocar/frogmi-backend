# == Schema Information
#
# Table name: features
#
#  id          :bigint           not null, primary key
#  external_id :string
#  title       :string           not null
#  url         :string           not null
#  place       :string           not null
#  mag_type    :string           not null
#  magnitude   :float
#  time        :string
#  tsunami     :boolean
#  longitude   :float
#  latitude    :float
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Feature < ApplicationRecord
  # Associations
  has_many :comments

  # Validations
  validates :external_id, uniqueness: true
  validates :title, presence: true
  validates :url, presence: true
  validates :place, presence: true
  validates :mag_type, presence: true
  validates :magnitude, numericality: { in: -1.0..10.0 }
  validates :latitude, numericality: { in: -90.0..90.0 }
  validates :longitude, numericality: { in: -180.0..180.0 }
end
