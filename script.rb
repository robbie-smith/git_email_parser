require_relative 'finder'

finder = OkCuGit::Finder.new(ARGV[0])
finder.all_contributors
