📌 Descripción General del Proyecto

La Herramienta de Seguimiento de Egresados es un sistema web diseñado para gestionar y mantener actualizada la información de los egresados de la facultad. Su propósito es fortalecer el vínculo entre la universidad, sus egresados y las empresas, integrando módulos de empleo, foros, eventos y noticias en una sola plataforma centralizada.

--------------------------------------------------------------------------------------

🎯 Objetivos

Mantener actualizada la información de los egresados.

Proveer herramientas de empleabilidad y networking.

Fortalecer el vínculo universidad–egresado.

Centralizar datos dispersos en un sistema único y seguro.

--------------------------------------------------------------------------------------

⚠️ Problemática a Solucionar

Falta de contacto con los egresados después de graduarse.

Ausencia de estadísticas de empleabilidad.

Información fragmentada en redes sociales o bases incompletas.

No existe un espacio virtual que unifique egresados, empresas y facultad.

--------------------------------------------------------------------------------------

🧩 Alcance del Sistema

Registro y edición de perfil de egresados.

Bolsa de empleo con filtros avanzados.

Módulo de eventos con inscripción.

Foros por categorías.

Panel de noticias institucionales.

Cumplimiento de normas de protección de datos (Ley 1581 de 2012).

--------------------------------------------------------------------------------------

👥 Roles del Sistema

Administrador: gestiona usuarios, noticias, eventos y ofertas de empleo.

Egresado: actualiza su perfil, participa en foros, se inscribe a eventos y se postula a ofertas.

Empresa: publica vacantes laborales (acceso controlado).

--------------------------------------------------------------------------------------

🛠️ Tecnologías Utilizadas

Backend: C#

Frontend: ASP.NET Web Forms

Base de Datos: SQL Server

Arquitectura: Proyecto en capas (Common, DataAccess, LogicBusiness, Presentation)

IDE: Visual Studio

--------------------------------------------------------------------------------------

🗃️ Estructura 

El proyecto está organizado en 4 capas principales:

Common          → Entidades y atributos compartidos

DataAccess      → Conexión, repositorios y migraciones  

LogicBusiness   → Servicios, seguridad y lógica del negocio  

Presentation    → Interfaz web (páginas, controles, scripts, estilos)

--------------------------------------------------------------------------------------

🛠️ Pasos de Instalación / Configuración

- Clonar el repositorio.

Descargar o clonar el proyecto desde el repositorio oficial.

- Restaurar paquetes NuGet.

Abrir la solución en Visual Studio y restaurar todos los paquetes necesarios.

- Configurar la cadena de conexión en App.config / Web.config.

- Actualizar la conexión a la base de datos en los proyectos DataAccess y Presentation.

- Crear la base de datos ejecutando la migración.

Abrir la Package Manager Console, seleccionar DataAccess como proyecto predeterminado y ejecutar:

update-database

- Configurar el proyecto de inicio.

Establecer Presentation como proyecto de inicio y seleccionar Start/Login.aspx como página inicial.

- Ejecutar el proyecto desde Visual Studio.

- Ejecutar con IIS Express para iniciar la aplicación.

--------------------------------------------------------------------------------------

Base de datos en SQL Server con tablas como:

Egresados, Categorías, OfertasEmpleo, Postulaciones, Eventos, Foros, Usuarios, etc.
