@ECHO OFF

REM ============================================================================
REM Windows startup script for Jalopy Source Code Formatter
REM ============================================================================
REM
REM Startup script for the Jalopy console Plug-in. This script assumes the
REM following directory structure:
REM
REM    ..
REM    /bin          contains this script
REM    /lib          contains the Jalopy libraries
REM

IF "%OS%"=="Windows_NT" GOTO winNTStart

ECHO Error: This script requires Windows NT, 2000 or XP!
GOTO mainEnd

:winNTStart
@setlocal

REM Need to check if we are using the 4NT shell
IF "%eval[2+2]" == "4" GOTO setup4NT

REM On NT/2K grab all arguments at once
SET JALOPY_CMD_LINE_ARGS=%*
GOTO doneStart

:setup4NT
SET JALOPY_CMD_LINE_ARGS=%$
GOTO doneStart

:doneStart
REM This label provides a place for the argument list loop to break out
REM and for NT handling to skip to.

:checkJava
SET _JAVACMD=%JAVACMD%

IF "%JAVA_HOME%" == "" GOTO noJavaHome
IF "%_JAVACMD%" == "" SET _JAVACMD=%JAVA_HOME%\bin\java
GOTO runJalopy

:noJavaHome
IF "%_JAVACMD%" == "" SET _JAVACMD=java
ECHO.
ECHO Warning: JAVA_HOME environment variable is not set.
ECHO   You may need to set the JAVA_HOME environment variable
ECHO   to the installation directory of Java.
ECHO.

:runJalopy
"%_JAVACMD%" -classpath "%~d0%~p0..\lib\jalopy-1.9.4.jar" Jalopy %JALOPY_CMD_LINE_ARGS%
GOTO end

:end
SET _JAVACMD=
SET JALOPY_CMD_LINE_ARGS=
REM EXIT %ERRORLEVEL%

@endlocal

:mainEnd
