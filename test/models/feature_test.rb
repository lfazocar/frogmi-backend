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
require "test_helper"

class FeatureTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
