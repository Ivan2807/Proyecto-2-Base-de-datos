const contenedor = document.getElementById('contenedor-productos');

async function cargarProductos() {
    try {
        // Llamada a tu API de Node.js
        const respuesta = await fetch('http://localhost:3000/api/productos');
        const productos = await respuesta.json();

        // Limpiar el mensaje de "Cargando..."
        contenedor.innerHTML = '';

        if (productos.length === 0) {
            contenedor.innerHTML = '<p class="text-center w-100">No hay productos disponibles.</p>';
            return;
        }

        // Crear una tarjeta por cada producto
        productos.forEach(producto => {
            const card = document.createElement('div');
            card.className = 'col';
            card.innerHTML = `
                <div class="card h-100 shadow-sm">
                    <img src="${producto.imagen_url || 'https://via.placeholder.com/150'}" class="card-img-top" alt="${producto.nombre}" style="height: 200px; object-fit: cover;">
                    <div class="card-body">
                        <h5 class="card-title">${producto.nombre}</h5>
                        <p class="card-text text-muted">${producto.descripcion}</p>
                        <div class="d-flex justify-content-between align-items-center">
                            <span class="fw-bold fs-5 text-success">Q${producto.precio}</span>
                            <span class="badge bg-info text-dark">Stock: ${producto.stock}</span>
                        </div>
                    </div>
                    <div class="card-footer bg-white border-top-0">
                        <button class="btn btn-primary w-100">Agregar al carrito</button>
                    </div>
                </div>
            `;
            contenedor.appendChild(card);
        });

    } catch (error) {
        console.error('Error al cargar productos:', error);
        contenedor.innerHTML = '<div class="alert alert-danger w-100">Error al conectar con la API</div>';
    }
}

// Ejecutar la función al cargar la página
cargarProductos();