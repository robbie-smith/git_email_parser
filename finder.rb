module OkCuGit
  class Finder

    attr_reader :repo_name, :user_name, :log

    def initialize(repo_name)
      split_name = repo_name.split("/")
      @git = "https://github.com/#{repo_name}"
      @user_name = split_name.first
      @repo_name = split_name.last
      @log = log
    end

    def all_contributors
      collect_logs
      found_contributors.sort.each { |name| puts "#{name}" }
      cd_up_and_remove_directory
    end

    def find_contributors
      log.find_all {|element| element.include?("Author")}
    end

    def found_contributors
      #author = find_contributors
      find_contributors.map {|name|name.slice(8..-1)}.flatten
    end

    def collect_logs
      `git clone #{@git}`
      Dir.chdir("#{repo_name}")
      @log = `git log`.split("\n").uniq
    end

    def cd_up_and_remove_directory
      Dir.chdir("..")
      `rm -rf "#{repo_name}"`
    end
  end

end
