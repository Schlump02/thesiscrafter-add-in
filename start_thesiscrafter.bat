@echo off

set "githubRepoUrl=https://github.com/Schlump02/thesiscrafter-frontend.git"
set "localRepoPath=%APPDATA%\thesiscrafter"

:: Check if Git is installed
git --version 2>nul
if %errorlevel% neq 0 (
    echo Git is not installed. Installing Git...
    
    :: Install Git using winget
    winget install -e --id=Git.Git

    :: Check if installation was successful
    git --version 2>nul
    if %errorlevel% neq 0 (
        echo Failed to install Git. Please install Git manually and run the script again.
        exit /b 1
    )
) else (
    echo Git is already installed.
)

:: Check if npm is installedcall npm -v 2>nul
call npm -v 2>nul
if %errorlevel% neq 0 (
    echo npm is not installed. Installing npm...
    
    :: Install npm using winget
    winget install -e --id=Node.js.NodeJS

    :: Check if installation was successful
    call npm -v 2>nul
    if %errorlevel% neq 0 (
        echo Failed to install npm. Please install npm manually and run the script again.
        exit /b 1
    )
) else (
    echo npm is already installed.
)

:: Create localRepoPath if it doesn't exist
if not exist "%localRepoPath%" (
    echo Creating directory: %localRepoPath%
    mkdir "%localRepoPath%" || (
        echo Failed to create directory. Exiting...
        exit /b 1
    )
) else (
    echo Directory already exists.
)

:: Clone or pull the repository
if exist "%localRepoPath%\thesiscrafter-frontend" (
    echo Repository exists. Pulling changes...
    cd "%localRepoPath%\thesiscrafter-frontend"
    git pull
) else (
    echo Cloning repository...
    cd "%localRepoPath%"
    git clone "%githubRepoUrl%"
)

:: run the add-in and enable sideloading
echo Running npm start...
cd "%localRepoPath%\thesiscrafter-frontend"
call npm run start

pause