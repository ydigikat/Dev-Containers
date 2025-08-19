# STM32 (Cortex series) toolchain

- STM32CubeClt (STM command line tools)
- Jlink support

Execute build.sh to build the container.  

### Notes

The STM32CubeClt (command line tooling) is behind a login page so cannot be downloaded directly by the container during the build. Download the file manually and place it in the same folder as the Dockerfile.  At the time of writing this was ```st-stm32cubeclt_1.18.0_24403_20250225_1636_amd64.sh.zip```.  If you use a later version you will need to modify the filename at the top of the Dockerfile ```ARG CUBE_CLT=st-stm32cubeclt_1.18.0_24403_20250225_1636_amd64```.