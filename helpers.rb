require 'json'
require 'pathname'

def parse(file_name)
	dir = ENV['HOME'] + '/.bacchus/presets/' + file_name + '.json'
	if !File.exist?(dir)
		puts "Error! No preset for that software"
		exit
	end
	file = File.read(dir)
	data_hash = JSON.parse(file)
end

def build_prefix(hash)
	prefix_name = hash['name']
	arch = hash['arch']
	win = hash['win']

	# build the prefix
	output = 'WINEARCH=' + arch + ' WINEPREFIX=~/.' + prefix_name + ' winecfg &> /dev/null'
	system output, :out => File::NULL
end

def winetricks(hash)
	exec = "winetricks " + hash['winetricks']
	system exec
end

def install(hash)
	type = hash['type']
	software_name = hash['name']

	if type == "exe"
		puts "Please specify the path to the " + software_name + " exe file: "
		path = gets.chomp
		puts path
	elsif type == "dir"
		puts "Please specify the path to the " + software_name + " directory: "
		path = gets.chomp
		if path[-1] == "/"
			puts "Not a directory"
		end
		install_dir(path, software_name)
	else
		puts "Please specify the path to the " + software_name + " installer exe file: "
		path = gets.chomp
		launch_setup(path, software_name)
	end
end

def install_dir(path, prefix_name = nil)
	if !prefix_name
		prefix_name = '~/.wine' # Assume default wine directory
	end

	# TODO Be smart and don't just dump the contents if the user adds a slash to the end
	output = 'cp -r ' + path + ' ~/.' + prefix_name + '/drive_c/Program\ Files'
	system output
end

def launch_setup(path, prefix_name = nil)
	if !prefix_name
		prefix_name = '~/.wine' # Assume default wine directory
	end

	output = 'WINEPREFIX=' + ENV['HOME'] + '/.' + prefix_name + ' wine ' + path
	system output
end

def build_launcher(hash)
	exe = hash['exe']
	prefix_name = hash['name']
	path = hash['path'].gsub(/ /, '\ ')

	if !prefix_name
		prefix_name = '~/.wine'
	end

	# TODO Output the sh to a dotfile directory
	name = ENV['HOME'] + '/' + exe + '.sh'

	# TODO account for locale

	# TODO Check to make sure file doesn't already exist
	file = File.new(name, 'w')
	open(name, 'a') { |f|
	 	f.puts '#!/bin/bash'
	 	f.puts 'cd ' + ENV['HOME'] + '/.' + prefix_name + path
	 	f.puts 'WINEPREFIX=' + ENV['HOME'] + '/.' + prefix_name + ' wine ' + exe + ".exe"
	}
end