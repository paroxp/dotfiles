package main

import (
	"encoding/json"
	"flag"
	"io/ioutil"
	"path"

	yaml "gopkg.in/yaml.v2"

	log "github.com/Sirupsen/logrus"
)

type config struct {
	Dependencies []dependency `json:"dependencies" yaml:"dependencies"`
}

func (c *config) load() {
	flag.Parse()

	if *debug {
		log.SetLevel(log.DebugLevel)
	}

	log.Debugf("Configuration file: %s", *configFile)
	file, err := ioutil.ReadFile(*configFile)
	if err != nil {
		log.Error(err)
	}

	log.Debugf("Configuration contents:\n%s", string(file))
	fileType := path.Ext(*configFile)
	log.Debugf("About to unmarshal `%s` file.", fileType)

	if fileType == ".yaml" || fileType == ".yml" {
		err = yaml.Unmarshal(file, c)
	} else if fileType == ".json" {
		err = json.Unmarshal(file, c)
	} else {
		log.Panicf("Config file with extension of `%s` is not supported.", fileType)
	}

	if err != nil {
		log.Fatal(err)
	}
}
