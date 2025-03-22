@echo off
setlocal enabledelayedexpansion

:: 変換元フォルダ
set input_folder=before
if not exist "!input_folder!" mkdir "!input_folder!"

:: 出力先フォルダ
set output_folder=after
if not exist "!output_folder!" mkdir "!output_folder!"

:: 出力ファイル
set fps=60

:: .webmファイルをすべてmp4へ変換
for /r "%input_folder%" %%f in (*.webm) do (
    set input_file=%%f
    set filename=%%~nf
    set output_file=!output_folder!\!filename!.mp4
    ffmpeg -hwaccel cuda -i "!input_file!" -r "!fps!" -c:v h264_nvenc -preset slow -b:v 5M -c:a aac -b:a 192k "!output_file!"
)

echo Conversion complete!
pause