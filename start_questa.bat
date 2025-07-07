@REM 關閉命令列顯示（讓輸出更乾淨
@echo off

@REM 設定變數 SCRIPT_DIR 為當前 .bat 檔案所在目錄的完整路徑
set SCRIPT_DIR=%~dp0

@REM 切換到腳本所在的目錄，/d 表示支援切換磁碟機
cd /d %SCRIPT_DIR%


@REM 輸入 UVM 測試名稱，並儲存到 TESTNAME 變數
set /p TESTNAME=ENTER UVM test name:
if "%TESTNAME%"=="" (
    echo Wrong test name
    pause
    exit /b 1
)

@REM 使用 Questasim 的 vlog 指令，根據 filelist.f 編譯 Verilog 檔案
vlog -f filelist.f
if errorlevel 1 (
    echo Compile failed
    pause
    exit /b 1
)

REM 動態產生 run.tcl
echo vsim -sv_lib "$env(UVM_HOME)/src/dpi/uvm_dpi" -voptargs="+acc" work.top_tb +UVM_NO_RELNOTES +UVM_TESTNAME=%TESTNAME% > run.tcl
echo add wave -position insertpoint sim:/top_tb/my_dut/* >> run.tcl
echo run -all >> run.tcl

REM 執行模擬
"C:\questasim64_10.6c\win64\vsim.exe" -do run.tcl

del /q wlft*
del /q *.vsft
del /q vsim.wlf
del /q transcript

exit



