# 🛒 RetailOps: Sistema Automático de Alertas de Reposición de Inventario

![SQL Server](https://img.shields.io/badge/SQL_Server-CC2927?style=for-the-badge&logo=microsoft-sql-server&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![Pandas](https://img.shields.io/badge/Pandas-150458?style=for-the-badge&logo=pandas&logoColor=white)
![Power BI](https://img.shields.io/badge/Power_BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)

## 📌 Resumen Ejecutivo
Este proyecto es un pipeline de datos (ETL) de extremo a extremo diseñado para optimizar el flujo logístico entre el almacén y el piso de ventas en el sector retail. Convierte datos transaccionales crudos en un sistema de alertas tempranas, reduciendo los quiebres de stock en góndola mediante el cálculo dinámico de los **Días de Cobertura de Inventario** de cada SKU.

## 🎯 El Problema de Negocio
En la operación física de un supermercado, la reposición de mercadería a menudo se basa en la intuición visual o en reportes estáticos diarios. Esto genera dos cuellos de botella críticos:
1. **Quiebres de stock en piso:** Productos de alta rotación se agotan en góndola aunque haya stock disponible en la trastienda, resultando en ventas perdidas.
2. **Ineficiencia operativa:** Los operadores de almacén pierden tiempo buscando qué pallets priorizar durante el cierre de tienda o al inicio del turno.

**La Solución:** Un modelo analítico que calcula la velocidad de venta diaria por producto y la cruza con el stock físico actual, indicando exactamente qué SKUs deben moverse a tienda hoy.

## 🏗️ Arquitectura del Proyecto

El flujo de trabajo simula un entorno de producción corporativo:

1. **Extracción (SQL Server):** Modelado de datos relacional (Star Schema) y consultas optimizadas usando CTEs y funciones de agregación para resumir más de 100,000 registros transaccionales.
2. **Transformación (Python):** Script de lógica de negocio usando `pandas` y `numpy` para calcular métricas operativas y asignar estados de alerta sin saturar el motor de base de datos.
3. **Visualización (Power BI):** Dashboard táctico diseñado bajo principios de UX/UI para consumo rápido en dispositivos móviles/tablets por parte de jefes de pasillo.

## ⚙️ Metodología y Desarrollo

### 1. Base de Datos y Extracción (SQL)
* Implementación de reglas de integridad referencial (`PK`, `FK`) y restricciones lógicas (`CHECK` de valores positivos, `DEFAULT GETDATE()`).
* Creación de un script `SELECT` avanzado para calcular el promedio de venta histórica, manejando excepciones mediante `LEFT JOIN` y `COALESCE` para auditar productos sin historial de ventas.

### 2. Motor de Lógica (Python ETL)
* Conexión a la base de datos vía `pyodbc`.
* Implementación de lógica vectorial con `np.where` y `np.select` para clasificar el inventario:
  * 🔴 **Crítico:** <= 3 días de cobertura (Prioridad de reposición inmediata).
  * 🟢 **Saludable:** 4 a 15 días de cobertura.
  * 🟡 **Sobre-stock:** > 15 días de cobertura (Riesgo de merma o capital inmovilizado).

### 3. Dashboard Operativo (Power BI)
<img width="1265" height="704" alt="image" src="https://github.com/user-attachments/assets/0abfb7e7-3966-4488-96bb-2d5fa1a8e12f" />
* Diseño orientado a la acción: Ordenamiento condicional de menor a mayor en días de inventario.
* KPIs enfocados: Conteo inmediato de "SKUs Críticos" para enfocar el esfuerzo del equipo logístico desde el minuto uno del turno.

## 💡 Insights y Posible Impacto
Al aplicar este modelo a operaciones logísticas reales, una cadena de retail puede:
* **Reducir la pérdida de ventas (Lost Sales):** Al priorizar la reposición de los productos en estado "Crítico" antes de los picos de demanda del día.
* **Optimizar horas-hombre:** Transformar la reposición ciega en una ruta de trabajo dirigida por datos.

## 👨‍💻 Autor
**Jardiel Jesús Damian Quintana**
* [LinkedIn](https://www.linkedin.com/in/jardieldamian/)
* [GitHub](https://github.com/JesusDamian899)
