require "csv"
class ParseJobsCsv
  def self.execute(file_path)
    CSV.foreach(file_path, headers: true) do |row|
      # Have added a separate model for Account to have more clarity on how accounts will look like
      # And in future if we are using any ORM to save the data in database, we can use the same model.
      skills = row["required_skills"].split(",").map(&:strip).uniq
      existing_skills = Skill.where(name: skills).pluck(:name)
      skills_to_be_created = skills - existing_skills
      skills_to_be_created.map { |skill| Skill.create(name: skill) }
      skill_ids = Skill.where(name: skills).pluck(:id)
      Job.create(title: row["title"], skill_ids: skill_ids)
    rescue => e
      puts("Encountered error : #{e.message} #{e.backtrace}")
    end
  end
end
