@echo off
for /d %%f in (%1*) do rmdir /s/q "%%f"
