# Sobol Option Pricing

This repository contains q code, translated from C++, which generates prices for Asian and European call options using both Black Scholes and Monte Carlo methods. In addition, q code has been used to wrap the C++ functions required within the Monte Carlo method to generate both random and sobol sequences, and normal distributions.

To run the simulations for pricing Asian and European call options using all available techniques, a script, `run.q`, and a jupyter notebook have been provided.

## Requirements

- [JupyterQ](https://github.com/KxSystems/jupyterq) - this produces a tree dependency for kdb+, Python and embedPy
- SobolSeq16384 (available at [broda.co.uk](http://www.broda.co.uk/SobolSeq/SobolOptionPricing.ZIP))
- matplotlib

**Note**: Before running any of the code, make sure that `$QHOME` is defined. Then run:

```
make
make install
make clean
```
       
within the `code/c` directory.