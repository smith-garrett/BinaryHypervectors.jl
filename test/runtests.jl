using BinaryHypervectors
using Test

x = BitVector([1, 0, 0, 1])
y = BitVector([1, 1, 1, 0])
z = BitVector([0, 0, 1, 1])

@testset "Binding tests" begin
    @test all(bind(x, y) .== [0, 1, 1, 1])
    @test all(bind(y, x) .== [0, 1, 1, 1])
end

@testset "Bundling tests" begin
    @test all(bundle(x, y) .== [1, 0, 0, 0])
    @test all(bundle(y, x) .== [1, 0, 0, 0])
    @test all(bundle(x, y, z) .== [1, 0, 1, 1])
end

@testset "Similarity tests" begin
    for targ in [y, z]
        @test hammingsimilarity(x, targ) ≈ 1 - length(x)^-1 * sum(xor.(x, targ))
    end
end