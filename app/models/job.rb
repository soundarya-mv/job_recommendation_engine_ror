class Job < ApplicationRecord
  has_many :job_skills, dependent: :destroy
  has_many :skills, through: :job_skills
  accepts_nested_attributes_for :skills
  validates :title, uniqueness: true
end
