require 'foodcritic'
require 'chefspec'

task :default=> [:foodcritic, :chefspec]

task :foodcritic do
  sh "foodcritic . -f any -f ~FC033"
end

task :chefspec do
  sh "rspec --color"
end