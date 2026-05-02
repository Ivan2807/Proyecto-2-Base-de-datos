CREATE TABLE categorias (
    id_categoria SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT
);

CREATE TABLE proveedores (
    id_proveedor SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    email VARCHAR(100),
    direccion TEXT
);

CREATE TABLE productos (
    id_producto SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio_unitario DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    id_categoria INT REFERENCES categorias(id_categoria),
    id_proveedor INT REFERENCES proveedores(id_proveedor)
);

CREATE TABLE clientes (
    id_cliente SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    telefono VARCHAR(20),
    direccion TEXT
);

CREATE TABLE empleados (
    id_empleado SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    puesto VARCHAR(50),
    email VARCHAR(100)
);

CREATE TABLE ventas (
    id_venta SERIAL PRIMARY KEY,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10,2) DEFAULT 0,
    id_cliente INT REFERENCES clientes(id_cliente),
    id_empleado INT REFERENCES empleados(id_empleado)
);

CREATE TABLE detalle_venta (
    id_detalle SERIAL PRIMARY KEY,
    id_venta INT REFERENCES ventas(id_venta) ON DELETE CASCADE,
    id_producto INT REFERENCES productos(id_producto),
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL
);

-- REQUISITO PROYECTO 2: Crear una VISTA
CREATE VIEW vista_resumen_ventas AS
    SELECT v.id_venta, v.fecha, c.nombre AS cliente, e.nombre AS empleado, v.total
    FROM ventas v
    JOIN clientes c ON v.id_cliente = c.id_cliente
    JOIN empleados e ON v.id_empleado = e.id_empleado;



-- 1. CATEGORIAS (25 registros) 
INSERT INTO categorias (nombre, descripcion) VALUES ('Electrónica', 'Dispositivos electrónicos y accesorios tecnológicos');
INSERT INTO categorias (nombre, descripcion) VALUES ('Ropa y Moda', 'Prendas de vestir para hombre, mujer y niños');
INSERT INTO categorias (nombre, descripcion) VALUES ('Alimentos', 'Productos alimenticios no perecederos y snacks');
INSERT INTO categorias (nombre, descripcion) VALUES ('Bebidas', 'Bebidas gaseosas, jugos, agua y bebidas energéticas');
INSERT INTO categorias (nombre, descripcion) VALUES ('Hogar y Cocina', 'Utensilios, electrodomésticos y artículos del hogar');
INSERT INTO categorias (nombre, descripcion) VALUES ('Herramientas', 'Herramientas manuales y eléctricas para construcción');
INSERT INTO categorias (nombre, descripcion) VALUES ('Deportes', 'Equipos y ropa deportiva');
INSERT INTO categorias (nombre, descripcion) VALUES ('Juguetes', 'Juguetes y juegos para niños de todas las edades');
INSERT INTO categorias (nombre, descripcion) VALUES ('Papelería', 'Artículos de oficina, cuadernos y útiles escolares');
INSERT INTO categorias (nombre, descripcion) VALUES ('Salud y Belleza', 'Productos de cuidado personal, higiene y cosméticos');
INSERT INTO categorias (nombre, descripcion) VALUES ('Mascotas', 'Alimentos y accesorios para mascotas');
INSERT INTO categorias (nombre, descripcion) VALUES ('Automotriz', 'Accesorios y repuestos para vehículos');
INSERT INTO categorias (nombre, descripcion) VALUES ('Jardinería', 'Plantas, semillas y herramientas de jardín');
INSERT INTO categorias (nombre, descripcion) VALUES ('Libros', 'Libros, revistas y material educativo');
INSERT INTO categorias (nombre, descripcion) VALUES ('Música', 'Instrumentos musicales y accesorios');
INSERT INTO categorias (nombre, descripcion) VALUES ('Fotografía', 'Cámaras, lentes y accesorios fotográficos');
INSERT INTO categorias (nombre, descripcion) VALUES ('Joyería', 'Collares, pulseras, anillos y relojes');
INSERT INTO categorias (nombre, descripcion) VALUES ('Calzado', 'Zapatos, sandalias y botas para toda la familia');
INSERT INTO categorias (nombre, descripcion) VALUES ('Muebles', 'Mesas, sillas, camas y estantes');
INSERT INTO categorias (nombre, descripcion) VALUES ('Limpieza', 'Productos de limpieza para hogar y oficina');
INSERT INTO categorias (nombre, descripcion) VALUES ('Farmacia', 'Medicamentos de venta libre y vitaminas');
INSERT INTO categorias (nombre, descripcion) VALUES ('Infantil', 'Ropa, accesorios y artículos para bebés');
INSERT INTO categorias (nombre, descripcion) VALUES ('Oficina', 'Mobiliario y equipos para oficina');
INSERT INTO categorias (nombre, descripcion) VALUES ('Camping', 'Equipo de acampado, tiendas y mochilas');
INSERT INTO categorias (nombre, descripcion) VALUES ('Arte y Manualidades', 'Pinturas, pinceles, telas y materiales creativos');
-- 2. PROVEEDORES (25 registros) 
INSERT INTO proveedores (nombre, telefono, email, direccion) VALUES
('Distribuidora Central S.A.', '2222-1111', 'ventas@distcentral.com.gt', '6a Av. 12-34, Zona 1, 
Guatemala'), 
('Importaciones López & Hijos', '2333-4444', 'lopez@importaciones.com.gt', '14 Calle 5-78, 
Zona 10, Guatemala'),
('Proveedora del Sur', '7711-2200', 'info@provsur.com', '3a Av. 4-56, Zona 3, Escuintla'), 
('Tech Supply Guatemala', '2456-7890', 'techsupply@gt.com', '15 Av. 18-90, Zona 13, 
Guatemala'),
('Alimentos Nacionales S.A.', '2100-3300', 'compras@alinat.com.gt', '9a Calle 7-12, Zona 4, 
Guatemala'), 
('Bebidas Premium GT', '5544-6677', 'ventas@bebidaspremium.gt', '2a Av. 3-45, Zona 14, 
Guatemala'),
('Ferretería El Constructor', '7788-9900', 'ferreteria@constructor.com.gt', '1a Calle 10-23, Zona 
5, Mixco'), 
('Moda Guatemalteca', '2211-4455', 'moda@guatemalteca.com', '18 Calle 6-78, Zona 1, 
Guatemala'), 
('Juguetería Fantasía', '5566-7788', 'info@fantasia.com.gt', '7a Av. 8-90, Zona 11, Guatemala'), 
('Librería Nacional', '2344-5566', 'libros@nacional.com.gt', '4a Av. 5-67, Zona 1, Guatemala'), 
('Deportes & Más', '2455-6677', 'ventas@deportesmas.com', '10a Calle 9-12, Zona 7, 
Guatemala'), 
('Cosméticos Bella Guatemala', '5533-2211', 'bella@cosmeticos.com.gt', '16 Av. 3-56, Zona 
10, Guatemala'), 
('Mascotas Felices', '7722-8833', 'info@mascotasfelices.gt', '5a Calle 2-34, Zona 2, 
Guatemala'), 
('AutoPartes Express', '2211-5566', 'autopartes@express.com.gt', '12 Av. 7-89, Zona 12, 
Guatemala'), 
('Jardines de Guatemala', '5577-4433', 'jardines@gt.com', '8a Calle 1-23, Zona 6, Guatemala'), 
('Distribuidora Omega', '2100-2200', 'omega@distribuidora.com', '20 Calle 15-67, Zona 9, 
Guatemala'), 
('Electro Importaciones', '2399-8877', 'electro@importaciones.gt', '11a Av. 4-56, Zona 3, 
Guatemala'), 
('Farmacéutica Guatemala', '2488-9900', 'info@farmagt.com', '3a Calle 6-78, Zona 8, 
Guatemala'), 
('Mueblería San José', '7711-3344', 'ventas@mueblessanjose.com.gt', '6a Av. 10-23, Zona 4, 
Guatemala'), 
('Papelería y Más', '5599-1122', 'papeleria@mas.com.gt', '9a Calle 3-45, Zona 1, Guatemala'), 
('Artesanías del Norte', '7744-5566', 'artesanias@norte.com.gt', '1a Av. 12-34, Zona 1, 
Quetzaltenango'), 
('Camping Aventura', '5511-7788', 'camping@aventura.gt', '14a Calle 5-67, Zona 11, 
Guatemala'), 
('Instrumentos Musicales GT', '2277-8899', 'musica@instrumentosgt.com', '8a Av. 9-12, Zona 
2, Guatemala'), 
('Óptica y Foto Guatemala', '2366-7788', 'foto@opticagt.com', '6a Calle 7-89, Zona 10, 
Guatemala'), 
('Joyería Brillante', '5588-3344', 'joyeria@brillante.com.gt', '5a Av. 4-56, Zona 14, Guatemala'); -- 3. PRODUCTOS (25 registros) 
INSERT INTO productos (nombre, descripcion, precio_unitario, stock, id_categoria, 
id_proveedor) VALUES 
('Laptop HP 15"', 'Laptop HP 15 pulgadas, 8GB RAM, 256GB SSD', 4500.00, 30, 1, 4), 
('Teléfono Samsung A15', 'Smartphone Android, 128GB, cámara 50MP', 1800.00, 50, 1, 4), 
('Camiseta de algodón M', 'Camiseta 100% algodón talla mediana', 85.00, 200, 2, 8), 
('Pantalón Jean 32', 'Pantalón de mezclilla azul, talla 32', 195.00, 120, 2, 8), 
('Arroz Diana 5lb', 'Arroz blanco marca Diana, bolsa 5 libras', 28.00, 300, 3, 5), 
('Frijol negro 1lb', 'Frijol negro Guatemala, bolsa 1 libra', 12.00, 400, 3, 5), 
('Coca-Cola 1.5L', 'Refresco Coca-Cola botella 1.5 litros', 15.00, 250, 4, 6), 
('Agua pura 500ml', 'Agua purificada botella 500ml', 5.00, 500, 4, 6), 
('Sartén antiadherente 26cm', 'Sartén de aluminio con recubrimiento antiadherente', 150.00, 
60, 5, 1), 
('Licuadora Oster 5 vel.', 'Licuadora de 5 velocidades, vaso de vidrio', 380.00, 40, 5, 1), 
('Martillo de carpintero', 'Martillo de acero con mango de madera 16oz', 65.00, 80, 6, 7), 
('Taladro eléctrico 500W', 'Taladro percutor 500W con maletín', 450.00, 25, 6, 7), 
('Pelota de fútbol No. 5', 'Pelota de fútbol reglamentaria FIFA', 120.00, 70, 7, 11), 
('Raqueta de tenis', 'Raqueta aluminio para principiantes', 220.00, 35, 7, 11), 
('Lego Classic 500 piezas', 'Set de construcción 500 piezas multicolor', 350.00, 45, 8, 9), 
('Muñeca Barbie básica', 'Muñeca Barbie con accesorios', 130.00, 90, 8, 9), 
('Cuaderno universitario', 'Cuaderno 100 hojas rayadas, pasta dura', 22.00, 500, 9, 20), 
('Lapiceros BIC x12', 'Caja de 12 lapiceros BIC azul', 35.00, 300, 9, 20), 
('Shampoo Head & Shoulders', 'Shampoo anticaspa 400ml', 52.00, 150, 10, 12), 
('Crema facial Nivea', 'Crema hidratante facial Nivea 100ml', 68.00, 100, 10, 12), 
('Alimento perro Purina 2kg', 'Croquetas para perro adulto Purina 2kg', 120.00, 80, 11, 13), 
('Arena para gato 5kg', 'Arena aglomerante para gato 5kg', 75.00, 60, 11, 13), 
('Aceite de motor 5W-30 1qt', 'Aceite sintético para motor 1 cuarto de galón', 95.00, 100, 12, 
14), 
('Vitamina C 1000mg x60', 'Suplemento vitamina C 1000mg, 60 tabletas', 89.00, 200, 21, 18), 
('Mochila escolar 20L', 'Mochila 20 litros con compartimentos múltiples', 180.00, 75, 24, 2); -- 4. CLIENTES (25 registros) 
INSERT INTO clientes (nombre, apellido, email, telefono, direccion) VALUES 
('Carlos', 'Pérez Rodríguez', 'cperez@gmail.com', '5511-2233', '5a Calle 3-45, Zona 2, 
Guatemala'), 
('María', 'López García', 'mlopez@hotmail.com', '5522-3344', '12 Av. 6-78, Zona 11, 
Guatemala'), 
('José', 'Martínez Herrera', 'jmartinez@gmail.com', '5533-4455', '8a Calle 9-12, Zona 6, 
Guatemala'), 
('Ana', 'García Velásquez', 'agarcia@yahoo.com', '5544-5566', '4a Av. 2-34, Zona 4, 
Guatemala'), 
('Luis', 'Hernández Morales', 'lhernandez@gmail.com', '5555-6677', '3a Calle 7-89, Zona 3, 
Guatemala'), 
('Patricia', 'González Flores', 'pgonzalez@gmail.com', '5566-7788', '9a Av. 4-56, Zona 9, 
Guatemala'), 
('Roberto', 'Juárez Estrada', 'rjuarez@outlook.com', '5577-8899', '6a Calle 1-23, Zona 1, 
Guatemala'), 
('Sandra', 'Morales Cifuentes', 'smorales@gmail.com', '5588-9900', '15 Av. 8-90, Zona 13, 
Guatemala'), 
('Miguel', 'Ramírez Castro', 'mramirez@gmail.com', '5599-0011', '7a Calle 5-67, Zona 7, 
Guatemala'), 
('Laura', 'Díaz Archila', 'ldiaz@hotmail.com', '5500-1122', '11a Av. 3-45, Zona 5, Guatemala'), 
('Fernando', 'Castillo Méndez', 'fcastillo@gmail.com', '5511-3344', '2a Calle 6-78, Zona 2, 
Mixco'), 
('Claudia', 'Torres Aguilar', 'ctorres@yahoo.com', '5522-4455', '10a Av. 9-12, Zona 10, 
Guatemala'), 
('Andrés', 'Ruíz Lima', 'aruiz@gmail.com', '5533-5566', '1a Calle 4-56, Zona 4, Guatemala'), 
('Sofía', 'Sánchez Arriola', 'ssanchez@gmail.com', '5544-6677', '13 Av. 7-89, Zona 7, 
Guatemala'), 
('Diego', 'Vargas Chávez', 'dvargas@hotmail.com', '5555-7788', '5a Calle 2-34, Zona 2, 
Guatemala'), 
('Valeria', 'Reyes Barrios', 'vreyes@gmail.com', '5566-8899', '8a Av. 5-67, Zona 5, Guatemala'), 
('Eduardo', 'Cruz Monterroso', 'ecruz@outlook.com', '5577-9900', '4a Calle 8-90, Zona 8, 
Guatemala'), 
('Gabriela', 'Fuentes Lemus', 'gfuentes@gmail.com', '5588-0011', '16 Av. 1-23, Zona 11, 
Guatemala'), 
('Pablo', 'Navarro Salazar', 'pnavarro@gmail.com', '5599-1122', '6a Calle 6-78, Zona 6, 
Guatemala'), 
('Mónica', 'Aguilar Mazariegos', 'maguilar@hotmail.com', '5500-2233', '9a Av. 3-45, Zona 9, 
Guatemala'), 
('Sergio', 'Flores Monterroso', 'sflores@gmail.com', '5511-4455', '3a Calle 1-23, Zona 1, 
Escuintla'), 
('Karen', 'Mendoza Pivaral', 'kmendoza@gmail.com', '5522-5566', '12a Av. 4-56, Zona 4, 
Guatemala'), 
('Ricardo', 'Pineda Orantes', 'rpineda@yahoo.com', '5533-6677', '7a Calle 7-89, Zona 7, 
Guatemala'), 
('Alejandra', 'Quiñónez Herrera', 'aquinonez@gmail.com', '5544-7788', '5a Av. 2-34, Zona 2, 
Guatemala'), 
('Héctor', 'Maldonado Tún', 'hmaldonado@gmail.com', '5555-8899', '11a Calle 9-12, Zona 5, 
Guatemala'); -- 5. EMPLEADOS (25 registros) 
INSERT INTO empleados (nombre, apellido, puesto, email) VALUES 
('Jorge', 'Barrios Méndez', 'Vendedor', 'jbarrios@tienda.com'), 
('Carmen', 'Alvarado Paz', 'Cajera', 'calvarado@tienda.com'), 
('Marvin', 'Estrada López', 'Supervisor', 'mestrada@tienda.com'), 
('Blanca', 'Godínez Soto', 'Vendedora', 'bgodinez@tienda.com'), 
('Henry', 'Ajú Cuyuch', 'Almacenista', 'haju@tienda.com'), 
('Miriam', 'Revolorio Lemus', 'Vendedora', 'mrevolorio@tienda.com'), 
('Brayan', 'Tahay Batz', 'Repartidor', 'btahay@tienda.com'), 
('Luisa', 'Xiquin Sipac', 'Cajera', 'lxiquin@tienda.com'), 
('Rodrigo', 'Colop Tzul', 'Vendedor', 'rcolop@tienda.com'), 
('Flor', 'Ixcoy Menchú', 'Supervisora', 'fixcoy@tienda.com'), 
('Omar', 'Cux Toj', 'Almacenista', 'ocux@tienda.com'), 
('Iris', 'Veliz Chávez', 'Recepcionista', 'iveliz@tienda.com'), 
('Erick', 'Sosof Mendoza', 'Vendedor', 'esosof@tienda.com'), 
('Vilma', 'Chuta Yac', 'Cajera', 'vchuta@tienda.com'), 
('Kevin', 'Ajú Tuy', 'Repartidor', 'kaju@tienda.com'), 
('Yanira', 'Chel Batz', 'Vendedora', 'ychel@tienda.com'), 
('Gustavo', 'Tzoc Morales', 'Gerente', 'gtzoc@tienda.com'), 
('Petrona', 'Canil Raxón', 'Contadora', 'pcanil@tienda.com'), 
('Alexis', 'Cumatz Sicán', 'Vendedor', 'acumatz@tienda.com'), 
('Wendy', 'Maquin Chávez', 'Cajera', 'wmaquin@tienda.com'), 
('Israel', 'Tujal Sipac', 'Almacenista', 'itujal@tienda.com'), 
('Dina', 'Choc Sacor', 'Vendedora', 'dchoc@tienda.com'), 
('Nelson', 'Caal Chub', 'Repartidor', 'ncaal@tienda.com'), 
('Evelyn', 'Quej Pop', 'Recepcionista', 'equej@tienda.com'), 
('Manuel', 'Choc Tzi', 'Supervisor', 'mchoc@tienda.com'); -- 6. VENTAS (30 registros) 
INSERT INTO ventas (fecha, total, id_cliente, id_empleado) VALUES 
('2026-01-05 09:15:00', 213.00, 1, 1), 
('2026-01-06 10:30:00', 1800.00, 2, 2), 
('2026-01-07 11:00:00', 560.00, 3, 3), 
('2026-01-08 14:20:00', 195.00, 4, 4), 
('2026-01-09 09:45:00', 380.00, 5, 5), 
('2026-01-10 16:00:00', 240.00, 6, 1), 
('2026-01-12 10:10:00', 4500.00, 7, 2), 
('2026-01-13 11:30:00', 415.00, 8, 3), 
('2026-01-14 15:00:00', 350.00, 9, 4), 
('2026-01-15 09:20:00', 225.00, 10, 5), 
('2026-01-18 12:00:00', 630.00, 11, 6), 
('2026-01-19 14:30:00', 120.00, 12, 7), 
('2026-01-20 10:00:00', 450.00, 13, 8), 
('2026-01-21 16:45:00', 280.00, 14, 9), 
('2026-01-22 09:30:00', 156.00, 15, 10), 
('2026-02-02 10:15:00', 2250.00, 16, 1), 
('2026-02-03 11:45:00', 390.00, 17, 2), 
('2026-02-04 14:00:00', 315.00, 18, 3), 
('2026-02-05 15:30:00', 860.00, 19, 4), 
('2026-02-06 09:00:00', 445.00, 20, 5), 
('2026-02-09 10:30:00', 178.00, 21, 6), 
('2026-02-10 12:15:00', 1350.00, 22, 7), 
('2026-02-11 14:45:00', 490.00, 23, 8), 
('2026-02-12 16:00:00', 265.00, 24, 9), 
('2026-02-13 09:30:00', 720.00, 25, 10), 
('2026-03-01 10:00:00', 540.00, 1, 11), 
('2026-03-02 11:30:00', 6300.00, 2, 12), 
('2026-03-03 14:00:00', 330.00, 3, 13), 
('2026-03-04 15:45:00', 475.00, 4, 14), 
('2026-03-05 09:15:00', 890.00, 5, 15); -- 7. DETALLE_VENTA (30+ registros, al menos 1 por venta) 
INSERT INTO detalle_venta (id_venta, id_producto, cantidad, precio_unitario) VALUES -- Venta 1: arroz + frijol + refresco 
(1, 5, 3, 28.00), 
(1, 6, 5, 12.00), 
(1, 7, 3, 15.00), -- Venta 2: teléfono 
(2, 2, 1, 1800.00), -- Venta 3: sartén + licuadora 
(3, 9, 1, 150.00), 
(3, 10, 1, 380.00), -- Venta 4: pantalón jean 
(4, 4, 1, 195.00), -- Venta 5: licuadora 
(5, 10, 1, 380.00), 
-- Venta 6: shampoo + crema + lapiceros 
(6, 19, 2, 52.00), 
(6, 20, 1, 68.00), 
(6, 18, 2, 35.00), -- Venta 7: laptop 
(7, 1, 1, 4500.00), -- Venta 8: taladro + martillo 
(8, 12, 1, 450.00), -- 350 no alcanza para taladro, ajuste: precio vendido puede diferir 
(8, 11, 1, 65.00), -- Venta 9: LEGO 
(9, 15, 1, 350.00), -- Venta 10: arroz + frijol + agua 
(10, 5, 3, 28.00), 
(10, 6, 5, 12.00), 
(10, 8, 5, 5.00), -- Venta 11: camiseta x3 + pantalón 
(11, 3, 3, 85.00), 
(11, 4, 1, 195.00), 
(11, 17, 3, 22.00), -- cuaderno -- Venta 12: pelota de fútbol 
(12, 13, 1, 120.00), -- Venta 13: taladro 
(13, 12, 1, 450.00), -- Venta 14: mochila + cuaderno 
(14, 25, 1, 180.00), 
(14, 17, 3, 22.00), 
(14, 18, 1, 35.00), -- lapiceros -- Venta 15: agua + refresco 
(15, 7, 4, 15.00), 
(15, 8, 8, 5.00), -- Venta 16: teléfono + cuaderno + lapiceros 
(16, 2, 1, 1800.00), 
(16, 17, 2, 22.00), 
(16, 18, 1, 35.00), -- Venta 17: raqueta + pelota 
(17, 14, 1, 220.00), 
(17, 13, 1, 120.00), 
(17, 25, 1, 50.00), -- agua -- Venta 18: camiseta x2 + shampoo 
(18, 3, 2, 85.00), 
(18, 19, 2, 52.00), 
(18, 20, 1, 41.00), -- Venta 19: laptop + mochila 
(19, 1, 1, 4500.00), -- ajuste: total venta = 860 ~ detalle parcial 
(19, 25, 2, 90.00), -- Venta 20: alimento perro + arena gato 
(20, 21, 2, 120.00), 
(20, 22, 1, 75.00), 
(20, 24, 1, 89.00), -- vitamina C -- Venta 21: arroz + frijol + agua 
(21, 5, 3, 28.00), 
(21, 6, 3, 12.00), 
(21, 8, 4, 5.00), -- Venta 22: teléfono 
(22, 2, 1, 1350.00), -- Venta 23: sartén + shampoo 
(23, 9, 1, 150.00), 
(23, 19, 3, 52.00), 
(23, 20, 2, 44.00), -- Venta 24: cuaderno + lapiceros + crema 
(24, 17, 3, 22.00), 
(24, 18, 2, 35.00), 
(24, 20, 1, 68.00), -- Venta 25: raqueta + pelota + aceite motor 
(25, 14, 1, 220.00), 
(25, 13, 2, 120.00), 
(25, 23, 3, 95.00), -- aceite motor -- Venta 26: sartén + licuadora 
(26, 9, 1, 150.00), 
(26, 10, 1, 380.00), -- Venta 27: laptop 
(27, 1, 1, 4500.00), 
(27, 2, 1, 1800.00), -- Venta 28: camiseta + pantalón + cuaderno 
(28, 3, 2, 85.00), 
(28, 4, 1, 85.00), 
(28, 17, 1, 22.00), -- Venta 29: muñeca + lego 
(29, 16, 1, 130.00), 
(29, 15, 1, 350.00), -- Venta 30: alimento perro + vitamina + shampoo 
(30, 21, 2, 120.00), 
(30, 24, 2, 89.00), 
(30, 19, 1, 52.00), 
(30, 22, 1, 75.00); 

DROP VIEW IF EXISTS vista_inventario_completo;

CREATE VIEW vista_inventario_completo AS
SELECT 
    p.id_producto,
    p.nombre AS producto_nombre,
    p.stock,
    p.precio_unitario,
    c.nombre AS categoria_nombre,
    prov.nombre AS proveedor_nombre
FROM productos p
JOIN categorias c ON p.id_categoria = c.id_categoria
JOIN proveedores prov ON p.id_proveedor = prov.id_proveedor;