package main

import (
	"flag"
	"fmt"
	"os"
	"text/tabwriter"

	"github.com/prometheus/common/log"
)

type command struct {
	name        string
	description string
	executetive func()
}

func (c command) run() {
	c.executetive()
}

func loadCommands() map[string]command {
	return map[string]command{
		"help": command{
			"help",
			"Display help text to make it easier when using the app.",
			helpCommand,
		},
		"init": command{"init", "Initialise an environment on a new OS.", initCommand},
	}
}

func run() {
	commands = loadCommands()
	cmd := flag.Arg(0)

	log.Debugf("Action `%s` has been fired.", cmd)
	log.Debug(commands[cmd])
	if _, ok := commands[cmd]; !ok {
		log.Error("Unknown action fired.")
		cmd = "help"
	}

	commands[cmd].run()
}

func helpCommand() {
	fmt.Fprintln(os.Stderr, "Usage: devenv <command>")
	fmt.Fprintln(os.Stderr)

	fmt.Fprintln(os.Stderr, "Flags:")
	fmt.Fprintln(os.Stderr)
	flag.PrintDefaults()
	fmt.Fprintln(os.Stderr)

	fmt.Fprintln(os.Stderr, "Commands:")
	fmt.Fprintln(os.Stderr)
	w := tabwriter.NewWriter(os.Stderr, 0, 4, 2, ' ', 0)
	for _, cmd := range commands {
		fmt.Fprintf(w, "\t%s\t%s\n", cmd.name, cmd.description)
	}
	w.Flush()
	fmt.Fprintln(os.Stderr)
}

func initCommand() {

}
