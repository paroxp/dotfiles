package main

import (
	"flag"
)

var (
	cfg      config
	commands map[string]command

	configFile = flag.String(
		"config",
		"./config.yml",
		"The destination to the config file.",
	)
	debug = flag.Bool(
		"debug",
		false,
		"Turn on the debug mode.",
	)
	destination = flag.String(
		"destination",
		"~/.env",
		"Define the default destination of your environment files.",
	)
	email = flag.String(
		"email",
		"",
		"Provide your email address, for the purpose of setting up `.gitconfig`.",
	)
	name = flag.String(
		"name",
		"",
		"Provide your name, for the purpose of setting up `.gitconfig`.",
	)
	terminator = flag.Bool(
		"terminator",
		false,
		"Turn on terminator setup.",
	)
)

func main() {
	cfg.load()
	run()
}
