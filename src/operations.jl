# Chunk manipulation take from/inspired by:
# https://discourse.julialang.org/t/optimization-how-to-make-sure-xor-is-performed-in-chunks/33947/33):

"""
    bind(x, y)

Bind two vectors using XOR. Applied efficiently by exploiting the chunk structure of BitVectors.
"""
function Base.bind(x::BinaryHypervector, y::BinaryHypervector)
    cx, cy = x.vec.chunks, y.vec.chunks
    res = BitVector(undef, length(x))
	for i in eachindex(cx, cy)
		res.chunks[i] = xor(cx[i], cy[i])
	end
	return BinaryHypervector(res)
end


"""
	Base.:*(x::BitVector, y::BitVector)	

Binds two bit vectors. Equivalent to `bind(x, y)`.
"""
Base.:*(x::BinaryHypervector, y::BinaryHypervector) = bind(x, y)


"""
    bundle(vecs...)

Bundle vectors using majority rule.
"""
function bundle(vecs...) 
	cts = map(count, eachrow(cat(getfield.(vecs, :vec)...; dims=2)))
	return BinaryHypervector(round.(Bool, cts ./ size(vecs, 1)))
end


"""
	Base.:+(x::BitVector, y::BitVector)	

Bundle two bit vectors. Equivalent to `bundle(x, y)`.
"""
Base.:+(x::BinaryHypervector, y::BinaryHypervector) = bundle(x, y)


"""
    Base.circshift(x::BinaryHypervector, n)

Permute the BinaryHypervector by performing the circular shift n bits to the right.
"""
Base.circshift(x::BinaryHypervector, n) = BinaryHypervector(circshift(x.vec, n))
