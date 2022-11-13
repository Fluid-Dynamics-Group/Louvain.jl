module Louvain

abstract type LouvainObjective end

struct Modularity <: LouvainObjective end
struct Potts <: LouvainObjective end
struct NegativeSym <: LouvainObjective end
struct NegativeAsym <: LouvainObjective end

function community_louvain(
    W::Matrix{T}, 
    gamma::T, 
    M0::Vector{T}, 
    mode::MODE
) where T <: AbstractFloat  where TY <: LouvainObjective
    n = size(W, 1)
    s = sum.(W)

    # TODO: how to load B0 into the data
    B0 = zeros(1)

    B = objective(mode, W, B0, gamma)

    # this is a vector containing the indicies in M0 of the first appearance
    # of a given value.
    Mb = findfirst.(isequal.(M0), [M0])

    B = (B + B')/2

    # non to module degree
    Hnm = zeros(n,n)

    # for each of the modules...
    for m in 1:maximum(Mb)
        # sum all the elements in the matrix that match the predicate
        # TODO: I am not 100% sure this is the correct matlab translation
        Hnm[:, m] = sum(B[:, Mb .== m])
    end

    # main for loop
    Q0 = -Inf
    Q = sum(B[M0 .== M0'])
    first_iter = true

    while Q - Q0 > 1e-10
        flag = true;
        while flag
            flag = false;
        end

    end

end

function objective(
    mode::MODE, 
    W::Matrix{T}, 
    B0::Matrix{U}, 
    gamma::V
) where T <: AbstractFloat MODE <: LouvainObjective
    exit("unimplemented objective")
end

function objective(
    mode::Modularity, 
    W::Matrix{T}, 
    B0::Matrix{U}, 
    gamma::V
) where T <: AbstractFloat
    return (W - (gamma * (sum(W,dims=1) * sun(W, dims=2))) / s)/s
end

end # module Louvain
