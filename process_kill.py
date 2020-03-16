#Hashbang sentence to hide the command line while running(always).
#!/usr/bin/env python
import psutil
import configparser

#Using configParser in order to access the config file and read it.
configParser = configparser.RawConfigParser()
configFilePath = r'config.ini'
configParser.read(configFilePath)

#PROCESS config
proc_name = configParser.get('PROCESS', 'name')

for proc in psutil.process_iter():
    # check whether the process name matches
    if proc.name() == proc_name:
        proc.kill()
