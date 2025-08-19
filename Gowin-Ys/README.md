# Gowin Yosys toolchain

- Ubuntu 24.04 LTS core.
- Apicula (Chipdb)
- Yosys (synthesis)
- Nextpnr-himbaechel (place and route, no gui)
- OpenFPGALoader
- iVerilog, GtkWave (simulation)
- SVLS

Execute build.sh to build the container.  

### Notes

The nexpnr-himbaechel tool does not support the floor planner GUI so built without GUI support.

The yosys toolchain for Gowin FPGAs is still maturing and there are some areas where it performs significantly less well than the native Gowin EDA tooling.