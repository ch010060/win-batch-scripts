@echo off
if "%1" == "mem" (
	tasklist | sort /+58
) else (
	if "%1" == "cpu" (
		pslist -s 1
	) else (
		tasklist
	)
)
