module BinaryHypervectors

using Random
using StatsBase: sample


export BinaryHypervector
export bind
export bundle
export hammingsimilarity
export sequence_encoding


struct BinaryHypervector <: AbstractVector{Bool}
    vec::BitVector
    dim::Int
    BinaryHypervector(v=bitrand(2^13), d=2^13) = new(v, d)
end


"""
	BinaryHypervector(x::BitVector)

Create a BinaryHypervector by rounding an AbstractVector elementwise to 0 or >= 0.5.
"""
function BinaryHypervector(x::T) where {T<:AbstractVector}
    BinaryHypervector(x .>= 0.5, length(x))
end


"""
	BinaryHypervector(ndim::Int)

Create a random binary hypervector with ndim dimensions.
"""
BinaryHypervector(ndim::Int) = BinaryHypervector(bitrand(ndim), ndim)


# Required/useful methods for subtypes of AbstractArray
Base.length(x::BinaryHypervector) = x.dim
Base.size(x::BinaryHypervector) = (x.dim,)
Base.getindex(x::BinaryHypervector, i::Int) = 1 <= i <= x.dim ? x.vec[i] : throw(BoundsError(x, i))
Base.getindex(x::BinaryHypervector, I) = BinaryHypervector([x.vec[i] for i in I])
Base.show(io::IO, ::MIME"text/plain", x::BinaryHypervector) = print(io, "$(x.dim)-dimensional BinaryHypervector:\n   ", x.vec)


include("operations.jl")
include("utils.jl")

end
