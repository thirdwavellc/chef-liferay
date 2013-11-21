require 'chefspec'
require 'chefspec/berkshelf'

berksfile = Berkshelf::Berksfile.from_file('Berksfile')
berksfile.install(path: 'vendor/cookbooks')
