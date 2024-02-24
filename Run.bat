echo off
setlocal EnableDelayedExpansion
cls

pushd %~dp0

start "" "Dependencies\python-embed-amd64\pythonw.exe" PythonQt.py

exit %errorlevel%