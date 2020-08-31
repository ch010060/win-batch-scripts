@echo off

SET START=1
SET END=50
SET STEP=1
SET PREFIX=""
SET POSTFIX=""

for /l %%x in (%START%, %STEP%, %END%) do (
   md %PREFIX%%%x%POSTFIX%
)
