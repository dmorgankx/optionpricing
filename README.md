# Sobol Option Pricing

This repository contains kdb+/q code, translated from C++, which generates prices for Asian and European call options using both Black Scholes and Monte Carlo methods. In addition, q code has been used to wrap the C++ functions required within the Monte Carlo method, to generate both random and sobol sequences, and normal distributions.

A jupyter notebook has been provided to demonstate these methods in conjunction with the C++ Sobol sequence library (_SobolSeq16384_).

## Requirements

- [JupyterQ](https://github.com/KxSystems/jupyterq) - this produces a tree dependency for kdb+, Python and embedPy
- SobolSeq16384 (available at [broda.co.uk](http://www.broda.co.uk/SobolSeq/SobolOptionPricing.ZIP))
- matplotlib