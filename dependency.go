package main

import (
	"errors"
	"os"
	"os/exec"

	"github.com/prometheus/common/log"
)

type dependency struct {
	OfType  string `json:"type" yaml:"type"`
	Message string `json:"msg"`
	Name    string `json:"name"`
	Path    string `json:"path"`
}

func (d dependency) check() bool {
	var (
		msg string
		err error
	)
	element := d.Name

	switch d.OfType {
	case "command":
		_, err = exec.Command(d.Name).Output()
		msg = "Command `%s` does not exist."
	case "directory":
		_, err = os.Stat(d.Path)
		msg = "Directory `%s` does not exist."
		element = d.Path
	default:
		err = errors.New("Unsupported type.")
		log.Warnf("Type `%s` is not supported.", d.OfType)
	}

	if err != nil {
		if d.Message != "" {
			log.Error(d.Message)
		} else {
			log.Errorf(msg, element)
		}

		return false
	}

	return true
}
