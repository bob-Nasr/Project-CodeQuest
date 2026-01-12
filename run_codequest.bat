@echo off
title CodeQuest Launcher

echo ================================
echo Starting CodeQuest Project
echo ================================

REM ---- Start Backend ----
echo Starting PHP Backend...
start "CodeQuest Backend" cmd /k "cd backend && php -S 127.0.0.1:8000"

REM ---- Give backend time to start ----
timeout /t 5 >nul

REM ---- Start Flutter Frontend ----
echo Starting Flutter Frontend (Windows Desktop)...
start "CodeQuest Frontend" cmd /k "cd code_learning_app && rmdir /s /q build 2>nul & flutter clean & flutter run -d windows"

echo ================================
echo Backend and Frontend Launched
echo ================================
pause
