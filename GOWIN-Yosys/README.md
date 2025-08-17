# FPGA Development Environment

A Docker-based development environment for FPGA development using the open-source Yosys toolchain, specifically configured for Gowin FPGAs with VSCode development container support.

## Components

### Dockerfile

Builds an Ubuntu 24.04 based development image containing:

**Synthesis & Place-and-Route:**
- **Yosys** - Open-source synthesis framework
- **nextpnr** - Place and route tool with Gowin support via himbaechel architecture
- **Apycula** - Gowin chipdb and packer utilities

**Simulation Tools:**
- **Icarus Verilog** - Verilog simulator
- **GTKWave** - Waveform viewer
- **Verilator** - High-performance Verilog simulator

**Programming & Debug:**
- **openFPGALoader** - Universal FPGA programmer
- **FTDI udev rules** - USB device permissions for FTDI-based programmers

**Development Support:**
- **SystemVerilog Language Server** (svls) - HDL language support
- Standard build tools and dependencies

### devcontainer.json

VSCode development container configuration providing:

**Extensions:**
- Verilog HDL syntax highlighting and support
- SystemVerilog Language Server integration
- Better Comments and Bookmarks for code organization

**Hardware Access:**
- Device mounting (`/dev` bind mount)
- Privileged container mode for direct hardware programming
- Automatic permission handling for the vscode user

## Usage

### Building the Image

```bash
./build.sh
```

Creates `gowin-yosys-dev-base:latest` Docker image.

### VSCode Development

1. Open the project folder in VSCode
2. When prompted, select "Reopen in Container" or use Command Palette: "Dev Containers: Reopen in Container"
3. VSCode will build the container and provide a fully configured FPGA development environment

### Hardware Programming

The container is configured with privileged access and device mounting to support direct FPGA programming via USB-connected programmers. FTDI-based programmers (common with Gowin development boards) are specifically supported through udev rules.

## Target Devices

Primarily configured for **Gowin FPGAs** (9K, 20K series) but the Yosys toolchain supports additional architectures. The nextpnr build specifically targets Gowin devices via the himbaechel architecture.

## File Structure

```
├── Dockerfile          # Container image definition
├── devcontainer.json   # VSCode dev container configuration  
├── build.sh           # Image build script
└── README.md          # This documentation
```

## Example devcontainer.json
```json
{
    "name": "Tang Development", 
    "image": "gowin-yosys-dev-base:latest",
    "remoteUser": "vscode",
    "updateRemoteUserUID": true,
    "postStartCommand": "sudo chown -R vscode:vscode /workspaces || true",
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
    "runArgs": ["--privileged"]    
}
```