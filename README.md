# 🧪 SauceDemo E2E Automation with Playwright + Cucumber

![Playwright](https://img.shields.io/badge/Playwright-1.58.2-green)
![Cucumber](https://img.shields.io/badge/Cucumber-9.6.0-brightgreen)
![TypeScript](https://img.shields.io/badge/TypeScript-5.7.3-blue)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15-blue)
![Docker](https://img.shields.io/badge/Docker-Ready-2496ED)

Proyecto de automatización E2E para SauceDemo utilizando Playwright + Cucumber con TypeScript.

## 📋 Tabla de Contenidos

- [Instalación](#-instalación)
- [Ejecución de Tests](#-ejecución-de-tests)
- [CI/CD con GitHub Actions](#-cicd-con-github-actions)
- [Reportes](#-reportes)
- [Estructura del Proyecto](#-estructura-del-proyecto)
- [Escenarios Implementados](#-escenarios-implementados)
- [Base de Datos SQL](#-base-de-datos-sql)

## 📦 Instalación

### Paso 1: Clonar el repositorio

```bash
git clone https://github.com/tu-usuario/SauceDemo.git
cd SauceDemo
```

### Paso 2: Instalar dependencias

```bash
npm install
```

### Paso 3: Instalar navegadores de Playwright

```bash
npx playwright install chromium firefox

# Para Windows, instalar también Edge:
npx playwright install msedge

# Para macOS, instalar también WebKit (Safari):
npx playwright install webkit
```

## 🚀 Ejecución de Tests

### Ejecutar con interfaz gráfica (headed)

```bash
npm run test:headed     # Abre el navegador para ver la ejecución (Chromium por defecto)
```

**Ejecutar con navegador específico:**

```bash
# Windows PowerShell
$env:BROWSER="firefox"; npm run test:headed
$env:BROWSER="msedge"; npm run test:headed

# Windows CMD
set BROWSER=firefox && npm run test:headed
set BROWSER=msedge && npm run test:headed

# Linux/Mac
BROWSER=firefox npm run test:headed
BROWSER=webkit npm run test:headed
```

### Ejecutar en modo headless (sin ventana)

```bash
npm test                # Todos los tests
npm run test:headless   # Todos los tests (explícito)
npm run test:smoke      # Solo tests @smoke
npm run test:regression # Solo tests @regression
```

### Ejecutar en navegadores específicos (headless)

```bash
npm run test:chrome      # Chrome/Chromium
npm run test:firefox     # Firefox
npm run test:edge        # Microsoft Edge (solo Windows)
```

### Ejecutar en todos los navegadores (headless, paralelo)

```bash
npm run test:all-browsers  # Corre en Chrome, Firefox y Edge en paralelo
```

**Reporte generado:** Cada navegador genera su propio reporte HTML:
- Chromium: `reports/chromium-report.html`
- Firefox: `reports/firefox-report.html`
- Edge: `reports/msedge-report.html`

### Ejecutar con tags específicos (headless)

```bash
npx cucumber-js --tags "@smoke"
npx cucumber-js --tags "@regression"
npx cucumber-js --tags "@critical"
npx cucumber-js --tags "@negative"
```

**Nota**: 
- Solo `npm run test:headed` abre ventana del navegador
- Por defecto usa Chromium, pero puedes especificar otro con la variable `BROWSER`
- Todos los demás comandos corren en modo headless
- `test:all-browsers` ejecuta en paralelo, cada navegador genera su propio reporte
- Screenshots y videos se organizan por navegador en subdirectorios
- En CI/CD siempre corre en headless automáticamente

## 🔄 CI/CD con GitHub Actions

El proyecto incluye un workflow de GitHub Actions que se ejecuta automáticamente:

### Triggers
- Push a la rama `main`
- Pull requests a `main`
- Ejecución manual desde Actions tab

### Jobs

**1. Smoke Tests** (se ejecuta primero)
- Timeout: 5 minutos
- Ejecuta tests con tag `@smoke`
- Genera reportes y artifacts

**2. Full Tests** (se ejecuta después de smoke tests)
- Timeout: 10 minutos
- Ejecuta todos los tests en múltiples navegadores y sistemas operativos:
  - **Ubuntu**: Chromium + Firefox
  - **Windows**: Edge
  - **macOS**: WebKit (Safari)
- Total: 4 combinaciones en paralelo
- Genera reportes completos
- Sube screenshots en caso de fallos
- Sube videos de ejecución

### Artifacts Generados
- `cucumber-reports`: Reportes HTML completos (7 días)
- `smoke-test-reports`: Reportes de smoke tests (7 días)
- `screenshots`: Capturas de pantalla de fallos (7 días)
- `videos`: Videos de ejecución (3 días)

### Ejecutar Workflow Manualmente
1. Ve a la pestaña **Actions** en GitHub
2. Selecciona **Playwright + Cucumber E2E Tests**
3. Click en **Run workflow**
4. Selecciona la rama y ejecuta

## 📊 Reportes

### Abrir reporte HTML

Después de ejecutar los tests, el reporte HTML se genera automáticamente:

```bash
npm run report
```

O manualmente:
```bash
start reports/cucumber-report.html
```

**Ubicación**: `reports/cucumber-report.html`

### Screenshots

Los screenshots de fallos se guardan organizados por navegador:

```
reports/screenshots/
├── chromium/
│   └── Login_Failed_1234567890.png
├── firefox/
│   └── Data_Driven_1234567891.png
└── msedge/
    └── Happy_Path_1234567892.png
```

**Formato**: `{nombre_escenario}_{timestamp}.png`

### Videos

Los videos de ejecución se guardan organizados por navegador y ejecución (formato .webm):

```
reports/videos/
├── chromium/
│   ├── 2026-02-15T13-59-33/
│   │   ├── video1.webm
│   │   └── video2.webm
│   └── 2026-02-15T16-15-20/
│       └── video1.webm
├── firefox/
│   └── 2026-02-15T15-45-10/
│       └── video1.webm
└── msedge/
    └── 2026-02-15T16-00-30/
        └── video1.webm
```

**Organización**: Cada ejecución crea una carpeta con fecha y hora en formato ISO 8601 (YYYY-MM-DDTHH-MM-SS) dentro del navegador correspondiente.

**Nota**: Los videos NO se suben al repositorio por su tamaño.

## 📁 Estructura del Proyecto

```
SauceDemo/
├── .github/
│   └── workflows/
│       └── e2e-tests.yml        # CI/CD con GitHub Actions
├── tests/
│   ├── features/                # Archivos .feature de Gherkin
│   │   └── saucedemo.feature
│   ├── pages/                   # Page Object Models
│   │   ├── LoginPage.ts
│   │   ├── InventoryPage.ts
│   │   ├── CartPage.ts
│   │   └── CheckoutPage.ts
│   ├── steps/                   # Step Definitions (separados por dominio)
│   │   ├── login.steps.ts
│   │   ├── inventory.steps.ts
│   │   ├── cart.steps.ts
│   │   └── checkout.steps.ts
│   └── support/                 # Configuración y Hooks
│       ├── world.ts             # Custom World con multi-browser support
│       ├── browserFactory.ts    # Factory Pattern para creación de navegadores
│       └── hooks.ts             # Before/After hooks
├── database/                    # Scripts SQL (PostgreSQL 15)
│   ├── 01_schema.sql           # Creación de tablas
│   ├── 02_data.sql             # Datos de prueba
│   ├── query1_clientes_sucursal_norte.sql
│   ├── query2_clientes_por_sucursal.sql
│   ├── query3_productos_medellin_no_bogota.sql
│   ├── query4_clientes_mas_2_productos.sql
│   └── query5_ultima_visita_cliente.sql
├── reports/                     # Reportes generados
│   ├── screenshots/            # Screenshots de fallos
│   ├── videos/                 # Videos de ejecución
│   └── cucumber-report.html    # Reporte HTML
├── cucumber.js                  # Configuración de Cucumber
├── tsconfig.json               # Configuración de TypeScript
├── package.json                # Dependencias y scripts
├── docker-compose.yml          # Docker para PostgreSQL
├── run-queries.bat             # Script Windows para ejecutar queries
└── run-queries.sh              # Script Linux/Mac para ejecutar queries
```

## 🎯 Escenarios Implementados

### 1. Happy Path (@smoke @critical)
- Login válido con `standard_user`
- Agregar 1 producto al carrito
- Completar checkout hasta confirmación
- Validar mensaje: "Thank you for your order!"

### 2. Login Fallido (@negative @regression)
- Intento de login con `locked_out_user`
- Validación de mensaje de error exacto

### 3. Data Driven (@regression)
- Scenario Outline con 3 usuarios:
  - `standard_user`
  - `problem_user`
  - `performance_glitch_user`
- Login + agregar producto al carrito
- Validar badge del carrito

## 🗄️ Base de Datos SQL

### PostgreSQL 15

La carpeta `database/` contiene:

1. **01_schema.sql**: Creación de esquema y tablas
2. **02_data.sql**: Población de datos (10+ registros por tabla)
3. **5 Queries requeridos**:
   - Query 1: Clientes que visitaron "Sucursal Norte" en el último mes
   - Query 2: Cantidad de clientes distintos por sucursal (DESC)
   - Query 3: Productos en Medellín pero NO en Bogotá
   - Query 4: Clientes inscritos en más de 2 productos
   - Query 5: Última visita de cada cliente (o "Sin visitas")

### 🐳 Opción 1: Ejecutar con Docker (Recomendado)

**Windows:**
```bash
run-queries.bat
```

**Linux/Mac:**
```bash
chmod +x run-queries.sh
./run-queries.sh
```

Esto iniciará PostgreSQL en Docker y ejecutará automáticamente todos los scripts SQL.

**O manualmente:**
```bash
docker-compose up -d
docker exec -it saucedemo-db psql -U postgres -d gym_spa_db
```

### Opción 2: PostgreSQL Local

```bash
# Conectar a PostgreSQL
psql -U postgres

# Crear base de datos
CREATE DATABASE gym_spa_db;
\c gym_spa_db

# Ejecutar scripts
\i database/01_schema.sql
\i database/02_data.sql

# Ejecutar queries
\i database/query1_clientes_sucursal_norte.sql
\i database/query2_clientes_por_sucursal.sql
\i database/query3_productos_medellin_no_bogota.sql
\i database/query4_clientes_mas_2_productos.sql
\i database/query5_ultima_visita_cliente.sql
```

## ✨ Características

- ✅ **TypeScript Estricto**: Tipado completo en todos los componentes
- ✅ **Page Object Model**: Arquitectura escalable y mantenible
- ✅ **Factory Pattern**: Creación de navegadores con patrón Factory
- ✅ **Multi-Browser Support**: Chrome, Firefox, Edge, WebKit (Safari)
- ✅ **Cross-Platform CI/CD**: Tests en Ubuntu, Windows y macOS
- ✅ **Parallel Execution**: Ejecución paralela de tests en múltiples navegadores
- ✅ **Headless Mode**: Control dinámico de modo headless/headed
- ✅ **Timeouts Globales**: Configurados en World (60s)
- ✅ **Video Recording**: Grabación automática organizada por navegador y ejecución
- ✅ **Screenshots on Failure**: Capturas automáticas organizadas por navegador
- ✅ **HTML Reports**: Reportes de Cucumber en formato HTML
- ✅ **Selectores Robustos**: Uso de data-test attributes
- ✅ **Manejo de Redirecciones**: Login → Inventory
- ✅ **Sanitización de Nombres**: Archivos de screenshots limpios
- ✅ **SOLID Principles**: Código bien estructurado y mantenible

## 🧑💻 Tecnologías Utilizadas

- **Playwright** 1.58.2 - Automatización de navegador
- **Cucumber** 9.6.0 - BDD Framework
- **TypeScript** 5.7.3 - Lenguaje tipado
- **PostgreSQL** 15 - Base de datos relacional
- **Node.js** >= 18.x - Runtime de JavaScript

## 📝 Commits del Proyecto

El repositorio incluye historial de commits:

1. ✅ **Initial setup: Playwright + Cucumber + TypeScript configuration** - Configuración inicial del proyecto con dependencias y archivos base
2. ✅ **Implement login: Page Object Model + BDD steps + multi-browser support** - Implementación de login con POM, Factory Pattern y soporte multi-navegador
3. ✅ **Implement cart and checkout: Complete E2E shopping flow** - Implementación completa del flujo de carrito y checkout
4. ✅ **Add CI/CD: GitHub Actions with multi-browser and multi-OS support** - Pipeline de CI/CD con ejecución en múltiples navegadores y sistemas operativos
5. ✅ **Add PostgreSQL database: Schema, data, 5 queries + Docker support** - Base de datos SQL con 5 queries requeridos y Docker Compose
6. ✅ **Add documentation: Complete README with setup and usage instructions** - Documentación completa del proyecto con instrucciones de instalación y uso

## 📄 Licencia

ISC

## 👤 Autor

Miguel Ángel Rodríguez Pacheco

---

**Nota**: Este proyecto fue desarrollado como parte de una prueba técnica siguiendo las mejores prácticas de automatización E2E con Playwright + Cucumber.
