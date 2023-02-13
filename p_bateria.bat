:extraeDataBateria
for /f "tokens=2 delims==" %%f in ('WMIC Path Win32_Battery Get SystemName /value ^| FIND "="') do set "NE=%%f"
echo %NE%
for /f "tokens=2 delims==" %%f in ('WMIC Path Win32_Battery Get BatteryStatus /value ^| FIND "="') do set "EC=%%f"
if %EC%==1 (goto :conBateria) else (goto :conCargador)
:conCargador
set MEC=cargando...
echo %MEC%
goto :cargaBateria
:conBateria
set MEC=Bateria en uso
echo %MEC%
goto :cargaBateria
:cargaBateria
for /f "tokens=2 delims==" %%f in ('WMIC Path Win32_Battery Get EstimatedChargeRemaining /value ^| FIND "="') do set "CA=%%f%%"
echo %CA%

for /f "tokens=2 delims==" %%f in ('WMIC Path Win32_Battery Get EstimatedRunTime /value ^| FIND "="') do set "TD=%%f"
echo %TD%
pause
set /a horas=%TD%/60
set /a minutos=%TD%%%60
echo %horas% con %minutos%
pause
:mensajeTelegram
curl -s -X POST https://api.telegram.org/bot"1234567890:XXXXX0xxxxxxxxxxxxxxxxxxxxxxxxxxxxx"/sendMessage -d chat_id="12345678" -d text="==========================="
curl -s -X POST https://api.telegram.org/bot"1234567890:XXXXX0xxxxxxxxxxxxxxxxxxxxxxxxxxxxx"/sendMessage -d chat_id="12345678" -d text="Nombre del Equipo: %NE%"
curl -s -X POST https://api.telegram.org/bot"1234567890:XXXXX0xxxxxxxxxxxxxxxxxxxxxxxxxxxxx"/sendMessage -d chat_id="12345678" -d text="%MEC%"
curl -s -X POST https://api.telegram.org/bot"1234567890:XXXXX0xxxxxxxxxxxxxxxxxxxxxxxxxxxxx"/sendMessage -d chat_id="12345678" -d text="%CA%"
curl -s -X POST https://api.telegram.org/bot"1234567890:XXXXX0xxxxxxxxxxxxxxxxxxxxxxxxxxxxx"/sendMessage -d chat_id="12345678" -d text="Quedan %horas% h: %minutos% m"
curl -s -X POST https://api.telegram.org/bot"1234567890:XXXXX0xxxxxxxxxxxxxxxxxxxxxxxxxxxxx"/sendMessage -d chat_id="12345678" -d text="===========LKV===========" 
pause
:conteoEjecutar
set /a t=%minutos%*60
echo esperaremos %t% segundos
timeout /t %t% /nobreak >nul