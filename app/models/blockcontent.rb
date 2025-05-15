# == Schema Information
#
# Table name: blockcontents
#
#  id         :bigint           not null, primary key
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Blockcontent < ApplicationRecord
  has_one :section, as: :sectiontypeable
end
