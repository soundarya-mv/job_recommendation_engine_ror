class CreateJobSeekerSkills < ActiveRecord::Migration[7.1]
  def change
    create_table :job_seeker_skills do |t|
      t.references :job_seeker, null: false, foreign_key: true
      t.references :skill, null: false, foreign_key: true

      t.timestamps
    end
  end
end
