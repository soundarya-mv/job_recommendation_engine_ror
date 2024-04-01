require "csv"
class ParseJobSeekersCsv
  def self.execute(file_path)
    job_seekers = []
    CSV.foreach(file_path, headers: true) do |row|
      # Have added a separate model for Account to have more clarity on how accounts will look like
      # And in future if we are using any ORM to save the data in database, we can use the same model.
      skills = row["skills"].split(",").map(&:strip).uniq
      existing_skills = Skill.where(name: skills).pluck(:name)
      skills_to_be_created = skills - existing_skills
      skills_to_be_created.map { |skill| Skill.create(name: skill) }
      skill_ids = Skill.where(name: skills).pluck(:id)
      job_seeker = JobSeeker.create(name: row["name"], skill_ids: skill_ids)
      job_seekers << job_seeker
    rescue => e
      puts("Encountered error : #{e.message} #{e.backtrace}")
    end
    job_seekers
  end
end
