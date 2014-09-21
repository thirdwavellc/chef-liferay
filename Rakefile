task :default=> [
  :foodcritic,
  :berks,
  :chefspec
]

desc "Berksfile install"
task :berks do
  sh "rm -rf vendor"
  sh "bundle exec berks install --path vendor/cookbooks"
end

desc "Foodcritic linting"
task :foodcritic do
  sh " bundle exec foodcritic ."
end

desc "ChefSpec Unit Tests"
task :chefspec do
  sh "bundle exec rspec --color vendor/cookbooks/liferay/spec"
end
