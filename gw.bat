@echo off
for /f "tokens=2,3 delims={,}" %%a in ('"WMIC NICConfig where IPEnabled="True" get DefaultIPGateway /value | find "I" "') do set DefaultIPGateway=%%~a
route add 10.0.0.0 mask 255.0.0.0 %DefaultIPGateway%
echo "setup direct route for local traffic"
pause