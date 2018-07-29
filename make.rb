require 'rbconfig'

# This whole thing is gross and needs to change at some point
# Either need to make a gem or use something like ruby-packer

# Create dotfiles
dir = ENV['HOME'] + '/.bacchus'
if !File.exist?(dir)
	cmd = 'mkdir ' + dir
	system cmd

	cmd = 'mkdir ' + dir + '/prefixes'
	system cmd

	cmd = 'mkdir ' + dir + '/presets'
	system cmd

	cmd = 'mkdir ' + dir + '/launchers'
	system cmd
end

# Build the bacchus executable script
cmd = 'touch bacchus'
system cmd

File.open('bacchus', 'a') { |f|
	f.puts '#!/usr/bin/env ruby'
	f.puts "require 'optparse'"
}

cmd = "echo $'\n' >> bacchus"
system cmd

cmd = 'cat helpers.rb >> bacchus'
system cmd

cmd = "echo $'\n' >> bacchus"
system cmd

cmd = 'cat backup.rb >> bacchus'
system cmd

cmd = "echo $'\n' >> bacchus"
system cmd

cmd = 'cat search.rb >> bacchus'
system cmd

cmd = "echo $'\n' >> bacchus"
system cmd

cmd = 'cat bacchus.rb | tail -n+5 >> bacchus'
system cmd

cmd = 'chmod 755 bacchus'
system cmd


# Move to /usr/bin here
os = RbConfig::CONFIG['host_os']

if os.downcase.include?('darwin')
	cmd = 'mv bacchus /usr/local/bin/bacchus'
	system cmd
elsif os.downcase.include?('linux')
	cmd = 'mv bacchus /usr/bin/bacchus'
	system cmd
else 
	puts "Don't use windows"
end