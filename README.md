# Proyecto 2 - Gestión de Inventario UVG Store 

Este proyecto es una aplicación web full-stack para la gestión de inventario y ventas de una tienda, desarrollada para el curso de **Bases de Datos 1**. La aplicación permite visualizar productos, gestionar un carrito de compras con transacciones seguras y generar reportes detallados mediante vistas de base de datos.

##  Requisitos Previos
* [Docker Desktop](https://www.docker.com/products/docker-desktop/) instalado y en ejecución.
* Docker Compose habilitado.

## 🛠️ Stack Tecnológico
* **Base de Datos:** PostgreSQL 15 (Dockerizado).
* **Backend:** Node.js con Express (API REST).
* **Frontend:** HTML5, CSS3 (Bootstrap 5) y JavaScript Vanilla.
* **Servidor Web:** Nginx (para el despliegue del frontend).

## 📥 Instalación y Despliegue

Siga estos pasos para levantar el proyecto localmente:

1. **Clonar el repositorio** (o descargar la carpeta del proyecto).
2. **Configurar variables de entorno:**
   Asegúrese de que el archivo `.env` en la raíz tenga las credenciales oficiales requeridas:
   ```env
   DB_USER=proy2
   DB_PASSWORD=secret
   DB_NAME=tienda_db
   DB_HOST=db
   PORT=3000

   Levantar los contenedores:
3.**Abra una terminal en la carpeta raíz y ejecute:**
docker compose up --build

4.**Acceder a la aplicación:**

Frontend: http://localhost:8080

Backend (API): http://localhost:3000

4.**Roles Creados**
### Roles Definidos:
| Rol | Descripción | Permisos |
| :--- | :--- | :--- |
| **admin_role** | Superusuario | Acceso total a todas las tablas y secuencias. |
| **inventario_role** | Bodega | CRUD en productos, categorías y proveedores. |
| **ventas_role** | Cajero | Insertar ventas y actualizar stock de productos. |
| **cliente_role** | App Usuario | Solo lectura de productos y registro de cliente. |
| **auditor_role** | Auditoría | Acceso de solo lectura (`SELECT`) a todo el esquema. |

### Esquema de Permisos
* Los usuarios de ventas no pueden eliminar productos.
* Los clientes no tienen acceso a la tabla de empleados.
* Se crearon usuarios de prueba vinculados a cada rol para validación inmediata (ver sección de Usuarios de Prueba).

## Usuarios de prueba
| Usuario | Contraseña | Rol Asignado |
| :--- | :--- | :--- |
| `user_admin` | `admin123` | admin_role |
| `user_cajero` | `venta123` | ventas_role |
| `user_bodega` | `stock123` | inventario_role |
| `user_cliente`| `visitante123` | cliente_role |
| `user_auditor`| `audit123` | auditor_role |


II. SQL (Consultas Avanzadas)
Transacciones: Ruta /api/pagar con manejo explícito de BEGIN, COMMIT y ROLLBACK para el descuento de stock.

JOINs: Reporte que vincula Productos, Categorías y Proveedores.

Vistas (VIEW): Consumo de vista_inventario_completo para el reporte detallado en la UI.

Filtros y Ordenamiento: Consultas SQL con cláusulas WHERE y ORDER BY dinámicas.

III. Aplicación Web
CRUD Completo: Interfaz para Crear (Formulario en pestaña Base de Datos), Leer (Tienda) y Actualizar (Ventas/Stock).

Reporte en UI: Sección de "Reporte Detallado" con datos reales de la base de datos.

Manejo de Errores: Validaciones y mensajes informativos (alertas) integrados en la interfaz.

Universidad del Valle de Guatemala

**Hecho por:**
Ivan Morataya
**Carnet:** 16667
