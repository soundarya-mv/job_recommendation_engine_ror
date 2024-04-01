class JobSeeker < ApplicationRecord
  has_many :job_seeker_skills, dependent: :destroy
  has_many :skills, through: :job_seeker_skills
  accepts_nested_attributes_for :skills
end
