# Tiny Monte Carlo

- [Página en Wikipedia sobre el problema](https://en.wikipedia.org/wiki/Monte_Carlo_method_for_photon_transport)
- [Código original](https://omlc.org/software/mc/) de [Scott Prahl](https://omlc.org/~prahl/)

Trabajo practico de la materia optativa Computacion Paralela de la Licenciatura en Ciencias de la Computación.
Dictada en la Facultad de Matematica, Astronomia y Fisica de la Universidad Nacional de Cordoba, por Nicolas Wolovick.

- [Pagina de la materia (dictado 2020)](https://cs.famaf.unc.edu.ar/~nicolasw/Docencia/CP/2020/index.html)

El objetivo de este trabajo practico es tomar el [codigo](https://github.com/computacionparalela/tiny_mc) de un simulador de Monte Carlo para la dispersion de fotones y aplicar diferentes tecnicas de optimizacion.

En el repositorio se encuentra la ultima version del codigo optimizado, junto con una release por cada una de las entregas realizadas con el codigo correspondiente a cada entrega.

## Lab 1

### Optimización secuencial

Cosas para hacer

- Encontrar una métrica de performance del problema:
  - Fotones por segundo, esta metrica es independiente del tamaño del problema.

La mejora encontrada en este laboratorio a nivel algoritmico fue el utilizar una generacion de numeros aleatorios mas eficiente que la provista por la libreria estandar de C. 

Toda otra optimizacion conseguida es a nivel de compilador (gcc, clang y icc).

## Lab 2

### Vectorización

El objetivo de este lavoratorio es intentar optimizar el codigo utilizando instrucciones SIMD. 

Para esto utilizamos las intstruciones de AVX2, que nos permiten operar con 256 bits a la vez. (8 fotones de 32 bits a la vez)

## Lab 3

### Paralelixzación con OpenMP

Intentar obtener una mejora de performance con directivas OpenMP.

- Entregar graficas para el tamaño del problema 128K fotones cons eries para distintas **cantidades de hilos**.
  - Comparar contra la mejor implemetación obtenida anteriormente (lab2)
  - **Eficiencia** respecto a la **mejor** version de un hilo disponible. (No necesariamente OMP_NUM_THREADS=1)
- **Roofline** de la configutacion más veloz obtenida.
