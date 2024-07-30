
# Guía para la Instalación de RStudio en el CCAD en sólo 10 pasos

Esta guía te ayudará a instalar RStudio en el cluster de computadoras del CCAD y a configurar una interfaz gráfica en tu computadora.

## Paso 1: Iniciar sesión en el nodo Jupyter

1. Abre una terminal en tu computadora.
2. Conéctate al nodo Jupyter usando SSH con el siguiente comando:
```bash
ssh <usuario>@jupyter.ccad.unc.edu.ar
```
## Paso 2: Instalar el gestor de entornos micromamba

1. Ejecuta el siguiente comando para instalar micromamba, aceptando opciones por defecto:
```bash
"${SHELL}" <(curl -L micro.mamba.pm/install.sh)
```
2. Recarga tu archivo .bashrc para aplicar los cambios:
```bash
source .bashrc
```

## Paso 3: Verificar la instalación de micromamba

1. Para comprobar que micromamba está instalado correctamente, ejecuta:
```bash
micromamba
```
2. Para obtener información sobre la instalación de micromamba, ejecuta:
```bash
micromamba info
```

## Paso 3: Verificar la instalación de micromamba

1. Para comprobar que micromamba está instalado correctamente, ejecuta:
```bash
micromamba
```
2. Para obtener información sobre la instalación de micromamba, ejecuta:
```bash
micromamba info
```

## Paso 4: Crear el ambiente para RStudio

1. Crea un nuevo entorno llamado `rstudio` con el siguiente comando:
```bash
micromamba create --name rstudio
```

## Paso 5: Activar el entorno

1. Activa el entorno `rstudio` con el siguiente comando:
```bash
micromamba activate rstudio
```

## Paso 6: Instalar R

1. Dentro del entorno activado, instala R desde conda-forge con el siguiente comando:
```bash
micromamba install conda-forge::r-base
```

## Paso 7: Clonar el repositorio de rstudio-server

1. Clona el repositorio de rstudio-server usando git con el siguiente comando:
```bash
git clone https://github.com/grst/rstudio-server-conda.git
```
Para conocer más sobre este proyecto puedes leer [Aquí](https://github.com/grst/rstudio-server-conda)

## Paso 8: Descargar y ejecutar el script run_rstudio.sh

1. Descarga el script `run_rstudio.sh` en tu directorio `$HOME`.
```bash
wget https://raw.githubusercontent.com/daniloceschin/RStudio_in_CCAD/main/run_rstudio.sh
```

3. Ejecuta el script con el siguiente comando:
```bash
bash run_rstudio.sh
```
## Paso 9: Seguir las instrucciones impresas en el terminal

1. Una vez ejecutado el script, sigue las instrucciones que aparecerán en la terminal para completar la configuración y puesta en marcha de RStudio.

## Paso 10: Iniciar RStudio en otras instancias
1. Una vez realizado este tutorial, para iniciar nuevas sesiones de RStudio en tu computadora sólo tienes que ejecutar el script `run_rstudio.sh`
```bash
bash run_rstudio.sh
```
