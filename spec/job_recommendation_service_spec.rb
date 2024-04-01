require "spec_helper"

RSpec.describe JobRecommendationService do
  it "recommends jobs for a user corresponding to his skills" do
    job_recommendations = JobRecommendationService.execute(["./data/test/jobseeker.csv", "./data/test/jobs.csv"])
    expect(job_recommendations).to be_an_instance_of(Array)
    expect(job_recommendations[0]).to be_an_instance_of(Array)
    expect(job_recommendations[0]).to all(be_a(Hash))
    expect(job_recommendations[0]).to all(include(:job_seeker_id, :jobseeker_name, :job_id, :job_title, :matching_skill_count, :matching_skills_percentage))
  end

  it "returns job recommendations sorted by jobseeker ID" do
    job_recommendations = JobRecommendationService.execute(["./data/test/jobseekers.csv", "./data/test/jobs.csv"])
    expect(job_recommendations[0][0][:job_seeker_id]).to be < (job_recommendations[1][0][:job_seeker_id])
  end

  it "sorts jobs based on percentage of skills match" do
    job_recommendations = JobRecommendationService.execute(["./data/test/jobseeker.csv", "./data/test/jobs.csv"])
    expect(job_recommendations[0][0][:matching_skills_percentage]).to be > (job_recommendations[0][1][:matching_skills_percentage])
  end

  it "sorts jobs based on job_id when 2 roles have same matching_skills_percentage" do
    job_recommendations = JobRecommendationService.execute(["./data/test/jobseeker.csv", "./data/test/jobs_with_similar_skills.csv"])
    expect(job_recommendations[0][0][:job_id]).to be < (job_recommendations[0][1][:job_id])
  end
end
