@echo off
@chcp 932 >nul
rem Aviutl �C���X�g�[���[
rem Script by haz3mn
rem ���̃X�N���v�g�Ŕ����������Q�͕ۏ؂��܂���B
rem ���̃X�N���v�g��Windows�f�t�H���g��PowerShell���K�v�ł��B
rem ���̃X�N���v�g�̎��s�ɂ̓C���^�[�l�b�g�ڑ����K�v�ł��B(Wi-Fi�A�L��LAN�ǂ���ł�OK)
rem Aviutl��v���O�C���Ȃǂ̎g������Youtube�Ȃǂ��Q�Ƃ��Ă��������B
rem �����_�ł�Windows 11 24H2�œ���m�F�ς݂ł��B
setlocal
set ScriptVersion=1.0
title Aviutl �C���X�g�[���[ %ScriptVersion%
echo ---------------------------------------------------
echo Aviutl �C���X�g�[���[ %ScriptVersion%
echo by haz3mn
echo Aviutl �� C:\Aviutl �ɃC���X�g�[������܂��B
echo ---------------------------------------------------
timeout /t 2 >nul
rem Aviutl���C���X�g�[�����邩�q�˂�
choice /c YN /m "Aviutl���C���X�g�[�����܂���"
if %errorlevel% == 1 (
rem �C���X�g�[������
rem ��. �̓X�e�b�v
rem curl �� Invoke-WebRequest �̓_�E�����[�h
rem Expand-Archive �͓W�J
echo 1. �f�B���N�g�����쐬��..
if not exist "C:\Aviutl" mkdir C:\Aviutl
cd C:\Aviutl
echo 2. �_�E�����[�h��..
curl -o aviutl110.zip https://spring-fragrance.mints.ne.jp/aviutl/aviutl110.zip
if not exist aviutl110.zip goto :error_aviutl_download
echo 3. �W�J��..
powershell -Command "Expand-Archive -Path \"aviutl110.zip\" -DestinationPath \".\""
if not exist "aviutl.exe" goto :error_aviutl_extract
echo 4. �g���ҏW���_�E�����[�h��..
curl -o exedit92.zip https://spring-fragrance.mints.ne.jp/aviutl/exedit92.zip
if not exist "exedit92.zip" goto :error_download_exedit
echo 5. �g���ҏW��W�J��..
powershell -Command "Expand-Archive -Path \"exedit92.zip\" -DestinationPath '.'"
if not exist "exedit.auf" goto :error_extract_exedit
echo 6. x264guiEx ���_�E�����[�h��..
curl -L https://github.com/rigaya/x264guiEx/releases/download/3.31/x264guiEx_3.31v3.zip -o x264guiEx_3.31v3.zip
if not exist "x264guiEx_3.31v3.zip" goto :error_download_x264guiex
echo 7. x264guiEx ��W�J��..
powershell -Command "Expand-Archive -Path \"x264guiEx_3.31v3.zip\" -DestinationPath \".\""
if not exist "x264guiEx_3.31v3" goto :error_extract_x264guiex
echo 8. x264guiEx ���R�s�[��..
xcopy ".\x264guiEx_3.31v3\*" "." /e /i /y /h
if errorlevel 5 goto :error_cp_x264guiex_reason_write_err
if errorlevel 4 goto :error_cp_x264guiex_reason_disk_or_memory_space
if errorlevel 1 goto :error_cp_x264guiex_reason_notfound
if errorlevel 0 echo x264guiEx�̃R�s�[���������܂����B
echo 9. patch.aul ���_�E�����[�h��..
curl -L https://github.com/nazonoSAUNA/patch.aul/releases/download/r43_72/patch.aul_r43_ss_72.zip -o patch.aul_r43_ss_72.zip
if not exist "patch.aul_r43_ss_72.zip" goto :error_download_patchaul
echo 10. patch.aul ��W�J��..
powershell -Command "Expand-Archive -Path \"patch.aul_r43_ss_72.zip\" -DestinationPath \".\""
if not exist "patch.aul" goto :error_extract_patchaul
choice /c YN /m "PSDToolKit���C���X�g�[�����܂���"
if errorlevel 1 (
echo PSDToolkit���_�E�����[�h��..
curl -L https://github.com/oov/aviutl_psdtoolkit/releases/download/v0.2.0beta71/psdtoolkit_v0.2.0beta71.zip -o psdtoolkit_v0.2.0beta71.zip
if not exist psdtoolkit_v0.2.0beta71.zip goto :error_download_psdtoolkit
echo PSDToolkit��W�J��..
powershell -Command "Expand-Archive -Path \"psdtoolkit_v0.2.0beta71.zip\" -DestinationPath \".\" -Force"
if not exist PSDToolKit.auf goto :error_extract_psdtoolkit
) else (
echo PSDToolKit�̃C���X�g�[�����L�����Z�����܂����B
)
choice /c YN /m "�V���[�g�J�b�g���쐬���܂���"
if errorlevel 1 (
echo �V���[�g�J�b�g���쐬���Ă��܂�..
powershell -Command "$userfolder=$env:USERPROFILE;try{$wshell=New-Object -ComObject WScript.Shell;$shortcut_output_to=$userfolder + '\Desktop\Aviutl.lnk';$shortcut=$wshell.CreateShortcut($shortcut_output_to);$shortcut.TargetPath='C:\Aviutl\Aviutl.exe';$shortcut.WorkingDirectory='C:\Aviutl';$shortcut.Save();exit 0}catch{exit 1}"
echo �V���[�g�J�b�g���쐬���܂����B
) else (
echo �V���[�g�J�b�g�̍쐬���L�����Z�����܂����B
)
if not exist ".\script" (
mkdir script
)
echo Aviutl�̃C���X�g�[�����������܂����B
echo �ȉ����C���X�g�[������܂����B
echo 1. Aviutl�{��
echo 2. �g���ҏW�v���O�C��
echo 3. x264guiEx �o�̓v���O�C��
echo 4. patch.aul
if exist PSDToolKit.auf echo 5. PSDToolKit
echo Aviutl �� C:\Aviutl �ɃC���X�g�[������Ă��܂��B
echo �g�����́A Youtube�Ȃǂ��Q�Ƃ��Ă��������B
echo �܂��́Aggrks
goto :end
rem �G���[
:error_aviutl_download
echo Aviutl �̃_�E�����[�h���ɃG���[���������܂����B
goto :error
:error_aviutl_extract
echo Aviutl �̓W�J���ɃG���[���������܂����B
goto :error
:error_download_exedit
echo �g���ҏW�̃_�E�����[�h���ɃG���[���������܂����B
goto :error
:error_extract_exedit
echo �g���ҏW�̓W�J���ɃG���[���������܂����B
goto :error
:error_download_x264guiex
echo x264guiEx�̃_�E�����[�h���ɃG���[���������܂����B
goto :error
:error_extract_x264guiex
echo x264guiEx�̓W�J���ɃG���[���������܂����B
goto :error
:error_cp_x264guiex_reason_notfound
echo x264guiEx�̃R�s�[���ɃG���[���������܂����B
echo x264guiEx�̃t�@�C����������܂���B
goto :error
:error_cp_x264guiex_reason_disk_or_memory_space
echo x264guiEx�̃R�s�[���ɃG���[���������܂����B
echo �������܂��̓f�B�X�N���s�����Ă��܂��B
goto :error
:error_cp_x264guiex_reason_write_err
echo x264guiEx�̃R�s�[���ɃG���[���������܂����B
echo �s���ȃf�B�X�N�������݃G���[���������܂����B
goto :error
:error_download_patchaul
echo patch.aul �̃_�E�����[�h���ɃG���[���������܂����B
goto :error
:error_extract_patchaul
echo patch.aul �̓W�J���ɃG���[���������܂����B
goto :error
:error_download_psdtoolkit
echo PSDToolKit�̃_�E�����[�h���ɃG���[���������܂����B
goto :error
:error_extract_psdtoolkit
echo PSDToolKit�̓W�J���ɃG���[���������܂����B
goto :error
:error
echo Aviutl���C���X�g�[���ł��܂���ł����B
goto :end
:end
endlocal
pause
exit
) else (
echo �L�����Z�����܂����B
endlocal
pause
exit
)