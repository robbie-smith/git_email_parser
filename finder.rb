module OkCuGit
  class Finder

    attr_reader :repo_name, :user_name, :log, :git

    def initialize(repo_address)
      split_name = repo_address.split("/")
      @user_name = split_name[-2]
      @repo_name = split_name[-1]
      @git = repo_address
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
      find_contributors.map {|name|name.slice(8..-1)}.flatten
    end

    def collect_logs
      `git clone #{git}`
      Dir.chdir("#{repo_name}")
      @log = `git log`.split("\n").uniq
    end

    def cd_up_and_remove_directory
      Dir.chdir("..")
      `rm -rf "#{repo_name}"`
    end
  end

end
