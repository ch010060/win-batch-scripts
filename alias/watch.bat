chcp 65001
@ECHO OFF

:: ���檺���O ( �Ъ`�N�Y�n�ϥ� pipe �Ÿ������b���e�[�W�@�� ^ �Ÿ� )
SET ExecuteCommand=%1 %2 %3 %4 %5

:: ���: ��
SET ExecutePeriod=3


SETLOCAL EnableDelayedExpansion

:loop

  cls

  echo.

  %ExecuteCommand%
  
  timeout /t %ExecutePeriod% > nul

goto loop