@echo off
for /f %%f in ('dir C:\Users\%USERNAME%\Downloads\script\alias\ /b /a:-d \*.bat 2^>nul') do echo %%~nf
