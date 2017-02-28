@echo off

echo.
echo Accord.NET Framework compressed archive builder
echo =========================================================
echo. 
echo This Windows batch file uses WinRAR to automatically
echo build the compressed archive version of the framework.
echo. 


:: Settings for complete and (libs-only) package creation
:: ---------------------------------------------------------

set /p version=<"..\..\Version.txt"
set rar="C:\Program Files\WinRAR\rar"
set fullname="Accord.NET-%version%-archive.rar" 
set libsname="Accord.NET-%version%-libsonly.rar"
set opts=a -m5 -s


echo  - Framework version: %version%
echo  - Complete package : %fullname%     
echo  - Lib-only package : %libsname%
echo.
echo  - WinRAR Command: %rar%
echo  - WinRAR Options: "%opts%"
echo.

timeout /T 10


echo.
echo.
echo Creating Accord.NET %fullname% archive
echo ---------------------------------------------------------

timeout /T 5
mkdir ..\bin
set output=..\bin\%fullname%
del %output%

set ignore=-x*.tmp -x*\.vs -x*.suo -x*.user -x*.vsp -x*.pidb -x*SlimDX.pdb -x*.sdf -x*\obj -x*\.svn* -x*.lastcodeanalysissucceeded -x*.CodeAnalysisLog.xml -x*.VC.db -x*.VC.opendb

%rar% %opts%    %output% "..\..\Contributors.txt"
%rar% %opts%    %output% "..\..\Copyright.txt"
%rar% %opts%    %output% "..\..\License.txt"
%rar% %opts%    %output% "..\..\Release notes.txt"
%rar% %opts%    %output% "..\..\Version.txt"
%rar% %opts%    %output% "..\..\Docs\*.chm"        
%rar% %opts% -r %output% "..\..\Release\*"          %ignore%
%rar% %opts% -r %output% "..\..\Debug\*"            %ignore%
%rar% %opts% -r %output% "..\..\Sources\*"          %ignore%         -x*\TestResults -x*\Accord.Music -x*.shfbproj_* 
%rar% %opts% -r %output% "..\..\Unit Tests\*"       %ignore% -x*\bin -x*\TestResults -x*\Accord.Music -x*.shfbproj_* 
%rar% %opts% -r %output% "..\..\Samples\*"          %ignore% -x*\bin\x64\ -x*\bin\Debug -x*\bin\Release -x*\bin\x86\Debug -x"*\bin\x86\Release 3.5" -x*\packages 
%rar% %opts% -r %output% "..\..\Externals\*"        %ignore% -x*.pdb 
%rar% %opts% -r %output% "..\..\Setup\*"            %ignore% -x*\bin 
%rar% t         %output%




echo.
echo Creating Accord.NET %libsname% archive
echo ---------------------------------------------------------

timeout /T 5
set output=..\bin\%libsname%
del %output%

%rar% %opts%    %output% "..\..\Contributors.txt"
%rar% %opts%    %output% "..\..\Copyright.txt"
%rar% %opts%    %output% "..\..\License.txt"
%rar% %opts%    %output% "..\..\Release notes.txt"
%rar% %opts%    %output% "..\..\Version.txt"
%rar% %opts% -r %output% "..\..\Release\*"          %ignore%
%rar% %opts% -r %output% "..\..\Debug\*"            %ignore%
%rar% t         %output%



echo.
echo ---------------------------------------------------------
echo Package creation has completed. Please check the above
echo commands for errors and check packages in output folder.
echo ---------------------------------------------------------
echo.

timeout /T 10
