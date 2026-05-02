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
  host: process.env.DB_HOST || 'db', 
  user: process.env.DB_USER || 'proy2',
  password: process.env.DB_PASSWORD || 'secret',
  database: process.env.DB_NAME || 'tienda_db',
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
    const { nombre, descripcion, precio_unitario, stock, id_categoria, id_proveedor } = req.body;
    
    try {
        const sql = `
            INSERT INTO productos (nombre, descripcion, precio_unitario, stock, id_categoria, id_proveedor)
            VALUES ($1, $2, $3, $4, $5, $6)
            RETURNING *`;
        
        const values = [nombre, descripcion, precio_unitario, stock, id_categoria, id_proveedor];
        const result = await pool.query(sql, values);
        
        res.status(201).json({ success: true, producto: result.rows[0] });
    } catch (error) {
        console.error("Error al insertar producto:", error.message);
        res.status(500).json({ error: error.message });
    }
});
// 4. Procesar pago y actualizar stock
app.post('/api/pagar', async (req, res) => {
    const { productos } = req.body;
    
    try {
        await pool.query('BEGIN');

        for (const item of productos) {
            const id = item.id_producto; 
       
            const sql = 'UPDATE productos SET stock = stock - 1 WHERE id_producto = $1 AND stock > 0';
            
            const result = await pool.query(sql, [id]);

            if (result.rowCount === 0) {
                throw new Error(`Producto ${item.nombre} sin stock o ID incorrecto`);
            }
        }

        await pool.query('COMMIT');
        res.json({ success: true });
    } catch (error) {
        await pool.query('ROLLBACK');
        console.error("DETALLE DEL ERROR EN POSTGRES:", error.message);
        res.status(500).json({ error: error.message });
    }
});

// Ruta para el reporte con JOIN y VIEW
app.get('/api/reporte-inventario', async (req, res) => {
    try {
        const query = 'SELECT * FROM vista_inventario_completo ORDER BY stock ASC';
        const result = await pool.query(query);
        res.json(result.rows);
    } catch (error) {
        console.error("Error en la VIEW:", error.message);
        res.status(500).json([]); 
    }
});
// Ruta de prueba
app.get('/', (req, res) => {
  res.send('API de la Tienda UVG funcionando correctamente');
});

app.listen(port, () => {
  console.log(`Servidor corriendo en http://localhost:${port}`);
});