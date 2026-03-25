-- Esquema base para identidad corporativa en MySQL 8+
-- Convención en español: PRPersona + PREmpleado + PRRol

CREATE DATABASE IF NOT EXISTS abcmudanzas CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE abcmudanzas;

CREATE TABLE IF NOT EXISTS pr_persona (
  persona_id INT AUTO_INCREMENT PRIMARY KEY,
  tipo_documento VARCHAR(20) NOT NULL,
  numero_documento VARCHAR(30) NOT NULL,
  nombres VARCHAR(80) NOT NULL,
  apellidos VARCHAR(80) NOT NULL,
  correo_electronico VARCHAR(120) NULL,
  telefono VARCHAR(30) NULL,
  esta_activo TINYINT(1) NOT NULL DEFAULT 1,
  creado_en DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  actualizado_en DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY uk_pr_persona_numero_documento (numero_documento)
);

CREATE TABLE IF NOT EXISTS pr_empleado (
  empleado_id INT AUTO_INCREMENT PRIMARY KEY,
  persona_id INT NOT NULL,
  codigo_empleado VARCHAR(30) NOT NULL,
  cargo VARCHAR(100) NOT NULL,
  area VARCHAR(100) NOT NULL,
  estado_empleado VARCHAR(20) NOT NULL DEFAULT 'ACTIVO',
  fecha_ingreso DATE NULL,
  creado_en DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  actualizado_en DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY uk_pr_empleado_persona (persona_id),
  UNIQUE KEY uk_pr_empleado_codigo (codigo_empleado),
  CONSTRAINT fk_pr_empleado_persona FOREIGN KEY (persona_id) REFERENCES pr_persona(persona_id)
);

CREATE TABLE IF NOT EXISTS pr_rol (
  rol_id INT AUTO_INCREMENT PRIMARY KEY,
  codigo_rol VARCHAR(40) NOT NULL,
  nombre_rol VARCHAR(100) NOT NULL,
  descripcion VARCHAR(255) NULL,
  esta_activo TINYINT(1) NOT NULL DEFAULT 1,
  creado_en DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  actualizado_en DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY uk_pr_rol_codigo (codigo_rol)
);

CREATE TABLE IF NOT EXISTS pr_empleado_rol (
  empleado_rol_id INT AUTO_INCREMENT PRIMARY KEY,
  empleado_id INT NOT NULL,
  rol_id INT NOT NULL,
  esta_activo TINYINT(1) NOT NULL DEFAULT 1,
  creado_en DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  actualizado_en DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY uk_pr_empleado_rol_unique (empleado_id, rol_id),
  CONSTRAINT fk_pr_empleado_rol_empleado FOREIGN KEY (empleado_id) REFERENCES pr_empleado(empleado_id),
  CONSTRAINT fk_pr_empleado_rol_rol FOREIGN KEY (rol_id) REFERENCES pr_rol(rol_id)
);

CREATE TABLE IF NOT EXISTS pr_usuario_login (
  usuario_id INT AUTO_INCREMENT PRIMARY KEY,
  empleado_id INT NOT NULL,
  nombre_usuario VARCHAR(80) NOT NULL,
  contrasena_hash VARCHAR(255) NOT NULL,
  esta_activo TINYINT(1) NOT NULL DEFAULT 1,
  ultimo_ingreso_en DATETIME NULL,
  creado_en DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  actualizado_en DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY uk_pr_usuario_login_nombre_usuario (nombre_usuario),
  UNIQUE KEY uk_pr_usuario_login_empleado (empleado_id),
  CONSTRAINT fk_pr_usuario_login_empleado FOREIGN KEY (empleado_id) REFERENCES pr_empleado(empleado_id)
);

-- Carga de roles sugeridos
INSERT INTO pr_rol (codigo_rol, nombre_rol, descripcion)
VALUES
  ('CLIENTE', 'Cliente', 'Usuario externo con visibilidad de su caso'),
  ('COMERCIAL', 'Comercial mudanzas', 'Gestión comercial y oportunidad'),
  ('PRICING', 'Pricing', 'Validación de tarifas y costos'),
  ('EJECUTIVO_CUENTA', 'Ejecutivo de cuenta movilidad', 'Control E2E de la operación'),
  ('FINANCIERO', 'Financiero', 'Pagos, cobros y validaciones de cartera'),
  ('GERENTE', 'Gerente de mudanzas', 'Supervisión gerencial'),
  ('DIRECTOR', 'Director de movilidad global', 'Supervisión ejecutiva global')
ON DUPLICATE KEY UPDATE nombre_rol = VALUES(nombre_rol), descripcion = VALUES(descripcion);
