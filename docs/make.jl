using BinaryHypervectors
using Documenter

DocMeta.setdocmeta!(BinaryHypervectors, :DocTestSetup, :(using BinaryHypervectors); recursive=true)

makedocs(;
    modules=[BinaryHypervectors],
    authors="Garrett Smith <gasmith@uni-potsdam.de> and contributors",
    repo="https://github.com/smith-garrett/BinaryHypervectors.jl/blob/{commit}{path}#{line}",
    sitename="BinaryHypervectors.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://smith-garrett.github.io/BinaryHypervectors.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/smith-garrett/BinaryHypervectors.jl",
    devbranch="main",
)
