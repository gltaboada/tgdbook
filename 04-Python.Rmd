# Python {#introPython}

Python es un lenguaje de programación de alto nivel, interpretado y de propósito general.  
Se caracteriza por ser legible, versátil y contar con una gran comunidad de usuarios, lo que lo hace ideal tanto para principiantes como para profesionales.

En este documento se presenta una introducción básica al lenguaje, su sintaxis esencial y algunas de sus aplicaciones más comunes.

Enlaces de interés:

- Intérpretes de Python online
  - [Online-Python](https://www.online-python.com/)
  - [Programiz](https://www.programiz.com/python-programming/online-compiler/)
  - [Python Online](https://pythononline.net/)
- Tutoriales
  - [Oficial 3.14](https://docs.python.org/es/3/tutorial/)
  - [J2Logo (modular)](https://j2logo.com/python/tutorial/)
  - [Python España (listado de cursos)](https://es.python.org/aprende-python/)
- IDEs
  - [pyCharm](https://www.jetbrains.com/es-es/pycharm/download)
  - [Visual Studio Code](https://code.visualstudio.com/)
  
### Instalación

Para instalar Python, puedes descargar la versión más reciente desde:

- https://www.python.org/downloads/

En muchos sistemas Linux y macOS, Python ya viene instalado por defecto.

## Introducción a Python

### ¿Qué es Python?

Python es un lenguaje creado por Guido van Rossum en 1991.  
Se destaca por:

- **Sintaxis clara y legible**
- **Tipado dinámico**
- **Amplia biblioteca estándar**
- **Gran ecosistema de paquetes**
- **Multiplataforma**

Python puede ejecutarse de diferentes maneras según la necesidad:
- Desde la **línea de comandos**

```bash
python -c "print('Hola desde Python')"
```

- En modo **interactivo**

Este entorno interactivo se conoce como **REPL** (Read, Eval, Print, Loop)

```bash
$ python3
Python 3.13.5 (main, Jun 25 2025, 18:55:22) [GCC 14.2.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> 
```

Ahora se pueden escribir comandos:

```python-repl
>>> 2 + 2
4
>>> print("Hola")
Hola
>>> exit()
```

- Ejecutando **archivos `.py`**

```bash
$ python archivo.py
```

- Usando **entornos interactivos** como IPython
- Empleando herramientas para generar una versión "compilada"

### Primeros pasos: Hola Mundo

Podemos comenzar escribiendo nuestro primer programa:

```python
print("Hola mundo")
```

Para ejecutarlo desde la terminal

python mi_programa.py

También es posible utilizarlo, al igual que R, de forma interactiva:

### Sintáxis básica

Los comentarios se escriben con `#`:

```python
# Esto es un comentario
print("Hola")
```

#### Variables y Tipos de Datos

Python no requiere declarar el tipo de las variables (tipado dinámico):

```python
x = 10            # Entero (int / long)
pi = 3.1416       # Flotante (float / double)
nombre = "Ana"    # Cadena (string)
es_valido = True  # Booleano
```

Para mirar cuál es el tipo de dato de una variable se usa la función `type`:

```python
print(type(x))
print(type(pi))
print(type(nombre))
print(type(es_valido))
```

Para solicitar una entrada de texto al usuario se usa la instrucción `input`:

```python
nombre = input("Introduce tu nombre: ")
```

IMPORTANTE: `input` siempre devuelve un string aunque se introduzca un número.
Si se quiere convertir a otro tipo de dato hay que hacerlo explícitamente:

```python
edad = int(input("Edad: "))
```

Para imprimir un string, se puede formatear la salida.
Indicando una "f" antes del string se indica que es una salida formateada
y se pueden indicar variables entre corchetes "{ }":

```python
print(f"Nombre: {nombre}, Edad: {edad}")
print(f"{precio:.2f}"
```

Una variante más antigua es con el método format sobre el string:

```python
print("Nombre: {}, Edad: {}".format(nombre, edad))
print("Nombre: {n}, Edad: {e}".format(n=nombre, e=edad))
```

Se puede usar un formato similar al de C (aún más antiguo)

```python
print("Nombre: %s, Edad: %d" % (nombre, edad))
```

Y también concatenar strings:

```python
print("Hola " + nombre)
```

#### Tuplas

Una **tupla** es una colección **ordenada e inmutable** de elementos.

- Mantienen el **orden** de inserción.
- **No se pueden modificar** (inmutables).
- Pueden contener valores de **distintos tipos**.
- Se usan frecuentemente para representar **filas** o **registros de datos**.
- Se crean con paréntesis `( )`.

```python
tupla = ("Ana", 30, "Madrid")
print(tupla[0])   # Acceso por índice
```

La tupla es útil cuando necesitas una estructura fija que no cambiará (por ejemplo, una fila SQL).

El tipo más cercano en R es un vector (`c(1, 2, 3)`) si los datos son homogéneos o una lista (`list("Ana", 30, "Madrid")`) si son heterogéneos.

#### Listas

Una **lista** es una colección **ordenada y mutable**.

- Mantienen el **orden**.
- **Sí pueden modificarse**: agregar, borrar, reordenar, reemplazar elementos.
- Pueden contener cualquier tipo de dato.
- Se crean con corchetes `[ ]`.

```python
numeros = [1, 2, 3, 4]
numeros.append(5)
print(numeros)

numeros[0] = 5     # la lista queda: [5,2,3,4] 
numeros.append(17) # ahora la lista queda [5,2,3,4,17]
print(numeros)
```

La lista es útil cuando la colección va a crecer, modificarse o reordenarse.

#### Diccionarios

Un **diccionario** es una colección **no ordenada** (en versiones modernas, conserva el orden de inserción) de pares **clave-valor**.

- Cada elemento tiene una **clave única**.
- Permiten acceso muy rápido a los valores mediante la clave.
- Se usan para representar **datos estructurados**, como registros con nombre.
- Se crean con llaves `{ }`.

```python
persona = {"nombre": "Luis", "edad": 30}
print(persona["nombre"])
persona["edad"] = 31
```

El diccionario es útil cuando necesitas asociar valores a nombres o claves.
También es interesante para acceder a filas SQL por nombre de atributo.

El tipo más cercano en R sería una lista nombrada: `list(nombre = "Luis", edad = 30)`,
o bien un environment:

```
env <- new.env()
env$nombre <- "Luis"
env$edad <- 30
```

También es similar un dataframe

```
df <- data.frame(nombre = "Luis", edad = 30)
```

#### Operadores

* Operadores lógicos:

| Operación | Python | R | C |
|-----------|--------|----|----|
| AND lógico | `and` | `&` (element-wise), `&&` (control-flow) | `&&` |
| OR lógico | `or`  | `|` (element-wise), `||` (control-flow) | `||` |
| NOT lógico | `not` | `!` | `!` |

* Operadores bitwise:

| Operación | Python | R | C |
|-----------|--------|----|----|
| AND bitwise | `&` | `bitwAnd(a,b)` | `&` |
| OR bitwise | `|` | `bitwOr(a,b)` | `|` |
| XOR bitwise | `^` | `bitwXor(a,b)` | `^` |
| NOT bitwise | `~` | `bitwNot(a)` | `~` |
| Shift izquierda | `<<` | `bitwShiftL(a,n)` | `<<` |
| Shift derecha | `>>` | `bitwShiftR(a,n)` | `>>` |


#### Indentación

Python usa la indentación para definir bloques de código.
Esto es fundamental: si la indentación es incorrecta, el código no funciona.

La convención es usar 4 espacios por nivel (mejor que usar tabs).

```python
if x > 5:
    print("x es mayor que 5")
    print("Esto sigue dentro del bloque")
print("Esto ya está fuera del bloque")
```

Ejemplo **incorrecto** (producirá un error):

```python
if x > 5:
  print("Error por mezclar espacios")
    print("Indentación inconsistente")
```

#### Estructuras de control

* Condicionales

```python
edad = 18

if edad >= 18:
    print("Mayor de edad")
else:
    print("Menor de edad")
```

* Bucle `for`

```python
for i in range(5):
    print(i)
```

* Bucle `while`

```python
contador = 0
while contador < 5:
    print(contador)
    contador += 1
```

#### Funciones

```python
def saludar(nombre):
    return f"Hola, {nombre}"

print(saludar("María"))
```

#### Errores Comunes de Sintaxis

* Olvidar los dos puntos (:) al iniciar un bloque
* Mezclar tabs y espacios
* Indentación incorrecta

### Librerías populares

Python cuenta con miles de bibliotecas.
Para usar una biblioteca se utiliza "**import** ...",
de forma análoga a "**library**(...)" en R.

```python
import math
print(math.sqrt(16))
```

Algunas destacadas:

#### 🔢 Ciencia de Datos

- **NumPy**: Cálculo numérico y manejo de arreglos multidimensionales.
- **Pandas**: Análisis y manipulación de datos mediante DataFrames.
- **SciPy**: Funciones científicas y matemáticas avanzadas.
- **Matplotlib**: Visualización básica y clásica.
- **Seaborn**: Visualización estadística de alto nivel.
- **Plotly**: Gráficos interactivos y dinámicos.
- **Statsmodels**: Modelos estadísticos y econometría.

---

#### 🤖 Machine Learning e Inteligencia Artificial

- **scikit-learn**: Algoritmos tradicionales de machine learning.
- **TensorFlow**: Deep learning desarrollado por Google.
- **PyTorch**: Deep learning desarrollado por Meta.
- **Keras**: API de alto nivel para redes neuronales.
- **XGBoost**: Algoritmo de gradient boosting optimizado.
- **LightGBM**: Boosting rápido para grandes datasets.
- **CatBoost**: Boosting especializado en variables categóricas.

---

#### 🧠 Procesamiento del Lenguaje Natural (NLP)

- **NLTK**: Procesamiento de texto tradicional.
- **spaCy**: NLP industrial rápido y eficiente.
- **Transformers (Hugging Face)**: Modelos modernos como BERT, GPT, etc.
- **Gensim**: Modelado de tópicos y embeddings semánticos.

---

#### 🌐 Desarrollo Web

- **Django**: Framework completo para aplicaciones web.
- **Flask**: Microframework web ligero y flexible.
- **FastAPI**: Framework moderno y rápido para APIs (asíncrono).
- **Bottle**: Alternativa aún más ligera a Flask.

---

#### 🛠️ Utilidades y Herramientas

- **Requests**: Manejo de peticiones HTTP.
- **BeautifulSoup**: Análisis y extracción de datos HTML.
- **Selenium**: Automatización de navegadores web.
- **PyTest**: Framework de testing en Python.
- **Pillow (PIL)**: Manipulación de imágenes.
- **Click**: Creación de interfaces de línea de comandos.

---

#### 🧱 Desarrollo y Arquitectura

- **SQLAlchemy**: ORM y manejo avanzado de bases de datos.
- **Pydantic**: Validación de datos basada en tipos.
- **Celery**: Ejecución de tareas distribuidas.
- **Redis-py**: Cliente de Python para Redis.

---

#### 🧪 Data Engineering y Big Data

- **PySpark**: Uso de Apache Spark desde Python.
- **Dask**: Computación distribuida para conjuntos grandes de datos.
- **Vaex**: Manipulación de datos grandes sin cargarlos completamente en memoria.
- **Ray**: Framework para computación distribuida y ML escalable.

---

#### 📦 Librerías Estándar Muy Usadas

- **os**: Interacción con el sistema operativo.
- **sys**: Acceso directo al intérprete de Python.
- **json**: Lectura y escritura de archivos JSON.
- **re**: Manejo de expresiones regulares.
- **datetime**: Manejo de fechas y horas.
- **subprocess**: Ejecución de comandos externos.

## Python y SQLite

`sqlite3` es un módulo estándar de Python que permite:

- Conectarse a una base de datos SQLite
- Ejecutar consultas SQL
- Gestionar transacciones (`commit`, `rollback`)
- Recibir datos como tuplas o diccionarios
- Crear tablas, insertar, actualizar y borrar datos


```python
import sqlite3

conn = sqlite3.connect("chinook.db")
cursor = conn.cursor()
```

`conn` es un *objeto conexión* análogo al que se usa en R.
Representa un canal abierto entre tu programa y el archivo de base de datos.

Sirve para:

- Iniciar y finalizar transacciones
- Ejecutar consultas
- Confirmar cambios (`commit`)
- Revertir cambios (`rollback`)
- Crear cursores
- Cerrar la base de datos

Para ejecutar consultas se obtiene un **cursor** a partir de esa conexión.
El cursor es uno de los conceptos más importantes cuando trabajas con cualquier base de datos desde Python.
Un cursor es un objeto intermediario entre el programa y la base de datos.
Se usa para:

* enviar consultas SQL a la base de datos
* recibir resultados de las consultas
* iterar sobre las filas devueltas
* ejecutar operaciones como INSERT, UPDATE, DELETE, CREATE TABLE

En otras palabras, es como una “pluma” que escribe y lee en la base de datos a través de la conexión.

A diferencia de R, Python separa estos dos conceptos:

* **conexión (conn)**: maneja transacciones
* **cursor**: ejecuta consultas y maneja resultados

Cada cursor mantiene un “estado”

Cuando haces un `SELECT`, el cursor “apunta” a la posición actual dentro del conjunto de resultados.

Los cursores no necesitan cerrarse explícitamente, pero es buena práctica hacerlo:

```python
cursor.close()
```

### Operaciones de inserción, borrado o modificación de datos

* Igual que en R, se utiliza el método **execute** del objeto python
* Python inicia transacciones automáticamente en estas operaciones
* Por legibilidad normalmente las consultas se escriben en varias líneas.
  Para escrbir cadenas multilínea se usa `"""` en lugar de `"`.
  
```python
cursor.execute("""
CREATE TABLE IF NOT EXISTS usuarios (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    edad INTEGER
)
""")

cursor.executemany(
    "INSERT INTO usuarios (nombre, edad) VALUES (?, ?)",
    [("Luis", 25), ("María", 22), ("Pedro", 40)]
)

cursor.execute(
    "UPDATE usuarios SET edad = ? WHERE nombre = ?",
    (31, "Ana")
)

cursor.execute("DELETE FROM usuarios WHERE edad < ?", (30,))

conn.commit()
```

* Para ejecutar varias sentencias a la vez, en lugar del método `execute` se usa `executescript`

```python
cursor.executescript("""
    INSERT INTO usuarios (nombre, edad) VALUES ('Roi', 20);
    INSERT INTO usuarios (nombre, edad) VALUES ('Sara', 33);
""")
conn.commit()
```

### Operaciones de consulta

Cuando se ejecuta una consulta, el cursor apunta a la primera fila de resultado.
Para obtener los datos hay 3 métodos útiles:

* `fetchone()`: Devuelve una fila cada vez. Cuando ya no quedan filas, devuelve `None`.
* `fetchall()`: Devuelve todas las filas como una lista. Si la consulta devuelve muchas filas, es mejor optar por una de las otras opciones.
* `fetchmany(n)`: Devuelve una lista con un bloque de como máximo **n** filas. Si quedan menos, devuelve un bloque menor. Si no quedan filas, devuelve una lista vacía `[]`. 
* `fetchmany()`: Si no se utiliza el parámetro n, se usa el tamaño por defecto del cursor (`cursor.arraysize`), que si no se modifica tiene valor 1.

Ejemplo iterando sobre el cursor:

```python
cursor.execute("SELECT * FROM Artist")
filas = cursor.fetchall()

fila = cursor.fetchone()
while fila is not None:
    print(fila)
    fila = cursor.fetchone()
```

Ejemplo iterando sobre los resultados:

```python
cursor.execute("SELECT * FROM Artist")
filas = cursor.fetchall()

for fila in filas:
    print(fila)
```

#### Seleccionar una fila

```python
cursor.execute("SELECT * FROM usuarios WHERE id = ?", (1,))
fila = cursor.fetchone()
print(fila)
```

El valor que devuelve es de tipo tupla.
Es una **estructura inmutable**, rápida y ligera que garantiza que los datos no se modifiquen accidentalmente.
Refleja una fila tal cual la devuelve SQLite.

Se puede acceder a los campos por índices:

```python
id = fila[0]
nombre = fila[1]
edad = fila[2]
```

Se puede desempaquetar la tupla:

```python
id, nombre, edad = fila
print(nombre)
```

Si la consulta devuelve un conjunto de tuplas, se puede recorrer en bucle:

```python
cursor.execute("SELECT id, nombre, edad FROM usuarios")

for fila in cursor.fetchall():
    print(f"ID={fila[0]}, Nombre={fila[1]}, Edad={fila[2]}")
```

Se puede convertir en lista si se necesita modificar:

```python
fila_lista = list(fila)
fila_lista[1] = "NuevoNombre"
```

O en diccionario para trabajar con mayor comodidad:

```python
columnas = [desc[0] for desc in cursor.description]
dic = dict(zip(columnas, fila))
print(dic)
```


#### Devolver resultados como diccionarios

También se puede cambiar el tipo devuelto para que sea un diccionario en lugar de una tupla y evitar la conversión explícita:

```python
conn.row_factory = sqlite3.Row
cursor = conn.cursor()

cursor.execute("SELECT * FROM usuarios")
for fila in cursor.fetchall():
    print(dict(fila))
```

De esta forma también se puede acceder a los campos de una forma más human-readable:

```python
cursor.execute("SELECT * FROM usuarios")
for fila in cursor.fetchall():
    print(fila["nombre"])
```

### Usar SQLite con Pandas

```python
import pandas as pd

df = pd.read_sql_query("SELECT * FROM usuarios", conn)
print(df)
```

## Context Manager

En Python existe una construcción muy útil llamada **context manager**, que se utiliza a través de la palabra clave `with`.  
El objetivo de un context manager es **gestionar recursos de forma automática y segura**, garantizando que se liberen correctamente incluso si ocurre un error durante su uso.

Este mecanismo se basa en entrar en un "contexto" con `__enter__()` y salir de él con `__exit__()`, lo cual permite automatizar tareas como:

- cerrar archivos
- liberar conexiones
- realizar `commit` o `rollback` en bases de datos
- liberar bloqueos de hilos
- limpiar recursos temporales

Sin un context manager, el programador debe encargarse de abrir y cerrar recursos manualmente.  
Por ejemplo, al trabajar con archivos:

```python
f = open("datos.txt", "r")
contenido = f.read()
f.close()
```

Si ocurre un error entre `open()` y `close()`, el archivo podría quedar **abierto**, generando fugas de recursos o comportamientos inesperados.

El uso de `with` garantiza que el recurso se cierre automáticamente cuando termina el bloque, incluso si ocurre una excepción.

```python
with open("datos.txt", "r") as f:
    contenido = f.read()
```

Aquí:

- se abre el archivo
- se ejecuta el bloque indentado
- al salir del bloque, Python llama automáticamente a `f.close()`

Esto hace que el código sea más **seguro**, **limpio** y **fácil de leer**.

```python
with open("datos.txt", "w") as f:
    f.write("Ejemplo de context manager")
```

En este caso, `open()` devuelve un objeto archivo que actúa como context manager.  
Al finalizar el bloque, Python ejecuta automáticamente el cierre del archivo.

### Ejemplo: conexión SQLite

Las conexiones SQLite también son context managers.  
El siguiente código garantiza un `commit()` si todo va bien, o un `rollback()` si hay errores:

```python
import sqlite3

with sqlite3.connect("personas.sqlite") as conn:
    cursor = conn.cursor()
    cursor.execute("INSERT INTO usuarios(nombre) VALUES ('Ana')")
```

## CSV en python

### La librería `csv`

La librería `csv` viene incluida en Python, por lo que no requiere instalación.

#### Leer un CSV con `csv.reader()`

```python
import csv

with open("datos.csv", newline='', encoding="utf-8") as f:
    reader = csv.reader(f)
    for fila in reader:
        print(fila)
```

#### Leer un CSV con cabeceras: `csv.DictReader()`

```python
import csv

with open("datos.csv", newline='', encoding="utf-8") as f:
    reader = csv.DictReader(f)
    for fila in reader:
        print(fila["Nombre"], fila["Edad"])
```

#### Escribir un CSV con `csv.writer()`

```python
import csv

datos = [
    ["Nombre", "Edad"],
    ["Ana", 40],
    ["Diego", 41]
]

with open("salida.csv", "w", newline='', encoding="utf-8") as f:
    writer = csv.writer(f)
    writer.writerows(datos)
```*

#### Escribir un CSV con cabeceras: `csv.DictWriter()`

```python
import csv

personas = [
    {"Nombre": "Ana", "Edad": 40},
    {"Nombre": "Diego", "Edad": 41}
]

with open("salida.csv", "w", newline='', encoding="utf-8") as f:
    writer = csv.DictWriter(f, fieldnames=["Nombre", "Edad"])
    writer.writeheader()
    writer.writerows(personas)
```


### Trabajar con CSV usando `pandas`

`pandas` es la librería más potente para análisis de datos en Python.

#### Leer un CSV

```python
import pandas as pd

df = pd.read_csv("datos.csv")
print(df.head())
```

#### Guardar un CSV

```python
df.to_csv("salida.csv", index=False)
```

#### Operaciones básicas

```python
df["Nombre"]                # Acceder a una columna
df["Edad"].mean()           # Media de una columna numérica
df[df["Edad"] > 30]         # Filtrar filas
```

### Insertar datos en SQLite a partir de CSV

```python
with open('venues.csv') as csvfile:
    reader = csv.DictReader(csvfile)
    for row in reader:
        cursor.execute('''
            INSERT INTO Venue (Name, Capacity, Street, Number, City)
            VALUES (?, ?, ?, ?, ?)
        ''', (row['Name'], row['Capacity'], row['Street'], row['Number'], row['City']))
```
       
A menudo un CSV contiene nombres en vez de IDs, por ejemplo:

```python
with open("concerts.csv") as f:
    reader = csv.DictReader(f)

    for row in reader:
        venue_name = row["Venue"].strip()

        # Buscar VenueId
        cur.execute("SELECT VenueId FROM Venue WHERE Name = ?", (venue_name,))
        result = cur.fetchone()

        if result is None:
            print("ERROR: No existe el Venue:", venue_name)
            continue

        venue_id = result[0]

        # Insertar en la tabla Concert
        cur.execute("""
            INSERT INTO Concert (ConcertId, VenueId, Name, Tickets, TicketsSold, Date)
            VALUES (?, ?, ?, ?, ?, ?)
        """, (
            int(row["ConcertId"]),
            venue_id,
            row["Name"],
            int(row["Tickets"]),
            int(row["TicketsSold"]),
            row["Date"]
        ))
```
