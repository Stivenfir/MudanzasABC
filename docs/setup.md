# Setup de entorno de trabajo

## Prerrequisitos
- Node.js 20+
- npm 10+
- Docker y Docker Compose
- XAMPP opcional (si ya existe MySQL local)

## Variables de entorno
1. Copiar archivos ejemplo:
   - `cp .env.example .env`
   - `cp frontend/.env.example frontend/.env`
   - `cp backend/.env.example backend/.env`
2. Ajustar credenciales según ambiente.
3. Si usas XAMPP, deja `MYSQL_HOST_PORT=3308` (o cualquier puerto libre) para evitar choque con `3306`.

## Ejecución con contenedores
- Desde raíz:
  - `docker compose --env-file .env up --build -d`

## Inicialización de base de datos (MySQL actual)
- Ejecutar script base de identidad y roles:
  - `mysql -h 127.0.0.1 -P 3308 -u <usuario> -p <base_datos> < docs/sql/mysql-auth-base.sql`
- El script crea `pr_persona`, `pr_empleado`, `pr_rol`, `pr_empleado_rol` y `pr_usuario_login`.

## Backups recomendados (no depender de la imagen Docker)
- La imagen de MySQL **no es** respaldo de datos.
- El respaldo real debe salir de la base en ejecución:
  - `docker exec abcmudanzas_mysql mysqldump -uroot -p$MYSQL_ROOT_PASSWORD abcmudanzas > backup_abcmudanzas.sql`
- Restauración:
  - `docker exec -i abcmudanzas_mysql mysql -uroot -p$MYSQL_ROOT_PASSWORD abcmudanzas < backup_abcmudanzas.sql`

## Verificaciones mínimas
- API health: `GET /api/health`
- Swagger: `/api/docs`
- Frontend: carga de login/dashboard
