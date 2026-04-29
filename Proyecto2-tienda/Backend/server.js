const express = require('express');
const { Pool } = require('pg');
const cors = require('cors');
require('dotenv').config();

const app = express();
const port = 3000;

// Middleware
app.use(cors());
app.use(express.json());

// Configuración de la conexión a PostgreSQL
const pool = new Pool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  port: 5432,
});

// --- RUTAS DE LA API ---

// 1. Obtener todos los productos (con su categoría)
app.get('/api/productos', async (req, res) => {
  try {
    // Intenta una consulta que busque las columnas más comunes para evitar el error de "columna no existe"
    const result = await pool.query(`
      SELECT * FROM productos LIMIT 50
    `);
    res.json(result.rows);
  } catch (err) {
    console.error("Error detallado:", err.message);
    res.status(500).json({ 
      error: "Error en la consulta", 
      mensaje: err.message,
      ayuda: "Verifica si la columna se llama id_categoria o categoria_id"
    });
  }
});
// 2. Obtener categorías (para los filtros del front)
app.get('/api/categorias', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM categorias');
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Error al obtener categorías' });
  }
});

// 3. Crear un nuevo producto
app.post('/api/productos', async (req, res) => {
  const { nombre, descripcion, precio, stock, categoria_id, imagen_url } = req.body;
  try {
    const result = await pool.query(
      'INSERT INTO productos (nombre, descripcion, precio, stock, categoria_id, imagen_url) VALUES ($1, $2, $3, $4, $5, $6) RETURNING *',
      [nombre, descripcion, precio, stock, categoria_id, imagen_url]
    );
    res.status(201).json(result.rows[0]);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Error al crear producto' });
  }
});

// Ruta de prueba
app.get('/', (req, res) => {
  res.send('API de la Tienda UVG funcionando correctamente');
});

app.listen(port, () => {
  console.log(`Servidor corriendo en http://localhost:${port}`);
});