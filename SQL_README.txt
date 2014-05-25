
SQL interface for GNU APL
Elias Mårtenson <lokedhs@gmail.com>

The SQL package provides an SQL interface for GNU APL.  It supports
Sqlite and PostgreSQL.

GIT Repository located at:  https://github.com/lokedhs/apl-sqlite.git

BUILD INSTRUCTIONS

Before building, on LinuxMint / Ubuntu, install the following packages:
	sqlite3
	sqlite3-dev
	libpq_dev
	libpq5
	

Modify Makefile.  Set APL_DIST to point to the location of the GNU APL
source code.

Type:  make

A file named "lib_sql.so" will be produced.  This is the library file
needed by GNU APL in order to add this functionality.

LOADING

In order to use the SQL library, lib_sql.so must be loaded into APL.
The Keyed file system takes care of this.


USAGE

The following is not needed to use the keyed file system.  The keyed
file routines completely encapsulate all of the SQL routines.  It is
only provided for information.

db = database handle



db←'sqlite' SQL∆Connect '/path/to/mydatabase.db'
	or
db←'postgresql' SQL∆Connect 'host=localhost user=myusername password=mypassword dbname=mydatabase'


...

SQL∆Disconnect db

