using Genie
using Genie.Renderer.Html
using Genie.Renderer.Json
include("calcs.jl")

route("/") do
    html(:index, termoDigitado="", minerioEncontrado=nothing, minerais=minerais, m=0, mm=0, qm=0, np=0, te=0)
end

route("/buscar") do
    termo = @params(:termo, "")
    
    # Executa a busca e os cálculos no calcs.jl
    minerio_encontrado, m, mm, qm, np, te = processar_busca(termo)
    
    # Envia o minério já encontrado e os valores calculados para o Pug
    html(:index, 
        termoDigitado = termo, 
        minerioEncontrado = minerio_encontrado, 
        minerais = minerais, 
        m = m, 
        mm = mm, 
        qm = qm, 
        np = np, 
        te = te
    )
end

up(8080, async=false)