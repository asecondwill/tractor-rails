# == Schema Information
#
# Table name: menuitems
#
#  id                :bigint           not null, primary key
#  ancestry          :string
#  ancestry_depth    :integer          default(0)
#  children_count    :integer          default(0)
#  link              :string
#  menuitemable_type :string
#  name              :string
#  position          :integer
#  strap             :string
#  style             :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  menu_id           :integer          not null
#  menuitemable_id   :uuid
#
# Indexes
#
#  index_menuitems_on_ancestry                               (ancestry)
#  index_menuitems_on_menu_id                                (menu_id)
#  index_menuitems_on_menuitemable_type_and_menuitemable_id  (menuitemable_type,menuitemable_id)
#
class Menuitem < ApplicationRecord
  # validates :name, presence: true
  acts_as_list scope: [ :ancestry ]
  has_ancestry cache_depth: true, counter_cache: true
  belongs_to :menu
  belongs_to :menuitemable, polymorphic: true, optional: true

  validates :name, presence: true, unless: :regular_link?

  def regular_link?
     menuitemable.present?
  end

  def to_s
    if name.present?
      name
    elsif menuitemable.present?
      menuitemable.to_s
    else
      ""
    end
  end

  # def menu_title
  #   if name.present?
  #     name
  #   elsif menuitemable.present?
  #     menuitemable.menu_title
  #   else
  #     ""
  #   end
  # end

  def the_link
    if menuitemable
      menuitemable.link
    else
      link
    end
  end
end
