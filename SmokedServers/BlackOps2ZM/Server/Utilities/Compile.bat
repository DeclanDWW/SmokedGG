@echo off

set "script_dir=%~dp0"
set "compiler=C:\inetpub\wwwroot\SmokedGG\SmokedServers\BlackOps2ZM\Compiler\Compiler.exe"

for %%F in (%*) do (
    echo Processing: %%~nxF
    pushd "%%~dpF"
    "%compiler%" "%%~nxF"
    popd
)