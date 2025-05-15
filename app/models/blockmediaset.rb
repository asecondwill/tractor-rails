# == Schema Information
#
# Table name: blockmediasets
#
#  id            :bigint           not null, primary key
#  body          :text
#  direction     :string
#  image_columns :integer          default(5)
#  image_style   :string           default("bordered")
#  link          :string
#  title         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Blockmediaset < ApplicationRecord
  has_one_attached :hero, service: ENV["PUBLIC_STORAGE_SERVICE"].to_sym do |attachable|
    attachable.variant :thumb, resize_to_fill: [ 400, 400 ]
    attachable.variant :full, resize_to_fill: [ 800, 800 ]
  end
  attr_accessor :hero_destroy
  before_update :destroy_attachments
  validates :image_columns, presence: true, numericality: { greater_than_or_equal_to: 2, less_than_or_equal_to: 8 }
  def destroy_attachments
    if hero_destroy.to_i == 1
      hero.purge
    end
  end

  def to_s
    "MEDIASET"
  end
end
