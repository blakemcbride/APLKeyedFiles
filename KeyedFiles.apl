#!/usr/local/bin/apl --script
 ⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝
⍝
⍝ KeyedFiles 2018-01-06  20:09:36 (GMT-5)
 ⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝

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

∇Z←SQL∆Begin Y
 Z←SQL[5] Y
∇

∇Z←SQL∆Commit Y
 Z←SQL[6] Y
∇

∇Z←X SQL∆Connect Y
 Z←X SQL[1] Y
∇

∇Z←SQL∆Disconnect Y
 Z←SQL[2] Y
∇

∇Z←X SQL∆Exec[db] Y
 Z←X SQL[4,db] Y
∇

∇SQL∆LoadLib path
 →(0≠⎕NC 'SQL')/SKIP
 →('SQL'≡path ⎕FX 'SQL')/SKIP
 ⎕ES 'Error loading SQL library'
 SKIP:
∇

∇Z←SQL∆Rollback Y
 Z←SQL[7] Y
∇

∇Z←X SQL∆Select[db] Y
 Z←X SQL[3,db] Y
∇

∇Z←SQL∆Tables Y
 Z←SQL[8] Y
∇

∇Z←X (F SQL∆WithTransaction FINDDB) Y;result
 SQL∆Begin FINDDB
 →(0≠⎕NC 'X')/dyadic
 result ← '→rollback' ⎕EA 'F Y'
 →commit
 dyadic:
 result ← '→rollback' ⎕EA 'X F Y'
 commit:
 SQL∆Commit FINDDB
 Z ← result
 →end
 rollback:
 SQL∆Rollback FINDDB
 ⎕ES "Transaction rolled back"
 end:
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

