class JobSeekerSkill < ApplicationRecord
  belongs_to :job_seeker
  belongs_to :skill
end
