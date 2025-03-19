# Cosas para hacer

    Encontrar una métrica de performance del problema.
        Que sea comparable para cualquier tamaño del problema.
        Mejor performance para mayores valores, o sea mejor => arriba.
        Usualmente photons/ns, atoms/ns, cells/ns.
        Idealmente FLOPS/IPS si se puede calcular.

    Mejorar la performance cambiando cosas, por ejemplo:
        Compiladores. (GCC, Clang, Intel, NVIDIA/PGI?)
        Opciones de compilación, explorar mucho pero no a lo tonto.
        Mejoras algorítmicas y/o numéricas. (si hubiera, e.g. RNG)
        Optimizaciones de cálculos. (que no haga ya el compilador)
        Unrolling de loops y otras fuentes de ILP. (nuevamente, que no haga el compilador)
        Sistema de memoria: Hugepages y estrategias cache-aware. (altamente probable que no rindan hasta agregar paralelismo, ni para sistemas pequeños)
Hints

    Tomar decisiones sobre dónde mirar primero en el código haciendo profiling. (perf, VTune)

    Automatizar TODO, es una inversión para todo el cuatrimestre:
        Compilación.
        Tests para detectar rápido problemas en el código.
        Ejecución y medición de performance.
        Procesamiento de la salida del programa. (salida en CSV es fácil de ingerir)
        Generación de gráficas.
        
# Entrega

Presentación de los resultados en video subido privado a YouTube de <=5min.
Cada minuto de más, se descuenta un punto.

Cosas que si o si tienen que estar.

    Características del hardware y del software:

        CPU: modelo y velocidad.
            Poder de cómputo de un core medido con Empirical Roofline Toolkit o LINPACK.

        Memoria: capacidad, velocidad, cantidad de canales ocupados.
            Ancho de banda para un core medido con Empirical Roofline Toolkit o STREAM.

        Compiladores: nombres y versiones.
        Sistema Operativo: nombre, versión, arquitectura.

    Gráficas de scaling para la versión más rápida obtenida.
        Performance vs. tamaño del problema. (usualmente lin-log)
        No va a dar scaling lineal, hay que explorar tamaños encontrando relaciones con la jerarquía de memoria.

        https://www.youtube.com/watch?v=r-TLSBdHe1A

    Optimizaciones probadas y sus resultados.

        Explicación y mediciones que validen la explicación.
        Intentar medir las causas además de la performance.

## TODO

Metrica de performance del problema:

    Para este caso la metrica a utilizar que representara la performance de nuestra solucion sera la
    cantidad de fotones por segundo simulados. 

    Y el tamaño de nuestro problema esta representado por la cantidad de fotones a simular. 

Optimizaciones a realizar:

- Compilador: gcc con flags de optimización O3 y Ofast en busca de comparar como se comporta el compilador con diferentes flags de optimización.
- Algoritmo: Se busca mejorar la performance del algoritmo de simulación de fotones. Nuestro objetivo principal es optimizar la funcion `phonon` en `photon.c`.
  - Se busca mejorar la performance de la funcion `phonon` en `photon.c`
    - Intentar hacer loop unrolling
    - Dentro de la funcion utilizamos 3 llamados a funciones `rand()`, `logf()` y `sqrtf()`. TODO: Buscar si existen versiones mas optimizadas y medir el rendimiento.
    - Particularmente `rand()` se llama 4 veces por cada fotón, una independiente y las demas sujeta a condiciones. Se busca mejorar la performance de esta funcion.

- Memoria: pensar en mejorar la performance del sistema de memoria y cache. Teniendo en cuenta que el codigo trabaja sobre un arreglo de fotones y 2 arreglos de las `shells`.

## Casos de estudio

1. Base: Implementación original
2. Optimización 2: algoritmica y de memoria (loop unrolling, cache-aware)
3. Optimizacion 3: opt 2 + mejora en usos de librerias (rand, log, sqrt)
4. Optimizacion 4: opt 3 + flags de compilacion O3 y Ofast

Mediciones a tener en cuenta:

- Tamaño del problema vs performance (#fotones vs fotones/s)
  - Diferentes tamaños del problema implica intentar llevar la performance fuera de la cache y medir el impacto en la performance.
