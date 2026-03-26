#define MyAppName "RustDesk"
#define MyAppVersion "1.4.6"
#define MyAppPublisher "RustDesk"
#define MyAppExeName "rustdesk.exe"
#define BuildDir "G:\zhuomian\rustdesk-master\flutter\build\windows\x64\runner\Release"

[Setup]
AppId={{51BCFE39-34CB-45DB-922D-AD4AB71FE997}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName={autopf}\{#MyAppName}
DefaultGroupName={#MyAppName}
OutputDir=G:\zhuomian\
OutputBaseFilename=RustDesk_Setup_v1.4.6
Compression=lzma2/max
SolidCompression=yes
PrivilegesRequired=admin
; 极简一键安装体验，跳过繁杂向导
DisableWelcomePage=yes
DisableDirPage=yes
DisableProgramGroupPage=yes
DisableReadyPage=yes

[Files]
Source: "{#BuildDir}\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"

[Registry]
Root: HKLM; Subkey: "SOFTWARE\RustDesk"; ValueType: string; ValueName: "InstallLocation"; ValueData: "{app}"; Flags: uninsdeletekey
Root: HKLM; Subkey: "SOFTWARE\RustDesk"; ValueType: string; ValueName: "Version"; ValueData: "{#MyAppVersion}"; Flags: uninsdeletekey
Root: HKLM; Subkey: "SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers"; ValueType: string; ValueName: "{app}\{#MyAppExeName}"; ValueData: "~ RUNASADMIN"; Flags: uninsdeletevalue

[Run]
Filename: "{app}\{#MyAppExeName}"; Flags: nowait postinstall; Description: "Launch {#MyAppName}"

[Code]
procedure CurStepChanged(CurStep: TSetupStep);
var
  ResultCode: Integer;
begin
  if CurStep = ssInstall then
  begin
    Exec('cmd.exe', '/c sc stop RustDesk', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
    Exec('cmd.exe', '/c sc delete RustDesk', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
    Exec('cmd.exe', '/c taskkill /F /IM rustdesk.exe /T', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
  end;
end;
