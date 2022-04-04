class Membership < ApplicationRecord
    belongs_to :gym 
    belongs_to :client 

    validates :gym_id, :client_id, :charge, presence: true
    validates :client_gym

    def client_gym
        Membership.all.each do |membership|
            if client_id == membership.client_id && gym_id == membership.gym_id
                errors.add(:client_id, "Cannot have more than one membership with the same gym")
            end
        end
    end
end
