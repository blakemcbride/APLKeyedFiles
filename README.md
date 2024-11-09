
A Keyed File System for GNU APL
===============================
Blake McBride (blake@mcbridemail.com)

This package provides a keyed file system for GNU APL.  Keys are
numbers or strings (character vectors).  The data associated can be
any APL scalar, array, or nested array of any types.  All data is
stored in an Sqlite or PostgreSQL SQL database.  Any number of keyed
files may be created within a single SQL database.  All typical
functionality is provided (i.e. first record, last record, key equal,
key greater. key less, next record, previous record, etc.).

This package depends upon the following:

GNU APL by Juergen Sauermann <juergen.sauermann@t-online.de>
http://www.gnu.org/software/apl/apl.html
Subversion:  http://svn.savannah.gnu.org/svn/apl/trunk


SQL Interface by  Elias Mårtenson <lokedhs@gmail.com>
GIT:  https://github.com/lokedhs/apl-sqlite.git
This library provides an SQL interface to Sqlite & PostgreSQL

Source code available at:  [https://github.com/blakemcbride/APLKeyedFiles](https://github.com/blakemcbride/APLKeyedFiles)
