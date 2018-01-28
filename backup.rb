def backup()

	time = Time.new
	date = time.year.to_s + "-" + time.month.to_s + "-" + time.day.to_s

	exec = "tar -C " + ENV['HOME'] + "/.bacchus -cvf backup-" + date + ".tar prefixes"
	system exec

end