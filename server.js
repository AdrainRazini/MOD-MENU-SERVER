const express = require("express");
const fs = require("fs");
const path = require("path");

const app = express();
const PORT = 3000;

// Diretório dos scripts
const scriptsDir = path.join(__dirname, "Scripts");

// Servindo arquivos estáticos (como o index.html)
app.use(express.static(path.join(__dirname, 'public')));

// Rota para a página inicial
app.get("/", (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

// Rota para listar os scripts
app.get("/scripts", (req, res) => {
    fs.readdir(scriptsDir, (err, files) => {
        if (err) {
            return res.status(500).send("Erro ao listar os scripts");
        }

        const luaFiles = files.filter(file => file.endsWith(".lua"));
        res.json(luaFiles);
    });
});

// Rota para obter o conteúdo de um script
app.get("/scripts/:name", (req, res) => {
    const scriptName = req.params.name;
    const scriptPath = path.join(scriptsDir, scriptName);

    if (!fs.existsSync(scriptPath)) {
        return res.status(404).send("Script não encontrado");
    }

    const content = fs.readFileSync(scriptPath, "utf-8");
    res.type("text/plain").send(content);
});

app.listen(PORT, () => {
    console.log(`Servidor rodando em http://localhost:${PORT}`);
});
