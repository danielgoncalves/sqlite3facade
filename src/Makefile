#
# Makefile
#
# This file is part of "SQLite3Façade for Harbour".
#
# This work is licensed under the Creative Commons Attribution 3.0 
# Unported License. To view a copy of this license, visit 
# http://creativecommons.org/licenses/by/3.0/ or send a letter to 
# Creative Commons, 444 Castro Street, Suite 900, Mountain View, 
# California, 94041, USA.
# 
# Copyright (c) 2010, Daniel Gonçalves <daniel-at-base4-com-br>
#

MINGW_HOME=C:\MinGW
HARBOUR_HOME=C:\harbourmgw

HARBOUR_COMPILER=harbour

CC=$(MINGW_HOME)\bin\gcc
LINK=$(MINGW_HOME)\bin\ar
HARBOUR=$(HARBOUR_HOME)\bin\$(HARBOUR_COMPILER)

INCLUDE_PATHS=$(HARBOUR_HOME)\include;$(MINGW_HOME)\include
LIB_PATHS=$(HARBOUR_HOME)\lib;$(MINGW_HOME)\lib

OBJS = SQLiteFacadeHelper.o				\
	   SQLiteFacade.o					\
	   SQLiteFacadeRecordSet.o			\
	   SQLiteFacadeRecordSetMockup.o 	\
	   SQLiteFacadeStatement.o

LIB = libsqlite3facade.a

all: $(OBJS)
	$(LINK) -q $(LIB) $(OBJS)

.SUFFIXES: .o .c .prg

.prg.c:
	$(HARBOUR) $(*).prg -i$(INCLUDE_PATHS) $(HARBOUR_FLAGS) /m /n /w3 /es2

.c.o:
	$(CC) -c -Wall $< -o$(*).o  -I$(INCLUDE_PATHS)
