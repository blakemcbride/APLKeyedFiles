#!/usr/local/bin/apl --script
 ⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝
⍝                                                                    ⍝
⍝ KeyedFiles.apl                       2022-03-22  08:08:54 (GMT-5)  ⍝
⍝                                                                    ⍝
 ⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝

∇r←KF∆Close kf
 r←''
∇

∇r←KF∆Count kf;⎕IO
 ⎕IO←1
 r←''⍴('select count(*) from ',(⊃kf[2])) SQL∆Select[kf[1]]''
∇

∇r←db KF∆Create file;cmd
 ⎕ES(db KF∆FileExists file)/'FILE ALREADY EXISTS ERROR'
 cmd←'CREATE TABLE ',file,' ('
 cmd←cmd,'skey CHARACTER VARYING(80) NOT NULL PRIMARY KEY, '
 cmd←cmd,'sdata CHARACTER VARYING(2000),'
 cmd←cmd,'ldata text);'
 r←cmd SQL∆Exec[db] ''
 r←'insert into _apl_keyed_files (file_name) values (?);' SQL∆Exec[db] ⊂file
 r←db file
∇

∇db←type KF∆DBConnect params
 ⍎(0=⎕NC 'SQL')/'⎕ES(''SQL''≢''lib_sql.so''⎕FX''SQL'')/''Error loading SQL library'''
 db←type SQL∆Connect params
∇

∇db←type KF∆DBCreate params;cmd
 ⍎(0=⎕NC 'SQL')/'⎕ES(''SQL''≢''lib_sql.so''⎕FX''SQL'')/''Error loading SQL library'''
 db←type SQL∆Connect params
 cmd←'create table _apl_keyed_files ('
 cmd←cmd,'file_name character varying (80) not null unique);'
 cmd←cmd SQL∆Exec[db]''
∇

∇r←kf KF∆Delete key;⎕IO;t
 ⎕IO←1
 t←('delete from ',(⊃kf[2]),' where skey=?;') SQL∆Exec[kf[1]]⊂⍕key
∇

∇KF∆Disconnect db
 SQL∆Disconnect db
∇

∇db KF∆Drop file;t
 t←('drop table ',file) SQL∆Exec[db]''
 t←'delete from _apl_keyed_files where file_name=?;' SQL∆Exec[db] ⊂file
∇

∇r←kf KF∆EQ key;⎕IO
 ⎕IO←1
 r←('select skey, sdata, ldata from ',(⊃kf[2]),' where skey=?') SQL∆Select[kf[1]]⊂,key
 →(1=⍴⍴r)/0
 r←r[1] ¯14 ⎕CR (⊃r[2]),⊃(r←,r)[3]
∇

∇r←kf KF∆Exists key;⎕IO
 ⎕IO←1
 r←~(1=⍴⍴r)∧0=1↑⍴r←('select skey from ',(⊃kf[2]),' where skey=?;') SQL∆Select[kf[1]]⊂⍕key
∇

∇r←db KF∆FileExists file
 r←(⊂,file)∊KF∆Files db
∇

∇files←KF∆Files db
 files←'select file_name from _apl_keyed_files;' SQL∆Select[db]''
∇

∇r←KF∆First kf;⎕IO
 ⎕IO←1
 r←('select skey, sdata, ldata from ',(⊃kf[2]),' order by skey limit 1') SQL∆Select[kf[1]]''
 →(1=⍴⍴r)/0
 r←r[1] ¯14 ⎕CR (⊃r[2]),⊃(r←,r)[3]
∇

∇r←kf KF∆GE key;⎕IO
 ⎕IO←1
 r←('select skey, sdata, ldata from ',(⊃kf[2]),' where skey>=? limit 1') SQL∆Select[kf[1]]⊂,key
 →(1=⍴⍴r)/0
 r←r[1] ¯14 ⎕CR (⊃r[2]),⊃(r←,r)[3]
∇

∇r←kf KF∆GT key;⎕IO
 ⎕IO←1
 r←('select skey, sdata, ldata from ',(⊃kf[2]),' where skey>? limit 1') SQL∆Select[kf[1]]⊂,key
 →(1=⍴⍴r)/0
 r←r[1] ¯14 ⎕CR (⊃r[2]),⊃(r←,r)[3]
∇

∇r←kf KF∆Get key;⎕IO
 ⎕IO←1
 r←('select sdata, ldata from ',(⊃kf[2]),' where skey=?') SQL∆Select[kf[1]]⊂key
 →(1=⍴⍴r)/0
 r←¯14 ⎕CR (⊃r[1]),⊃(r←,r)[2]
∇

∇r←kf KF∆LE key;⎕IO
 ⎕IO←1
 r←('select skey, sdata, ldata from ',(⊃kf[2]),' where skey<=? limit 1') SQL∆Select[kf[1]]⊂,key
 →(1=⍴⍴r)/0
 r←r[1] ¯14 ⎕CR (⊃r[2]),⊃(r←,r)[3]
∇

∇r←kf KF∆LT key;⎕IO
 ⎕IO←1
 r←('select skey, sdata, ldata from ',(⊃kf[2]),' where skey<? limit 1') SQL∆Select[kf[1]]⊂,key
 →(1=⍴⍴r)/0
 r←r[1] ¯14 ⎕CR (⊃r[2]),⊃(r←,r)[3]
∇

∇r←KF∆Last kf;⎕IO
 ⎕IO←1
 r←('select skey, sdata, ldata from ',(⊃kf[2]),' order by skey desc limit 1') SQL∆Select[kf[1]]''
 →(1=⍴⍴r)/0
 r←r[1] ¯14 ⎕CR (⊃r[2]),⊃(r←,r)[3]
∇

∇r←db KF∆Open file
 ⎕ES(~db KF∆FileExists file)/'FILE DOES NOT EXIST'
 r←db file
∇

∇kf KF∆Put[key] data;r;tbl;⎕IO
 ⎕IO←1
 data←14 ⎕CR data
 r←('select skey from ',(tbl←⊃kf[2]),' where skey=?;') SQL∆Select[kf[1]]⊂key←⍕key
 →((1=⍴⍴r)∧0=1↑⍴r)/NEW
 →(2000<⍴data)/BIG∆CHANGE
 r←('update ',tbl,' set sdata=?,ldata=null where skey=?;')SQL∆Exec[kf[1]] data key
 →0
 BIG∆CHANGE: r←('update ',tbl,' set sdata=null,ldata=? where skey=?;')SQL∆Exec[kf[1]] data key
 →0
 NEW:→(2000<⍴data)/BIG∆NEW
 r←('insert into ',tbl,' (skey, sdata) values (?, ?);')SQL∆Exec[kf[1]] key data
 →0
 BIG∆NEW:r←('insert into ',tbl,' (skey, ldata) values (?, ?);')SQL∆Exec[kf[1]] key data
∇

∇z←fnm KF∆Rename[db] nfnm
 ⎕ES(0=⎕NC'fnm')/'MISSING ARGUMENT'
 ⎕ES((0=⍴,fnm)∨(' '≠1↑0⍴fnm)∨(1<⍴⍴fnm)∨1<≡fnm)/'INVALID ORIGINAL FILE NAME'
 ⎕ES((0=⍴,nfnm)∨(' '≠1↑0⍴nfnm)∨(1<⍴⍴nfnm)∨1<≡nfnm)/'INVALID NEW FILE NAME'
 ⎕ES(~db KF∆FileExists fnm)/'ORIGINAL FILE NAME DOES NOT EXIST'
 ⎕ES(db KF∆FileExists nfnm)/'NEW FILE NAME ALREADY EXISTS'
 '⎕ES''RENAME ERROR'''⎕EA'z←(''alter table '',fnm,'' rename to '',nfnm,'';'') SQL∆Exec[db]'''''
 '⎕ES''RENAME ERROR'''⎕EA'z←''update _apl_keyed_files set file_name=? where file_name=?;'' SQL∆Exec[db] nfnm fnm'
 z←db nfnm
∇

⍝ function SQL has ufun1 pointer 0!

∇Z←SQL∆Begin db
 ⍝⍝ Begin a transaction.
 Z←⎕SQL[5] db
∇

∇Z←db SQL∆Columns table
 ⍝⍝ Return an array containing information about the columns in the
 ⍝⍝ given table. Currently, the column layout is as follows:
 ⍝⍝
 ⍝⍝   Name
 ⍝⍝   Type
 ⍝⍝
 ⍝⍝ More columns containing extra information may be added in a future
 ⍝⍝ release.
 Z←db ⎕SQL[9] table
∇

∇Z←SQL∆Commit db
 ⍝⍝ Commit a transaction.
 Z←⎕SQL[6] db
∇

∇Z←type SQL∆Connect arg
 ⍝⍝ Connect to database of type L using connection arguments R.
 ⍝⍝
 ⍝⍝ L must be a string indicating the database type. Current supported
 ⍝⍝ values are 'postgresql' and 'sqlite'.
 ⍝⍝
 ⍝⍝ R is the connection parameters which depends on the type of
 ⍝⍝ database:
 ⍝⍝
 ⍝⍝   - For type≡'sqlite': the argument is string pointing to the
 ⍝⍝     database file.
 ⍝⍝
 ⍝⍝   - For type≡'postgresql', the argument is a standard connect
 ⍝⍝     string as described in the PostgreSQL documentation.
 ⍝⍝
 ⍝⍝ This function returns a database handle that should be used when
 ⍝⍝ using other SQL functions. This value should be seen as an opaque
 ⍝⍝ handle. It is, however, guaranteed that the handle is a scalar
 ⍝⍝ value.
 Z←type ⎕SQL[1] arg
∇

∇Z←SQL∆Disconnect db
 ⍝⍝ Disconnect from database R.
 ⍝⍝
 ⍝⍝ R is the database handle that should be disconnected. After this
 ⍝⍝ function has been called, no further operations are to be performed
 ⍝⍝ on this handle. Future calls to SQL∆Connect may reuse previously
 ⍝⍝ disconnected handles.
 Z←⎕SQL[2] db
∇

∇Z←statement SQL∆Exec[db] args
 ⍝⍝ Execute an SQL statement that does not return a result.
 ⍝⍝
 ⍝⍝ This function is identical to SQL∆Select with the exception that it
 ⍝⍝ is used on statements which do not return a result table.
 Z←statement ⎕SQL[4,db] args
∇

∇SQL∆LoadLib path
 →(0≠⎕NC 'SQL')/SKIP
 →('SQL'≡path ⎕FX 'SQL')/SKIP
 ⎕ES 'Error loading SQL library'
 SKIP:
∇

∇Z←SQL∆Rollback db
 ⍝⍝ Rolls back the current transaction.
 Z←⎕SQL[7] db
∇

∇Z←statement SQL∆Select[db] args
 ⍝⍝ Execute a select statement and return the result table.
 ⍝⍝
 ⍝⍝ The axis parameter indicates the database handle.
 ⍝⍝
 ⍝⍝ L is a select statement to be executed. Positional parameters can
 ⍝⍝ be supplied by specifying a question mark "?" in the statemement.
 ⍝⍝
 ⍝⍝ R is an array containing the values for the positional parameters.
 ⍝⍝ If the array is of rank 2, the statement will be executed multiple
 ⍝⍝ times with each row being the values for each call.
 ⍝⍝
 ⍝⍝ The return value is a rank-2 array representing the result of the
 ⍝⍝ select statement. Null values are returned as ⍬ and empty strings
 ⍝⍝ are returned as ''.
 Z←statement ⎕SQL[3,db] args
∇

∇Z←SQL∆Tables db
 ⍝⍝ Return an array containing the name of all tables.
 Z←⎕SQL[8] db
∇

∇Z←db (F SQL∆WithTransaction) R;result
 ⍝⍝ Call function F inside a transaction. F will be called with
 ⍝⍝ argument R. If an error occurs while F runs, the transaction will
 ⍝⍝ be rolled back.
 SQL∆Begin db
 result ← '→rollback' ⎕EA 'F R'
 commit:
 SQL∆Commit db
 Z ← result
 →end
 rollback:
 SQL∆Rollback db
 ⎕ES "Transaction rolled back"
 end:
∇

∇Z←SQL⍙metadata
 Z ← ,[0.5] 'Author' 'Elias Mårtenson'
 Z ← Z,[1] 'BugEmail' 'bug-apl@gnu.org'
 Z ← Z,[1] 'Documentation' ''
 Z ← Z,[1] 'Download' 'https://github.com/lokedhs/apl-sqlite'
 Z ← Z,[1] 'License' 'LGPL'
 Z ← Z,[1] 'Portability' 'L3'
 Z ← Z,[1] 'Provides' 'SQL'
 Z ← Z,[1] 'Requires' ''
 Z ← Z,[1] 'Version' '1.0'
∇

⎕CT←1E¯13

⎕FC←(,⎕UCS 46 44 8902 48 95 175)

⎕IO←1

⎕L←0

⎕LX←' ' ⍝ proto 1
  ⎕LX←0⍴⎕LX ⍝ proto 2

⎕PP←10

⎕PR←,' '

⎕PS←0 0

⎕PW←80

⎕R←0

⎕RL←1

⎕TZ←¯5

⎕X←0

