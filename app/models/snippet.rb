# == Schema Information
#
# Table name: snippets
#
#  id         :bigint           not null, primary key
#  content    :text
#  name       :string
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_snippets_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Snippet < ApplicationRecord
  extend FriendlyId
  belongs_to :user
  validates :name, presence: true
  validates :slug, presence: true
  validates :content, presence: true
  friendly_id :name, use: :slugged
end
