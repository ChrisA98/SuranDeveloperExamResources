@echo off
chris_adkins_homework02_ForwardSort.py
chris_adkins_homework02_ReverseSort.py

fc Sorted.txt Test_Sorted_Forward.txt > nul
if errorlevel 1 goto error1

echo Sort 1 passed
goto check2

:error1
echo Sort 1 failed

:check2
fc Sorted_Rev.txt Test_Sorted_Backward.txt > nul
if errorlevel 1 goto error2

echo Sort 2 passed
goto end

:error2
echo Sort 2 failed

:end
Pause