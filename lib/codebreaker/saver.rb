require 'yaml'

module Codebreaker
	class Saver
		attr_accessor :users
		SAVEFILE = "../../data/data"
		def initialize
			@users = self.read_from_file(SAVEFILE) if File.exist? SAVEFILE
			@users = {}
		end

		def save
			raise "File not found" unless File.exist? SAVEFILE
			save_to_file SAVEFILE
		end

		def save_to_file(file_name)
			File.open(file_name, 'w') do |users|
				 users.puts YAML.dump(self)
			end
		end

		def read_from_file(file_name)
			@users = YAML.load(File.read(file_name))
		end

	end
end
