# Option Pricing in kdb+/q

This repository contains q scripts which can be used to generates Asian and European option prices using Black Scholes, Monte Carlo and Quasi-Monte Carlo methods. The methods demonstrated follow the work presented in the paper [S. Kucherenko et. al 2007](http://www.broda.co.uk/gsa/wilmott_GSA_SK.pdf). The scripts also include wrappers for the C++ pseudo-random and Sobol sequence number generators, along with the functions required to produce both cumulative and inverse cumulative normal distributions.

## Requirements

- [JupyterQ](https://github.com/KxSystems/jupyterq) - this produces a tree dependency for kdb+, Python and embedPy
- Sobol C++ library - `SobolSeq1024` function provided within the library, with max dimension of 1024.
- [matplotlib](https://matplotlib.org/)

**Note**: Before running any of the code, make sure that `$QHOME` is defined.

## Installation

To create the shared object files for the number generators and distribution functions the below must be run within the `code/c` directory:

__Linux__:

```
make
make install
make clean
```

__Windows__:

```
call build.bat
```

Note that `build.bat` runs with Visual Studio 2017. To run with other versions, please modify file accordingly.

## Loading

Examples of option pricing using all of the techniques provided in the library can be run using the jupyter notebook provided or by running the below script:

```q
q)\l op.q
q)loadfile`:init.q
q)loadfile`:code/q/run.q
```

Note that `run.q` can be multi-threaded.
