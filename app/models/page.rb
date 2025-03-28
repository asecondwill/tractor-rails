# == Schema Information
#
# Table name: pages
#
#  id          :bigint           not null, primary key
#  banner_text :text
#  content     :text
#  description :text
#  published   :boolean
#  show_title  :boolean
#  slug        :string
#  template    :string
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Page <   ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  validates :title, presence: true
  has_many :sections, as: :sectionable, dependent: :destroy
  # validates :content, presence: true
  has_one_attached :banner, service: ENV["PUBLIC_STORAGE_SERVICE"].to_sym do |attachable|
    attachable.variant :thumb, resize_to_fill: [ 400, 165 ]
    attachable.variant :full, resize_to_fit: [ 1280, 510 ]
  end

  attr_accessor :banner_destroy
  include Destroyable


  def should_generate_new_friendly_id?
    slug.blank?
  end

  def to_s
    "#{title}"
  end

  # def menu_title
  #   title
  # end

  def link
    "/#{slug}"
  end

  def return_path
    Rails.application.routes.url_helpers.edit_admin_page_path(self)
  end


  def self.published
    where(published: true)
  end

  def link_search
    "pages:#{slug}"
  end
end
