include("calcs.jl")

termo = length(ARGS) > 0 ? ARGS[1] : ""

minerio, m, mm, qm, np, te = processar_busca(termo)

if minerio === nothing
    println("NOT_FOUND")
else
    println("$m")
    println("$mm")
    println("$qm")
    println("$np")
    println("$te")
end

