class Skill < ApplicationRecord
  has_many :job_seeker_skills
  has_many :job_seekers, through: :job_seeker_skills
  has_many :job_skills
  validates :name, uniqueness: true
end
