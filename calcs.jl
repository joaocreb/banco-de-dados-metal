include("dados.jl")

struct Mineral
    nome::String
    dureza_mohs::Int
    densidade::Int
    volume::Int
    quantidade_atomos::Int
    massa_atomica::Float64
end

minerais = [Mineral(
    m.nome,
    m.dureza_mohs,
    m.densidade,
    m.volume,
    m.quantidade_atomos,
    Float64(m.massa_atomica)
) for m in minerais_julia]

function massa(p::Int, v::Int)
    return p * v
end

function massa_molar(ma)
    return ma
end

function quantidade_materia(m, M)
    return m / M
end

function teor_elemento(M, ma, qa)
    return ((qa * ma) / M) * 100
end

function numero_particulas(qm, NA)
    return qm * NA
end

function processar_busca(termo_busca::String)
    termo_limpo = lowercase(strip(termo_busca))
    if isempty(termo_limpo)
        return nothing, 0, 0, 0, 0, 0
    end
    
    resultado = filter(item -> lowercase(item.nome) == termo_limpo, minerais)
    
    if isempty(resultado)
        return nothing, 0, 0, 0, 0, 0
    end
    
    min_selecionado = resultado[1]
    
    p = min_selecionado.densidade
    v = min_selecionado.volume
    qa = min_selecionado.quantidade_atomos
    ma = min_selecionado.massa_atomica
    
    m = massa(p, v)
    M = massa_molar(ma)
    q_mat = quantidade_materia(m, M)
    Na = 6.022e23
    particulas = numero_particulas(q_mat, Na)
    te = teor_elemento(M, ma, qa)
    
    return min_selecionado, m, M, q_mat, particulas, te
end