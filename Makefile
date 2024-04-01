run:
	bundle exec ruby lib/cli.rb ./data/development/jobseekers.csv ./data/development/jobs.csv

lint:
	bundle exec standardrb -a lib app/models app/services spec

test:
	bundle exec rspec
