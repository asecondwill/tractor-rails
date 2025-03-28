# == Schema Information
#
# Table name: sections
#
#  id                   :bigint           not null, primary key
#  name                 :string
#  position             :integer
#  sectionable_type     :string
#  sectiontypeable_type :string
#  show_title           :boolean          default(FALSE), not null
#  style                :text
#  template             :string
#  title                :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  sectionable_id       :integer
#  sectiontypeable_id   :integer
#
# Indexes
#
#  index_sections_on_sectionable_type_and_sectionable_id          (sectionable_type,sectionable_id)
#  index_sections_on_sectiontypeable_type_and_sectiontypeable_id  (sectiontypeable_type,sectiontypeable_id)
#
class Section < ApplicationRecord
  belongs_to :sectionable, polymorphic: true
  acts_as_list scope: [ :sectionable_id, :sectionable_type ]
  validates :title, presence: true
  belongs_to :sectiontypeable, polymorphic: true, dependent: :destroy
  accepts_nested_attributes_for :sectiontypeable
end
