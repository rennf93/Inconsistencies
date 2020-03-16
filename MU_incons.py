#!/usr/bin/env python
import datetime
import time
import os
import sys
import logging
import cx_Oracle
import configparser

###
t = str(datetime.datetime.now())

###
try:
    ###
    print('Inicializando el Script de Inconsistencias de MU y SYSTRANS.')
    print('-------------------------------------------------------------------------------------------------------------------------------------')

    ###
    configParser = configparser.RawConfigParser()
    configFilePath = r'config.ini'
    configParser.read(configFilePath)

    ###
    uid = configParser.get('DDBB', 'user')
    pwd = configParser.get('DDBB', 'pass')
    host = configParser.get('DDBB', 'host')

    ###
    origen = configParser.get('PARAMS', 'origen')
    destino = configParser.get('PARAMS', 'destino')
    dblink = configParser.get('PARAMS', 'dblink')

    ###
    db = cx_Oracle.connect(uid, pwd, host)
    print('Connected to: %s', db)
    cursor = db.cursor()

    ###
    try:
        print('Started.')
        print('Procedure a ejecutar: MU_INCONS_A')
        cursor.callproc('MU_INCONS_A', parameters=[origen, destino, dblink])
        print('Finished MU_INCONS_A @:', t)
        print('-------------------------------------------------------------------------------------------------------------------------------------')
        print('-------------------------------------------------------------------------------------------------------------------------------------')
        print('Procedure a ejecutar: MU_INCONS_B')
        cursor.callproc('MU_INCONS_B', parameters=[origen, destino, dblink])
        print('Finished MU_INCONS_B @:', t)
        print('-------------------------------------------------------------------------------------------------------------------------------------')
        cursor.close()
        db.close()
        print('-------------------------------------------------------------------------------------------------------------------------------------')
        print('Finished running all @:', t)
        print('-------------------------------------------------------------------------------------------------------------------------------------')
        print('-------------------------------------------------------------------------------------------------------------------------------------')

    ###
    except Exception as e:
        cursor.close()
        db.close()
        print('<<<------------------------------------------------------------------------------------------------------------------------------------>>>')
        print('WARNING')
        print('<<<------------------------------------------------------------------------------------------------------------------------------------>>>')
        print(e)
        print('<<<------------------------------------------------------------------------------------------------------------------------------------>>>')
        print('El SP no pudo ser ejecutado.')
        print('<<<------------------------------------------------------------------------------------------------------------------------------------>>>')

###
except Exception as msg:
    cursor.close()
    db.close()
    print('<<<------------------------------------------------------------------------------------------------------------------------------------>>>')
    print('WARNING')
    print('<<<------------------------------------------------------------------------------------------------------------------------------------>>>')
    print(msg)
    print('<<<------------------------------------------------------------------------------------------------------------------------------------>>>')
    print('El programa no fue ejecutado.')
    print('<<<------------------------------------------------------------------------------------------------------------------------------------>>>')
