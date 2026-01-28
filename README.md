# ServerTimeSync

ServerTimeSync es una herramienta ligera para **Windows** diseñada para **ajustar automáticamente la zona horaria del sistema** según la ubicación de la máquina. Es ideal para servidores, VPS o PCs en entornos distribuidos, garantizando que la hora del sistema sea correcta sin intervención manual.

---

## Funcionamiento

- Detecta automáticamente la zona horaria usando la **IP pública de la máquina**.
- Convierte la zona horaria IANA (`Europe/Madrid`, `America/New_York`) a los nombres de zona válidos de **Windows** (`Romance Standard Time`, `Eastern Standard Time`, etc.).
- Funciona **offline** sin necesidad de instalar módulos externos.
- Incluye mensajes **debug opcionales** para verificar los pasos de detección y aplicación.
- Si no se puede detectar la zona automáticamente, hace un **fallback seguro** a la zona horaria actual del sistema.
- Requiere **ejecución como administrador** para poder cambiar la zona horaria.

---

## Uso recomendado

ServerTimeSync está pensado especialmente para:

- **Programación y desarrollo:** Mantener entornos consistentes con la hora correcta.
- **Automatización y deployments:** Ideal para scripts o instalaciones masivas donde se necesita sincronizar la hora.

### Ejemplo de salida:

[DEBUG] IANA timezone obtenida de IP: Europe/Madrid
[DEBUG] Mapeada a Windows TZ: Romance Standard Time
[DEBUG] Ajustando sistema a: Romance Standard Time


---

## Recomendaciones

- Ejecutar siempre **como administrador**.
- Compatible con Windows 10, 11 y Server 2016+.
- Para entornos en VPS, se recomienda habilitar acceso a internet para detectar la zona horaria mediante la IP, aunque también funciona con fallback offline.

## Servicios recomendados

### ColdHosting

Servidor de hosting profesional de alto rendimiento con más de **200
Tbps** de capacidad de red, optimizado específicamente para servidores
FiveM con **protección DDoS avanzada**.\
[Visita ColdHosting](https://coldhosting.com)

---

## Autor

Creado por [Sabaariiego](https://sabaariiego.dev/)  
