if "%target_platform%"=="win-arm64" set "CRC32C_CMAKE_ARGS=-DCMAKE_POLICY_VERSION_MINIMUM=3.5"
mkdir build-shared
if errorlevel 1 exit 1
cd build-shared
if errorlevel 1 exit 1

:: Configure and install based on other `bld.bat`s and
::https://github.com/google/crc32c/blob/master/.appveyor.yml
cmake -G "Ninja" %CRC32C_CMAKE_ARGS% ^
         -DBUILD_TESTING=OFF ^
         -DBUILD_SHARED_LIBS=ON ^
         -DCMAKE_BUILD_TYPE=Release ^
         -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
         -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
         -DCRC32C_BUILD_TESTS=OFF ^
         -DCRC32C_BUILD_BENCHMARKS=OFF ^
         -DCRC32C_USE_GLOG=0 ^
         -DCMAKE_WINDOWS_EXPORT_ALL_SYMBOLS=ON ^
         ..
if errorlevel 1 exit 1
cmake --build . --target install --config Release
if errorlevel 1 exit 1
