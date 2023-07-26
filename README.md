# BinaryHypervectors

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://smith-garrett.github.io/BinaryHypervectors.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://smith-garrett.github.io/BinaryHypervectors.jl/dev/)
[![Build Status](https://github.com/smith-garrett/BinaryHypervectors.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/smith-garrett/BinaryHypervectors.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/smith-garrett/BinaryHypervectors.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/smith-garrett/BinaryHypervectors.jl)

This is a small Julia package for working with binary hypervectors in the context of hyperdimensional computing. Hyperdimensional computing is an approach to cognitive (neuro-) science and machine learning that uses very large vectors of random numbers to encode and retrieve information.

`BinaryHypervectors` is specialized for hyperdimensional computing with binary vectors. Binding (associating) vectors is done using bitwise XOR, bundling (combining) vectors is done using majority rule, and permuting is done using `circshift`.

Introduces a simple type `BinaryHypervector` and the associated algebra: `*` or `bind()` for binding, `+` or `bundle()` for bundling, and `circshift()` for simple permutations.
