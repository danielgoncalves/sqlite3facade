@echo off
REM
REM   test/cleanup.bat
REM   Clean up script for Microsoft Windows XP or (possibly) newer.
REM
REM   This file is part of SQLite3Façace for Harbour".
REM
REM   This work is licensed under the Creative Commons Attribution 3.0 
REM   Unported License. To view a copy of this license,
REM   visit http://creativecommons.org/licenses/by/3.0/ or send a letter to 
REM   Creative Commons, 444 Castro Street, Suite 900, Mountain View, 
REM   California, 94041, USA.
REM
REM   Copyright (c) 2010, Daniel Gonçalves <daniel-at-base4-com-br>
IF EXIST *.db DEL *.db > NUL
IF EXIST *.o DEL *.o > NUL
IF EXIST *.ppo DEL *.ppo > NUL
IF EXIST sqlite3_tests.exe DEL sqlite3_tests.exe > NUL
IF EXIST RESULTS.ERRORS DEL RESULTS.ERRORS > NUL
IF EXIST RESULTS.PASSED DEL RESULTS.PASSED > NUL

