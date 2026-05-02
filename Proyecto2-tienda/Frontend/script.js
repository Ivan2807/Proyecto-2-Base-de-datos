
let carrito = [];
let productosData = [];

// 1. NAVEGACIÓN GLOBAL
window.mostrarSeccion = function(seccion) {
    const secciones = ['seccion-tienda', 'seccion-carrito', 'seccion-admin','seccion-reporte'];
secciones.forEach(s => {
        const el = document.getElementById(s);
        if (el) el.style.display = (s === `seccion-${seccion}`) ? 'block' : 'none';
    });

    if (seccion === 'reporte') {
        cargarReporte();
    }
    
    if (seccion === 'admin') cargarMonitorDB();
};

// 2. CARGAR PRODUCTOS
async function cargarProductos() {
    try {
        const res = await fetch('http://localhost:3000/api/productos');
        productosData = await res.json();
        const contenedor = document.getElementById('contenedor-productos');
        if(!contenedor) return;

        contenedor.innerHTML = '';
        productosData.forEach(p => {
            const card = document.createElement('div');
            card.className = 'col';
   const idReal = p.id_producto || p.id_producto || p.ID || p.producto_id;

card.innerHTML = `
    <div class="card h-100 shadow-sm border-primary">
        <div class="card-body">
            <h5 class="card-title">${p.nombre}</h5>
            <p class="card-text small text-muted">${p.descripcion}</p>
            <p class="fw-bold text-primary">Q${p.precio}</p>
<button class="btn btn-primary btn-sm btn-agregar" data-id="${idReal}">
    Agregar al Carrito
</button>
        </div>
    </div>`;
            contenedor.appendChild(card);
        });
    } catch (e) { 
        console.error("Error al conectar con el Backend:", e);
    }
}

// 3. EVENTO DE CLIC BLINDADO (Usa .closest para evitar el 'undefined')
document.addEventListener('click', (e) => {
    const boton = e.target.closest('.btn-agregar');
    
    if (boton) {
        const idCapturado = boton.getAttribute('data-id');
        
        // BUSCADOR INTELIGENTE: 
        // Busca en 'id', 'id_producto', 'ID', o el primer valor del objeto
        const producto = productosData.find(p => {
            return (p.id == idCapturado || 
                    p.id_producto == idCapturado || 
                    p.ID == idCapturado ||
                    Object.values(p)[0] == idCapturado); // Prueba con el primer valor si nada funciona
        });

        if (producto) {
            carrito.push(producto);
            console.log(`%c se agrego ${producto.nombre}`);
            actualizarInterfazCarrito();
        } else {
            console.error("No se encontró el ID:", idCapturado);
            // ESTO ES CLAVE: Mira la tabla en la consola para ver el nombre real de la columna
            console.log("Estructura real de tus datos:");
            console.table(productosData[0]); 
        }
    }
});

// 4. ACTUALIZAR CARRITO (INTERFAZ)
window.quitarDelCarrito = function(index) {
    const eliminado = carrito.splice(index, 1);
    console.log(`%c se quito ${eliminado[0].nombre}`, 'color: #ff4444; font-weight: bold;');
    actualizarInterfazCarrito();
};

function actualizarInterfazCarrito() {
    const countEl = document.getElementById('count-carrito');
    const lista = document.getElementById('lista-carrito');
    const totalEl = document.getElementById('total-carrito');
    
    if(countEl) countEl.innerText = carrito.length;
    if(!lista) return;

    let total = 0;
    lista.innerHTML = '';

    carrito.forEach((p, index) => {
        total += parseFloat(p.precio);
        lista.innerHTML += `
            <div class="list-group-item d-flex justify-content-between align-items-center">
                <span>${p.nombre} - <b>Q${p.precio}</b></span>
                <button class="btn btn-danger btn-sm" onclick="quitarDelCarrito(${index})">Quitar</button>
            </div>`;
    });
    if(totalEl) totalEl.innerText = total.toFixed(2);
}

// 5. MONITOR DE BASE DE DATOS
async function cargarMonitorDB() {
    try {
        const res = await fetch('http://localhost:3000/api/productos');
        const datos = await res.json();
        const tabla = document.getElementById('tabla-db');
        if(!tabla) return;
        
        tabla.innerHTML = '';
        datos.forEach(p => {
            tabla.innerHTML += `
                <tr>
                    <td>${p.id}</td>
                    <td>${p.nombre}</td>
                    <td><span class="badge bg-secondary">${p.stock}</span></td>
                    <td>Q${p.precio}</td>
                </tr>`;
        });
    } catch (e) { console.error("Error en monitor:", e); }
}

// 6. PROCESAR PAGO
function actualizarInterfazCarrito() {
    const countEl = document.getElementById('count-carrito');
    const lista = document.getElementById('lista-carrito');
    const totalEl = document.getElementById('total-carrito');
    
    if(countEl) countEl.innerText = carrito.length;
    if(!lista) return;

    let total = 0;
    lista.innerHTML = '';

    carrito.forEach((p, index) => {
        // Buscador inteligente de precio (por si se llama precio, valor, o price)
        const precioReal = parseFloat(p.precio || p.valor || p.price || 0);
        total += precioReal;

        lista.innerHTML += `
            <div class="list-group-item d-flex justify-content-between align-items-center animate__animated animate__fadeIn">
                <span>${p.nombre} - <b class="text-primary">Q${precioReal.toFixed(2)}</b></span>
                <button class="btn btn-danger btn-sm" onclick="quitarDelCarrito(${index})">Quitar</button>
            </div>`;
    });
    if(totalEl) totalEl.innerText = total.toFixed(2);
}

// 6. PROCESAR PAGO
window.procesarPago = async function() {
    if (carrito.length === 0) {
        alert("¡El carrito está vacío!");
        return;
    }

    if (!confirm("¿Deseas confirmar el pago? Esto restará el stock en la base de datos.")) return;

    try {
        const res = await fetch('http://localhost:3000/api/pagar', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ productos: carrito })
        });

        const data = await res.json();

        if (res.ok) {
            alert(" ¡Pago realizado con éxito! Inventario actualizado.");
            carrito = []; 
            actualizarInterfazCarrito();
            cargarProductos(); 
            mostrarSeccion('tienda');
        } else {
            alert(" Error: " + data.error);
        }
    } catch (e) {
        console.error("Error al pagar:", e);
        alert("No se pudo conectar con el servidor.");
    }
};

// 7. ACTUALIZAR INTERFAZ DEL CARRITO (AHORA CON PRECIO INTELIGENTE)
function actualizarInterfazCarrito() {
    const lista = document.getElementById('lista-carrito');
    const totalEl = document.getElementById('total-carrito');
    if(!lista || !totalEl) return;

    let total = 0;
    lista.innerHTML = '';

    carrito.forEach((p, index) => {
        // CAMBIO AQUÍ: usamos precio_unitario
        const precio = parseFloat(p.precio_unitario || 0);
        total += precio;

        lista.innerHTML += `
            <div class="list-group-item d-flex justify-content-between align-items-center">
                <span>${p.nombre} - <b>Q${precio.toFixed(2)}</b></span>
                <button class="btn btn-danger btn-sm" onclick="quitarDelCarrito(${index})">Quitar</button>
            </div>`;
    });
    totalEl.innerText = total.toFixed(2);
    if(document.getElementById('count-carrito')) {
        document.getElementById('count-carrito').innerText = carrito.length;
    }
}


// 8. CARGAR REPORTE DETALLADO
window.cargarReporte = async function() {
    try {
        const res = await fetch('http://localhost:3000/api/reporte-inventario');
        const datos = await res.json();
        const tabla = document.getElementById('tabla-reporte-cuerpo');
        if(!tabla) return;
        
        tabla.innerHTML = '';

        // Validación de seguridad para evitar el error "forEach is not a function"
        if (Array.isArray(datos)) {
            datos.forEach(item => {
                tabla.innerHTML += `
                    <tr>
                        <td>${item.producto_nombre}</td>
                        <td>${item.categoria_nombre}</td>
                        <td>${item.proveedor_nombre}</td>
                        <td class="${item.stock < 10 ? 'text-danger fw-bold' : ''}">${item.stock}</td>
                        <td>Q${parseFloat(item.precio_unitario || 0).toFixed(2)}</td>
                    </tr>`;
            });
        } else {
            console.error("Los datos recibidos no son un arreglo:", datos);
        }
    } catch (e) {
        console.error("Error cargando reporte:", e);
    }
};

// 9. GUARDAR NUEVO PRODUCTO DESDE ADMIN
document.addEventListener('DOMContentLoaded', () => {
    const form = document.getElementById('form-producto');
    if (form) {
        form.addEventListener('submit', async (e) => {
            e.preventDefault();

            const nuevoProducto = {
                nombre: document.getElementById('ins-nombre').value,
                precio_unitario: document.getElementById('ins-precio').value,
                stock: document.getElementById('ins-stock').value,
                id_categoria: document.getElementById('ins-cat').value,
                id_proveedor: document.getElementById('ins-prov').value,
                descripcion: "Producto agregado desde la interfaz"
            };

            try {
                const res = await fetch('http://localhost:3000/api/productos', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(nuevoProducto)
                });

                if (res.ok) {
                    alert("¡Producto guardado con éxito!");
                    form.reset();
                    cargarMonitorDB(); // Refresca la tabla para ver el nuevo item
                } else {
                    alert("Error al guardar");
                }
            } catch (error) {
                console.error("Error:", error);
            }
        });
    }
});
// INICIALIZACIÓN
document.addEventListener('DOMContentLoaded', cargarProductos);