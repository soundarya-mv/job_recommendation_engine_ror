# frozen_string_literal: true

class RecommendJobs
  BATCH_SIZE = 10
  attr_accessor :jobs

  def self.execute(job_seeker)
    job_matches = []
    job_seeker_skills = job_seeker.skills.pluck(:name).to_set
    Job.find_each(batch_size: BATCH_SIZE) do |job|
      job_skills = job.skills.pluck(:name).to_set
      matching_skills_count, matching_skills_percentage = calculate_match_percentage(job_seeker_skills, job_skills)
      next if matching_skills_count == 0
      job_match = job_recommendation_hash(job_seeker, job, matching_skills_count, matching_skills_percentage)
      job_matches << job_match
    end
    job_matches.sort_by { |job_match| [-(job_match[:matching_skills_percentage]), job_match[:job_id]] }
  end

  private

  def self.calculate_match_percentage(job_seeker_skills, job_skills)
    matching_skills_count = (job_seeker_skills & job_skills).count
    # Fuzzy match can be used to match the skills that are represented in different ways. Ex: React, React.js
    # Skill abbrevation mapping hash can be used and skills can be normalized while matching for skills that can be used both in abbreviated and full forms - Eg: { CSS: Cascading Style Sheets }
    matching_skills_percentage = (matching_skills_count.to_f / job_skills.count) * 100
    [matching_skills_count, matching_skills_percentage]
  end

  def self.job_recommendation_hash(job_seeker, job, matching_skills_count, matching_skills_percentage)
    {
      job_seeker_id: job_seeker.id,
      jobseeker_name: job_seeker.name,
      job_id: job.id,
      job_title: job.title,
      matching_skill_count: matching_skills_count,
      matching_skills_percentage: matching_skills_percentage
    }
  end

  private_class_method :calculate_match_percentage, :job_recommendation_hash
end
