require_relative 'finder'

# file = ARGV[0]

finder = OkCuGit::Finder.new(ARGV[0])
finder.all_contributors
