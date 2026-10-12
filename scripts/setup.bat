@echo off
rem Clones every OpenVoxel-ModLoader repository next to this one.
setlocal
cd /d "%~dp0..\.."
for %%r in (ModLoader-Client ModLoader-Server ModLoader-ModsExamples ModLoader-Server-Example openvoxel-modloader.github.io) do (
  if exist "%%r" ( echo %%r already exists ) else ( git clone "https://github.com/OpenVoxel-ModLoader/%%r.git" )
)
echo Done. Client: ModLoader-Client\launch.bat   Server: ModLoader-Server\start.bat
