@echo off
:: LOG_FILENAME, REFRESH_INTERVAL
if "%2" == "" (
	watch tail %1 -n 15
) else (
	watch tail %1 -n %2
)

