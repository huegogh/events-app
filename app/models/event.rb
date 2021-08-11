class Event < ApplicationRecord
    validates :name, presence: { message: "Error: Missing required 'name' key." }
    validates :event_type, presence: { message: "Error: Missing required 'event_type' key." }
end
