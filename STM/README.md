# STM32-DEVCONTAINER
This is an Ubuntu 24.04 container with STM tooling installed, it provides the stm32cubeclt toolset and Segger Jlink tools.

Note that the ```stm32cubeclt``` command line tools package is behind an account login wall so cannot be directly downloaded by the Dockerfile. Manually download this from www.stm.com and unzip.  This contains the command line compiler tools, the cube programmer and other utilities needed to do builds from a third party IDE like vscode.

Place the extracted ```st-stm32cubeclt_xxxx.sh script``` in this folder before running the build.sh script.  At the time of writing this was:```st-stm32cubeclt_1.18.0_24403_20250225_1636_amd64.sh```

For newer versions,  you will need to make sure that references in the Dockerfile are updated accordingly.

Add to the project's .devcontainer.json file.  The example below ensures that a useful set of extensions are installed for STM32 development.

```json

{
    "name": "STM32 Development", 
    "image": "stm32-dev-base:latest",
    "shutdownAction": "stopContainer",
    "customizations": {
        "vscode": {
            "extensions": [
                "ms-vscode.cpptools",
                "ms-vscode.cmake-tools",                 
                "ms-vscode.vscode-embedded-tools",
                "ms-vscode.hexeditor",
                "mcu-debug.debug-tracker-vscode",
                "mcu-debug.memory-view",
                "mcu-debug.peripheral-viewer",
                "mcu-debug.rtos-views",
                "marus25.cortex-debug",                
                "dan-c-underwood.arm"                
            ]
        }
    },
    "mounts": [
        "source=/dev,target=/dev,type=bind"
    ],
    "runArgs": ["--privileged"],
    "postCreateCommand": "git config --global --add safe.directory /workspace"
}

```
