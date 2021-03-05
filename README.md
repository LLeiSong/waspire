# waspire

Orchestrate WASP (Weighted Average Synthesis Processor) to create monthly syntheses of cloud-free reflectances for sentinel-2 or Venus Level-2A products distributed by the [Theia Land data centre](https://theia.cnes.fr/atdistrib/rocket/#/home).

For more details about WASP: [WASP github repo](https://github.com/CNES/WASP) and [cnes website](https://logiciels.cnes.fr/en/content/wasp).

## Installation

1. [Download WASP binary zifile](https://logiciels.cnes.fr/en/license/128/515), unzip and copy it into the root of this repository.

2. From the root of this repository in terminal, run
   ```bash
   docker build -t wasp .
   ```

## Usage

First, you need to download Level-2 products of your choice or prepare by yourself using MAJA. If you don't know how, have a look at [WASP github repo](https://github.com/CNES/WASP) and [maja_peps repo](https://github.com/olivierhagolle/maja_peps). Make sure they are unzipped. Then put them in a working directory(`/path/to/imagery`) e.g. `l2a_maja`. Then choose a centered date(`date`) and the half time interval for synthesis (`synthalf`. Then run:

```bash
docker run \
  -v /path/to/imagery:/mnt/input-dir:ro \
  -v /path/for/synthesis:/mnt/output-dir:rw \
  -it wasp date synthalf
```

Note that the folder mounted at `/mnt/input-dir` needs to contain all Level-2 imagery will be used for calculation. Results are written to the folder mounted on `/mnt/output-dir`.

## Acknowledgement

This package is part of project ["Combining Spatially-explicit Simulation of Animal Movement and Earth Observation to Reconcile Agriculture and Wildlife Conservation"](https://github.com/users/LLeiSong/projects/2).
This project is funded by NASA FINESST program (award number: 80NSSC20K1640).
