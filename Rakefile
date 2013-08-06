task :default=> [
  :foodcritic,
  :berks,
  :knife,
  :chefspec
]

desc "Berksfile install"
task :berks do
  sh "rm -rf vendor"
  sh "bundle exec berks install --path vendor/cookbooks"
end

desc "Foodcritic linting"
task :foodcritic do
  sh "foodcritic . -f any -f ~FC033"
end

desc "Knife test"
task :knife do
  sh "bundle exec knife cookbook test liferay -o vendor/cookbooks"
end

desc "ChefSpec Unit Tests"
task :chefspec do
  sh "bundle exec rspec --color vendor/cookbooks/liferay/spec"
end