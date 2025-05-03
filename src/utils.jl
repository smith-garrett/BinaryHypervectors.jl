"""
    hammingsimilarity(x, y)

Compute 1 minus the normalized Hamming distance between the vectors x and y. Uses chunk structure of BitVectors for speed.
"""
function hammingsimilarity(x, y)
    cx, cy = x.vec.chunks, y.vec.chunks
    s = 0
    for i in eachindex(cx, cy)
        s += count_ones(xor(cx[i], cy[i]))
    end
    return 1 - length(x)^-1 * s
end


# Implementation inspired by https://michielstock.github.io/posts/2022/2022-10-04-HDVtutorial/
"""
    sequence_encoding(seqlen, ndim=2^13)

Create correlated sequence encodings with seqlen elements. Each BinaryHypervector in the returned list is correlated with its immediate neighbors, but the correlation drops with distance.
"""
function sequence_encoding(seqlen, ndim=2^13)
    vecs = [BinaryHypervector(ndim) for _ in 1:seqlen]
    for i in 2:seqlen
        for j in 1:ndim
            vecs[i].vec[j] = rand() < 1 / seqlen ? ~vecs[i-1].vec[j] : vecs[i-1].vec[j]
        end
    end
    return vecs
end
