import express from 'express';
import path from 'path';
import fs from 'fs';

const __dirname = path.dirname(new URL(import.meta.url).pathname);

const app = express();
const port = process.env.PORT || 8080;

// Middleware para aplicar las reglas de reescritura de URL
app.use((req, res, next) => {
    const htaccessPath = path.join(__dirname, 'dist', '.htaccess');
    if (fs.existsSync(htaccessPath)) {
        // Lee el archivo .htaccess
        const htaccessContent = fs.readFileSync(htaccessPath, 'utf-8');
        // Aplica las reglas de reescritura
        eval(htaccessContent);
    }
    next();
});

// Middleware para servir archivos estáticos
const staticPath = path.resolve('dist');
app.use(express.static(staticPath));

// Middleware para manejar las rutas de Vue
app.use((req, res, next) => {
    const indexFilePath = path.join(staticPath, 'index.html');
    console.log(indexFilePath)
    fs.readFile(indexFilePath, 'utf-8', (err, data) => {
        if (err) {
            console.error('Error al leer el archivo index.html:', err);
            return res.status(500).send('Error interno del servidor');
        }
        res.send(data);
    });
});

// Inicia el servidor
app.listen(port, () => {
    console.log(`Servidor en ejecución en el puerto ${port}`);
});
