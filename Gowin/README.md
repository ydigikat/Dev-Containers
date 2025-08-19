# Gowin EDA toolchain

- Ubuntu 22.04 LTS core.
- Gowin IDE/CLI tools.
- OpenFPGALoader
- Modelsim
- SVLS

Execute build.sh to build the container.  

### Notes

The Gowin install image is behind a login screen so cannot be retrieved directly by the container build process.  Download the required file (at the time of writing ```Gowin_V1.9.11.03_Education_Linux.tar.gz```) and place in the same folder as the Dockerfile before running build.

This container downloads ModelSim from Intel which is a 1.7GB download, the install process can take some time.



