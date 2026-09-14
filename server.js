const express = require('express');
const { execFile } = require('child_process');
const { minerais } = require('./dados.js');

const app = express();

app.set('view engine', 'pug');
app.set('views', __dirname);
app.use(express.static(__dirname));

app.get('/', (req, res) => {
    const paginaAtiva = req.query.pagina || 'home';
    res.render('index', { minerais, termoDigitado: '', paginaAtiva, m: 0, mm: 0, qm: 0, np: 0, te: 0 });
});

app.get('/buscar', (req, res) => {
    const termoDigitado = req.query.termo || '';
    const paginaAtiva = req.query.pagina || 'home';

    execFile('/home/joao/.juliaup/bin/julia', ['calcular.jl', termoDigitado], { cwd: __dirname }, (err, stdout, stderr) => {
        let m = 0, mm = 0, qm = 0, np = 0, te = 0;

        if (!err && stdout.trim() !== 'NOT_FOUND' && stdout.trim() !== '') {
            const linhas = stdout.trim().split('\n');
            if (linhas.length >= 5) {
                m  = parseFloat(linhas[0]);
                mm = parseFloat(linhas[1]);
                qm = parseFloat(linhas[2]);
                np = parseFloat(linhas[3]);
                te = parseFloat(linhas[4]);
            }
        }

        res.render('index', { minerais, termoDigitado, paginaAtiva, m, mm, qm, np, te });
    });
});

app.listen(3000, () => {
    console.log('Servidor rodando em http://localhost:3000');
});