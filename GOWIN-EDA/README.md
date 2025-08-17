This container is for FPGA development using the Tang Nano 9K and 20K boards.  It installs the Gowin EDA tooling and supporting libraries, this is quite a large image because Gowin uses QT5 even for their command line tools.

The openFPGALoader is built and installed.

Various other utilities including the svls (SystemVerilog language server) are installed for use by VSCode extensions.

I've not tried to trim the image down at all as I'm not short on space.

The Gowin installation image (a gzipped tarball) must be downloaded from Gowin and placed in the same folder as the Dockerfile.  It cannot be pulled directly by the build as it is located behind a login screen.

