using BinaryHypervectors
using Test

x = BinaryHypervector([1, 0, 0, 1])
y = BinaryHypervector([1, 1, 1, 0])
z = BinaryHypervector([0, 0, 1, 1])

@testset "Binding tests" begin
    @test all(bind(x, y) .== [0, 1, 1, 1])
    @test all(x * y .== [0, 1, 1, 1])
    @test all(bind(y, x) .== [0, 1, 1, 1])
    @test all(y * x .== [0, 1, 1, 1])
end

@testset "Bundling tests" begin
    @test all(bundle(x, y) .== [1, 0, 0, 0])
    @test all(x + y .== [1, 0, 0, 0])
    @test all(bundle(y, x) .== [1, 0, 0, 0])
    @test all(y + x .== [1, 0, 0, 0])
    @test all(bundle(x, y, z) .== [1, 0, 1, 1])
end

@testset "Similarity tests" begin
    for targ in [y, z]
        @test hammingsimilarity(x, targ) ≈ 1 - length(x)^-1 * sum(xor.(x, targ))
    end
end

@testset "Basic operations" begin
    @test all(x * x .== zeros(size(x)))
    @test hammingsimilarity(x, y) < hammingsimilarity(x, x)
    @test hammingsimilarity(x, x * y) < hammingsimilarity(x, x + y)
end

@testset "Sequence encodings" begin
    lens = [5, 10, 20, 50]
    for seqlen in lens
        seq = sequence_encoding(seqlen)
        overlaps = [round(hammingsimilarity(seq[1], seq[i]), digits=1) for i in 1:seqlen]
        #println(overlaps)
        @test all([overlaps[i] >= overlaps[i+1] for i in 1:(seqlen-1)])
    end
end
