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

Bundle vectors using majority rule. Ties broken deterministically using the rule from Hannagan et al. (2011, CogSci).
"""
function bundle(vecs...)
	nvecs = size(vecs, 1)
	ndim = length(vecs[1])
	cts = map(count, eachrow(cat(getfield.(vecs, :vec)...; dims=2)))
	avgs = cts ./ nvecs
	ties = findall(avgs .== 0.5)
	tiesp1modn = mod.(ties .+ 1, ndim)
	tiesp1modn[tiesp1modn .== 0] .= ndim
	avgs[ties] = xor.(vecs[1].vec[tiesp1modn], vecs[end].vec[tiesp1modn])# ./ size(vecs, 1)
	#avgs[ties] .= rand(length(ties))  # random tie breaking
	#return BinaryHypervector(round.(Bool, cts ./ size(vecs, 1)))  # no tie breaking
	return BinaryHypervector(round.(Bool, avgs))
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
Base.circshift(x::BinaryHypervector, n::Int=1) = BinaryHypervector(circshift(x.vec, n))
