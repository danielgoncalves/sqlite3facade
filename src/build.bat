@ECHO OFF
REM
REM   build.bat
REM   Build script for Microsoft Windows XP or (possibly) newer.
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
REM

IF /I "%1"=="test" SET DO_RUNTESTS=RUNTESTS

IF /I "%1"=="deploy" (
   REM force run tests on deployment
   SET DO_RUNTESTS=RUNTESTS
   SET DO_DEPLOY=DEPLOY
)

SET ERRORLEVEL=0

IF NOT EXIST ..\build (
   MKDIR ..\build
   IF %ERRORLEVEL% NEQ 0 GOTO BUILD_DIR_CREATE_ERROR
)

IF EXIST ..\build (
   DEL /Q /F /S ..\build
   IF %ERRORLEVEL% NEQ 0 GOTO BUILD_DIR_CLEANUP_ERROR
) ELSE (
   GOTO BUILD_DIR_CREATE_ERROR
)

IF DEFINED DO_DEPLOY (
   IF EXIST ..\dist (
      DEL /Q /F /S ..\dist
	  IF %ERRORLEVEL% NEQ 0 GOTO DEPLOY_DIR_CLEANUP_ERROR
   ) ELSE (
      MKDIR ..\dist
	  IF %ERRORLEVEL% NEQ 0 GOTO DEPLOY_DIR_CREATE_ERROR
   )
)

ECHO #
ECHO #  generating library...
ECHO #
IF EXIST *.o DEL *.o > NUL
IF %ERRORLEVEL% NEQ 0 GOTO SOME_ERROR

IF EXIST libsqlite3facade.a DEL libsqlite3facade.a > NUL
IF %ERRORLEVEL% NEQ 0 GOTO SOME_ERROR

mingw32-make -f Makefile
IF %ERRORLEVEL% NEQ 0 GOTO SOME_ERROR

ECHO #
ECHO #  moving library to ..\build
ECHO #
COPY /B libsqlite3facade.a ..\build > NUL
IF %ERRORLEVEL% NEQ 0 GOTO SOME_ERROR
IF EXIST *.ch (
   COPY /B *.ch ..\build > NUL
   IF %ERRORLEVEL% NEQ 0 GOTO SOME_ERROR
)

IF DEFINED DO_RUNTESTS (
   CD ./test
   IF EXIST RESULTS.ERRORS DEL RESULTS.ERRORS > NUL
   IF EXIST RESULTS.PASSED DEL RESULTS.PASSED > NUL
   CALL runtests.bat
   CD ..
   
   IF EXIST ./test/RESULTS.ERRORS (
      ECHO #
      ECHO # ERROR: Tests FAILED!
      ECHO # 
      GOTO END_SCRIPT
   )
   
   IF EXIST ./test/RESULTS.PASSED (
      ECHO #
      ECHO # OK: Tests PASSED!
      ECHO #
      GOTO GO_AHEAD
   )
)

:GO_AHEAD 

IF DEFINED DO_DEPLOY (
   ECHO #
   ECHO #  packing deployment to ..\dist
   ECHO #
   
   IF EXIST deploy.info DEL deploy.info > NUL
   
   ECHO Harbour SQLite3 Façade >> deploy.info
   ECHO Deployment date %DATE% at %TIME% >> deploy.info
   ECHO By %USERNAME% >> deploy.info
   
   zip hbsqlite3facade libsqlite3facade.a *.CH deploy.info
   
   COPY hbsqlite3facade.zip ..\dist > NUL
   DEL hbsqlite3facade.zip > NUL
   DEL deploy.info > NUL
)

IF EXIST libsqlite3facade.a DEL libsqlite3facade.a > NUL
IF EXIST *.~* DEL *.~* > NUL
IF EXIST *.OBJ DEL *.OBJ > NUL
IF EXIST *.C DEL *.C > NUL
IF EXIST *.BAK DEL *.BAK > NUL
IF EXIST *.o DEL *.o > NUL

GOTO END_SCRIPT

:BUILD_DIR_CREATE_ERROR
ECHO #
ECHO # ERROR: Cannot create the build directory.
ECHO # The library will not be built.
ECHO #
GOTO END_SCRIPT

:BUILD_DIR_CLEANUP_ERROR
ECHO #
ECHO # ERROR: Cannot perform clean up on build directory.
ECHO # The library will not be built.
ECHO #
GOTO END_SCRIPT

:DEPLOY_DIR_CREATE_ERROR
ECHO #
ECHO # ERROR: Cannot create deployment directory.
ECHO # The library will not be built.
ECHO #
GOTO END_SCRIPT

:DEPLOY_DIR_CLEANUP_ERROR
ECHO #
ECHO # ERROR: Cannot perform clean up on deployment directory.
ECHO # The library will not be built.
ECHO #
GOTO END_SCRIPT

:SOME_ERROR
ECHO #
ECHO # ERROR: Build error.
ECHO #
GOTO END_SCRIPT

:END_SCRIPT
SET DO_RUNTESTS=
SET DO_DEPLOY=

