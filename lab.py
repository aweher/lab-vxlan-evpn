#!/usr/bin/env python3
import yaml
import jinja2

yaml_file = 'lab.yml'
jinja_template = 'lab.j2'

class Lab(object):
    def __init__(self):
        with open(yaml_file) as f:
            read_yaml = yaml.safe_load(f)

            for labs, vars in read_yaml.items():
                self.generate_config(vars)

    def generate_config(self, params):
        with open(jinja_template) as f:
            tfile = f.read()
            template = jinja2.Template(tfile)
            cfg_list = template.render(params)

            print(cfg_list)