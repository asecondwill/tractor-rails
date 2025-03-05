# == Schema Information
#
# Table name: menus
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Menu < ApplicationRecord
  validates :name, presence: true
  has_many :menuitems, -> { order(position: :asc) }
end
