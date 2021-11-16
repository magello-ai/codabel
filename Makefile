pkg:

gem: pkg
	bundle exec rake gem

gem.push:
	gem push `ls -Art pkg/*.gem | tail -n 1`
