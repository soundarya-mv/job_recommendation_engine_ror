# frozen_string_literal: true

require_relative "../config/environment"

class JobRecommendationService
  BATCH_SIZE = 10
  def self.execute(args)
    job_seekers = ParseJobSeekersCsv.execute(args[0])
    ParseJobsCsv.execute(args[1])
    job_recommendations_array = []
    job_seekers.each_slice(BATCH_SIZE) do |batch|
      batch.each do |job_seeker|
        job_recommendations = RecommendJobs.execute(job_seeker)
        job_recommendations_array << job_recommendations
      end
    end
    job_recommendations_array
  end
end
