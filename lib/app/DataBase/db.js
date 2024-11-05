// db.js
const mysql = require('mysql2');

const db = mysql.createConnection({
    host: '127.0.0.1',
    user: 'root', // Altere conforme necessário
    password: '3221', // Altere conforme necessário
    database: 'controleusuario' // Altere conforme necessário
});

db.connect(err => {
    if (err) {
        console.error('Erro ao conectar ao banco de dados:', err);
        return;
    }
    console.log('Conectado ao banco de dados MySQL');
});

module.exports = db;
