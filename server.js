const express = require("express");
const fs = require("fs");
const path = require("path");

const app = express();
const PORT = 3000;

// Diretório dos scripts
const scriptsDir = path.join(__dirname, "Scripts");

// Servindo arquivos estáticos da pasta 'public' (como index.html, css, js)
app.use(express.static(path.join(__dirname, 'public')));

// Servindo arquivos do diretório 'Scripts' diretamente como arquivos estáticos
app.use('/Scripts', express.static(path.join(__dirname, 'Scripts')));

// Rota para a página inicial (index.html)
app.get("/", (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

// Rota para listar os scripts no diretório 'Scripts'
app.get("/scripts", (req, res) => {
    fs.readdir(scriptsDir, (err, files) => {
        if (err) {
            return res.status(500).send("Erro ao listar os scripts");
        }

        // Filtra apenas arquivos .lua
        const luaFiles = files.filter(file => file.endsWith(".lua"));
        res.json(luaFiles);
    });
});

// Rota para obter o conteúdo de um script específico
app.get("/scripts/:name", (req, res) => {
    const scriptName = req.params.name;
    const scriptPath = path.join(scriptsDir, scriptName);

    // Verifica se o arquivo existe
    if (!fs.existsSync(scriptPath)) {
        return res.status(404).send("Script não encontrado");
    }

    // Lê o conteúdo do arquivo e envia como resposta
    const content = fs.readFileSync(scriptPath, "utf-8");
    res.type("text/plain").send(content);
});

// Inicia o servidor na porta definida
app.listen(PORT, () => {
    console.log(`Servidor rodando em http://localhost:${PORT}`);
});
