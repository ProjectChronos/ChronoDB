@ECHO OFF
TITLE Database Installation Tool
COLOR 0A

:TOP
CLS
ECHO.
ECHO    Please enter your MySQL Info...
ECHO.
SET /p host= MySQL Server Address (e.g. localhost): 
ECHO.
SET /p user= MySQL Username: 
SET /p pass= MySQL Password: 
ECHO.

SET port=3306
SET dumppath=.\dump\
SET mysqlpath=.\mysql\
SET devsql=.\SQL\
SET changsql=.\changesets\


:Begin
CLS
SET v=""
ECHO.
ECHO    I - Import World Database, NOTE! Whole db will be overwritten!
ECHO    W - Backup World Database.
ECHO    C - Backup Character Database.
ECHO.
ECHO    D - Dump your table.
ECHO    S - Change your settings
ECHO.
ECHO    X - Exit this tool
ECHO.
SET /p v= 		Enter a char: 
IF %v%==* GOTO error
IF %v%==i GOTO import
IF %v%==I GOTO import
IF %v%==s GOTO top
IF %v%==S GOTO top
IF %v%==x GOTO exit
IF %v%==X GOTO exit
IF %v%=="" GOTO exit
GOTO error

:import
CLS
ECHO First Lets Create database (or overwrite old) !!
ECHO.
ECHO DROP database IF EXISTS `chrono_world`; > %devsql%\databaseclean.sql
ECHO CREATE database IF NOT EXISTS `chrono_world`; >> %devsql%\databaseclean.sql
%mysqlpath%\mysql --host=%host% --user=%user% --password=%pass% --port=%port% < %devsql%\databaseclean.sql
@DEL %devsql%\databaseclean.sql
ECHO Database chrono_world successfully created !
ECHO.
ECHO Importing files now...
ECHO.
FOR %%C IN (%devsql%\chrono_world.sql) DO (
	ECHO Importing: %%~nxC
	%mysqlpath%\mysql --host=%host% --user=%user% --password=%pass% --port=%port% chrono_world < "%%~fC"
	ECHO Successfully imported %%~nxC
)
ECHO Done.
ECHO.
ECHO.
ECHO Be sure to apply the updates in chrono_world_updates folder to the database!
ECHO.
ECHO.
PAUSE
GOTO exit

:error
ECHO	Please enter a correct character.
ECHO.
PAUSE
GOTO begin

:error2
ECHO	Changeset with this number not found.
ECHO.
PAUSE
GOTO begin

:exit