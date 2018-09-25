class Ad < ApplicationRecord
    validates :olx_id, uniqueness: true
end
