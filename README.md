# BinaryHypervectors

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://smith-garrett.github.io/BinaryHypervectors.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://smith-garrett.github.io/BinaryHypervectors.jl/dev/)
[![Build Status](https://github.com/smith-garrett/BinaryHypervectors.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/smith-garrett/BinaryHypervectors.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/smith-garrett/BinaryHypervectors.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/smith-garrett/BinaryHypervectors.jl)
[![DOI](https://zenodo.org/badge/670530315.svg)](https://zenodo.org/badge/latestdoi/670530315)

This is a small Julia package for working with binary hypervectors in the context of hyperdimensional computing. Hyperdimensional computing is an approach to cognitive (neuro-) science and machine learning that uses very large vectors of random numbers to encode and retrieve information.

`BinaryHypervectors` is specialized for hyperdimensional computing with binary vectors. Binding (associating) vectors is done using bitwise XOR, bundling (combining) vectors is done using majority rule, and permuting is done using `circshift`. The implementation strives for efficiency and ease of use.

The package defines a simple type `BinaryHypervector` and the associated algebra: `*` or `bind()` for binding, `+` or `bundle()` for bundling, and `circshift()` for simple permutations. There is also a `sequence_encoding` function for creating correlated hypervectors.

For example, say we want to encode a sequence "A B" into a single hypervector. We first
create hypervectors for A and B:

```julia
julia> using BinaryHypervectors
julia> A = BinaryHypervector()  # Default size is 2^13
julia> B = BinaryHypervector()
```

We then create a sequence encoding, which is a list of two correlated hypervectors:

```julia
julia> seq = sequence_encoding(2)
```

Then, we bind A and B to the first and second sequence vectors, which marks them as being in
the relevant positions in the sequence:

```julia
julia> A1 = A * seq[1]
julia> B2 = B * seq[2]
```

And finally, we bundle the two sequence-encoded vectors to form a hyperdimensional
representation of the sequece:

```julia
julia> A1B2 = A1 + B2
```

We can retrieve, e.g., the second item in the sequence by multiplying by `seq[2]`, and then
taking the vector, A or B, that most closely matches `A1B2 * seq[2]`:

```julia
julia> extract = A1B2 * seq[2]
julia> map(x -> hammingsimilarity(extract, x), [A, B])
```

See, e.g., Kanerva (2009, *Cognitive Computing*) for more detailed background.

