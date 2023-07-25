module BinaryHypervectors

import Base.bind
import Base.+

# Chunk manipulation take from/inspired by:
# https://discourse.julialang.org/t/optimization-how-to-make-sure-xor-is-performed-in-chunks/33947/33):


"""
    bind(x, y)

Bind two vectors using XOR. Applied efficiently by exploiting the chunk structure of BitVectors.
"""
function Base.bind(x::BitVector, y::BitVector)
    cx, cy = x.chunks, y.chunks
    res = BitVector(undef, length(x))
	for i in eachindex(cx, cy)
		res.chunks[i] = xor(cx[i], cy[i])
	end
	return res
end

Base.:*(x::BitVector, y::BitVector) = bind(x, y)

"""
    bundle(vecs...)

Bundle  vectors using majority rule.
"""
function bundle(vecs...) 
	cts = map(count, eachrow(cat(vecs...; dims=2)))
	return round.(Bool, cts ./ size(vecs, 1))
end

Base.:+(x::BitVector, y::BitVector) = bundle(x, y)

"""
    hammingsimilarity(x, y)

Compute 1 minus the normalized Hamming distance between the vectors x and y. Uses chunk structure of BitVectors for speed.
"""
function hammingsimilarity(x, y)
    cx, cy = x.chunks, y.chunks
	s = 0
	for i in eachindex(cx, cy)
		s += count_ones(xor(cx[i], cy[i]))
	end
	return 1 - length(x)^-1 * s
end

export bind
export bundle
export hammingsimilarity

end
