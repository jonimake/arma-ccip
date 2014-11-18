::Made by eRazeri
@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

SET DSSignFile="C:\Steam\SteamApps\common\Arma 3 Tools\DSSignFile\DSSignFile.exe"    
SET PRIVATEKEY="C:\Steam\SteamApps\common\Arma 3 Tools\DSSignFile\privakeys\CCIP_v0.1a.biprivatekey"

FOR %%i IN (*.pbo) DO %DSSignFile% %PRIVATEKEY% "%CD%\%%i"