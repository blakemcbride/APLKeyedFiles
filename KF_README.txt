
Keyed File system instructions

The SQL library must be built prior to using the keyed file system.
See SQL_README.txt

The keyed file system utilizes the workspace named KeyedFiles.  This
is contained in a file names KeyedFiles.xml
This workspace contains all of the functions you will need.
You may need to copy this file into your workspaces directory.

After loading the KeyedFiles workspace, you will need to load the SQL
shared library.  You can do this with the following command:

SQL∆LoadLib '/home/blake/Backup/apl-sqlite.git/lib_sql.so'

Your complete path to lib_sql.so (created via the instructions in
SQL_README.txt) will be different.

In the instructions that follow, the following variables have the
specified meanings:

DBTYPE = 'sqlite' or 'postgresql'

DBSPEC (for sqlite) = '/path/to/myfiles.db'
  or
DBSPEC (for postgresql) = 'host=localhost user=myusername password=mypassword dbname=myfiles'

Note: In the case of sqlite, if myfiles.db does not exist, the system
will create it.  In the case of PostgreSQL, the database (like
myfiles) must already exist.

db = database handle

kf = keyed file handle
(Any number of keyed files can be in a single database.)

key = scalar number or character vector

val = arbitrary data to be associated with key (may be nested array)

pair = key val
Two element nested vecor.  The first element is a key.
The second element is the value associated with the key.

--------------------

db←DBTYPE KF∆DBCreate DBSPEC      initialize and open a new SQL DB
(This must be done exactly once for either type of database.)

db←DBTYPE KF∆DBConnect DBSPEC     open a database
(This is done thereafter to use the database.)


kf←db KF∆Create 'myfile'               create a new file (table in the DB)

kf←db KF∆Open 'myfile'                 open an existing file

kf KF∆Put[key] val                     add val to kf associated with key

val←kf KF∆Get key                      get value associated with key

pair←kf KF∆EQ key                      read record equal to key

pair←kf KF∆GT key                      read record greater than key

pair←kf KF∆GE key                      read record greater than or equal to key

pair←kf KF∆LT key                      read record less than key

pair←kf KF∆LE key                      read record less than or equal to key

pair←KF∆First kf                       read first record in key order

pair←KF∆Last kf                        read last record in key order

r←kf KF∆Exists key                     does key existin file (1 or 0)

r←KF∆Count kf                          number of records

kf KF∆Delete key                       delete key/data from file

kf←KF∆Close kf                         close file

db KF∆Drop 'myfile'                    delete whole file

files←KF∆Files db                      list of existing files

r←db KF∆FileExists 'myfile'            does files exist (1 or 0)

KF∆Disconnect db                       disconnect from database


