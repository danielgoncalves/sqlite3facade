#
# test/Makefile
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

SRC=main.prg
EXE=sqlite3_tests.exe

LIBS=-Wl,--start-group \
-lhbct -lhbextern -lhbdebug -lhbvm -lhbrtl -lhblang \
-lhbcpage -lgtcgi -lgtpca -lgtstd -lgtwin -lgtwvt -lgtgui -lhbrdd -lhbuddall \
-lhbusrrdd -lrddntx -lrddcdx -lrddnsx -lrddfpt -lhbrdd -lhbhsx -lhbsix \
-lhbmacro -lhbcplr -lhbpp -lhbcommon -lkernel32 -luser32 -lgdi32 -ladvapi32 \
-lws2_32 -lwinspool -lcomctl32 -lcomdlg32 -lshell32 -luuid -lole32 -loleaut32 \
-lmpr -lwinmm -lmapi32 -limm32 -lmsimg32 -lwininet -lhbpcre -lhbzlib \
-lhbwin -lxhb -lhbsqlit3 -lsqlite3 -lsqlite3facade \
-Wl,--end-group

C_SRC=$(SRC:.prg=.c)
OBJ=$(C_SRC:.c=.o)

CC=gcc
CFLAGS=-Wall -O3
LDFLAGS=-mwindows

HARBOUR=harbour.exe
HARBOUR_FLAGS=/m /n /w3 /es2 
DEPLOY_DIR=..\..\build
HB_INC_INSTALL=C:\harbourmgw\include;C:\MinGW\include;$(DEPLOY_DIR)


LIB_DIR=-LC:\MinGW\lib -LC:\harbourmgw\lib -L$(DEPLOY_DIR)

.PHONY : all
all: $(OBJ)
	$(CC) $(OBJ) $(LIB_DIR) $(LDFLAGS) -o $(EXE) $(LIBS)

.SUFFIXES: .o .c .prg
.prg.c:
	$(HARBOUR) $< -i$(HB_INC_INSTALL) $(HARBOUR_FLAGS)

.c.o:
	$(CC) -c $(*).c $(CFLAGS) -I$(DEPLOY_DIR) $(LIB_DIR)

# WARNING: never put something like "del $(C_SRC)" here!
.PHONY : clean
clean:
	
