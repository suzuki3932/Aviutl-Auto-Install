@echo off
@chcp 932 >nul
rem Aviutl インストーラー
rem Script by haz3mn
rem このスクリプトで発生した損害は保証しません。
rem このスクリプトはWindowsデフォルトのPowerShellが必要です。
rem このスクリプトの実行にはインターネット接続が必要です。(Wi-Fi、有線LANどちらでもOK)
rem Aviutlやプラグインなどの使い方はYoutubeなどを参照してください。
rem 現時点ではWindows 11 24H2で動作確認済みです。
setlocal
set ScriptVersion=1.0
title Aviutl インストーラー %ScriptVersion%
echo ---------------------------------------------------
echo Aviutl インストーラー %ScriptVersion%
echo by haz3mn
echo Aviutl は C:\Aviutl にインストールされます。
echo ---------------------------------------------------
timeout /t 2 >nul
rem Aviutlをインストールするか尋ねる
choice /c YN /m "Aviutlをインストールしますか"
if %errorlevel% == 1 (
rem インストール処理
rem 数. はステップ
rem curl や Invoke-WebRequest はダウンロード
rem Expand-Archive は展開
echo 1. ディレクトリを作成中..
if not exist "C:\Aviutl" mkdir C:\Aviutl
cd C:\Aviutl
echo 2. ダウンロード中..
curl -o aviutl110.zip https://spring-fragrance.mints.ne.jp/aviutl/aviutl110.zip
if not exist aviutl110.zip goto :error_aviutl_download
echo 3. 展開中..
powershell -Command "Expand-Archive -Path \"aviutl110.zip\" -DestinationPath \".\""
if not exist "aviutl.exe" goto :error_aviutl_extract
echo 4. 拡張編集をダウンロード中..
curl -o exedit92.zip https://spring-fragrance.mints.ne.jp/aviutl/exedit92.zip
if not exist "exedit92.zip" goto :error_download_exedit
echo 5. 拡張編集を展開中..
powershell -Command "Expand-Archive -Path \"exedit92.zip\" -DestinationPath '.'"
if not exist "exedit.auf" goto :error_extract_exedit
echo 6. x264guiEx をダウンロード中..
curl -L https://github.com/rigaya/x264guiEx/releases/download/3.31/x264guiEx_3.31v3.zip -o x264guiEx_3.31v3.zip
if not exist "x264guiEx_3.31v3.zip" goto :error_download_x264guiex
echo 7. x264guiEx を展開中..
powershell -Command "Expand-Archive -Path \"x264guiEx_3.31v3.zip\" -DestinationPath \".\""
if not exist "x264guiEx_3.31v3" goto :error_extract_x264guiex
echo 8. x264guiEx をコピー中..
xcopy ".\x264guiEx_3.31v3\*" "." /e /i /y /h
if errorlevel 5 goto :error_cp_x264guiex_reason_write_err
if errorlevel 4 goto :error_cp_x264guiex_reason_disk_or_memory_space
if errorlevel 1 goto :error_cp_x264guiex_reason_notfound
if errorlevel 0 echo x264guiExのコピーが完了しました。
echo 9. patch.aul をダウンロード中..
curl -L https://github.com/nazonoSAUNA/patch.aul/releases/download/r43_72/patch.aul_r43_ss_72.zip -o patch.aul_r43_ss_72.zip
if not exist "patch.aul_r43_ss_72.zip" goto :error_download_patchaul
echo 10. patch.aul を展開中..
powershell -Command "Expand-Archive -Path \"patch.aul_r43_ss_72.zip\" -DestinationPath \".\""
if not exist "patch.aul" goto :error_extract_patchaul
choice /c YN /m "PSDToolKitをインストールしますか"
if errorlevel 1 (
echo PSDToolkitをダウンロード中..
curl -L https://github.com/oov/aviutl_psdtoolkit/releases/download/v0.2.0beta71/psdtoolkit_v0.2.0beta71.zip -o psdtoolkit_v0.2.0beta71.zip
if not exist psdtoolkit_v0.2.0beta71.zip goto :error_download_psdtoolkit
echo PSDToolkitを展開中..
powershell -Command "Expand-Archive -Path \"psdtoolkit_v0.2.0beta71.zip\" -DestinationPath \".\" -Force"
if not exist PSDToolKit.auf goto :error_extract_psdtoolkit
) else (
echo PSDToolKitのインストールをキャンセルしました。
)
choice /c YN /m "ショートカットを作成しますか"
if errorlevel 1 (
echo ショートカットを作成しています..
powershell -Command "$userfolder=$env:USERPROFILE;try{$wshell=New-Object -ComObject WScript.Shell;$shortcut_output_to=$userfolder + '\Desktop\Aviutl.lnk';$shortcut=$wshell.CreateShortcut($shortcut_output_to);$shortcut.TargetPath='C:\Aviutl\Aviutl.exe';$shortcut.WorkingDirectory='C:\Aviutl';$shortcut.Save();exit 0}catch{exit 1}"
echo ショートカットを作成しました。
) else (
echo ショートカットの作成をキャンセルしました。
)
if not exist ".\script" (
mkdir script
)
echo Aviutlのインストールが完了しました。
echo 以下がインストールされました。
echo 1. Aviutl本体
echo 2. 拡張編集プラグイン
echo 3. x264guiEx 出力プラグイン
echo 4. patch.aul
if exist PSDToolKit.auf echo 5. PSDToolKit
echo Aviutl は C:\Aviutl にインストールされています。
echo 使い方は、 Youtubeなどを参照してください。
echo または、ggrks
goto :end
rem エラー
:error_aviutl_download
echo Aviutl のダウンロード中にエラーが発生しました。
goto :error
:error_aviutl_extract
echo Aviutl の展開中にエラーが発生しました。
goto :error
:error_download_exedit
echo 拡張編集のダウンロード中にエラーが発生しました。
goto :error
:error_extract_exedit
echo 拡張編集の展開中にエラーが発生しました。
goto :error
:error_download_x264guiex
echo x264guiExのダウンロード中にエラーが発生しました。
goto :error
:error_extract_x264guiex
echo x264guiExの展開中にエラーが発生しました。
goto :error
:error_cp_x264guiex_reason_notfound
echo x264guiExのコピー中にエラーが発生しました。
echo x264guiExのファイルが見つかりません。
goto :error
:error_cp_x264guiex_reason_disk_or_memory_space
echo x264guiExのコピー中にエラーが発生しました。
echo メモリまたはディスクが不足しています。
goto :error
:error_cp_x264guiex_reason_write_err
echo x264guiExのコピー中にエラーが発生しました。
echo 不明なディスク書き込みエラーが発生しました。
goto :error
:error_download_patchaul
echo patch.aul のダウンロード中にエラーが発生しました。
goto :error
:error_extract_patchaul
echo patch.aul の展開中にエラーが発生しました。
goto :error
:error_download_psdtoolkit
echo PSDToolKitのダウンロード中にエラーが発生しました。
goto :error
:error_extract_psdtoolkit
echo PSDToolKitの展開中にエラーが発生しました。
goto :error
:error
echo Aviutlをインストールできませんでした。
goto :end
:end
endlocal
pause
exit
) else (
echo キャンセルしました。
endlocal
pause
exit
)