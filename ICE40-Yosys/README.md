# STM32-DEVCONTAINER
This is an Ubuntu 24.04 container with Yosys open source FPGA tooling.

The image takes some time to build as it pulls and builds the required tools:

1. IceStorm
2. Yosys
3. Nextpnr
4. iverilog

It also loads ```svls``` to support the ```dalance svls extension``` and ```Verible``` for linting.

It adds the udev/rules.d/53-lattice-ftdi.rules and includes the usb utilities (lsusb)

### Example devcontainer.json

```json
{
    "name": "ICE40 Development", 
    "build": {
        "dockerfile": "Dockerfile",
        "context": "."
    },
    "shutdownAction": "stopContainer",
    "customizations": {
        "vscode": {
            "extensions": [   
                "mshr-h.VerilogHDL",
                "dalance.svls-vscode",
                "aaron-bond.better-comments",
                "alefragnani.Bookmarks"                
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
