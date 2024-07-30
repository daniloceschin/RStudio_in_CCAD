#!/bin/bash

. /etc/profile
source .bashrc
micromamba deactivate rstudio

# Ruta al binario de micromamba (ajusta según sea necesario)
MICROMAMBA_BIN="$HOME/.local/bin/micromamba"


# Nombre del entorno micromamba
CONTAINER_NAME="rstudio"

# Inicializar micromamba
eval "$($MICROMAMBA_BIN shell hook --shell=bash)"

# activar  ambiente rstudio
micromamba activate $CONTAINER_NAME

# verifica o crea el directorio data/
if [ ! -d data/ ] 
then
    mkdir -p data
    chmod 777 data/
fi

# verifica o crea directorio .config/rstudio
if [ ! -d .config/rstudio ]
then  
    mkdir .config/rstudio
    chmod 777 .config/rstudio
fi

# modifica linea en run_singularity.sh
if [ ! -e $HOME/rstudio-server-conda/singularity/sed.OK ]
then
sed -i 's/--bind \/data:\/data \\/--bind $HOME\/data:\/data \\/' $HOME/rstudio-server-conda/singularity/run_singularity.sh
touch $HOME/rstudio-server-conda/singularity/sed.OK
fi


# Buscar un puerto disponible
find_available_port() {
  for port in $(seq 8000 9000); do
    if ! (echo >/dev/tcp/localhost/$port) 2>/dev/null; then
      echo $port
      return
    fi
  done
  echo "No hay puertos disponibles en el rango 8000-9000."
  exit 1
}

PUERTO=$(find_available_port)

# Generar una contraseña aleatoria
generate_password() {
  echo $(openssl rand -base64 12)
}

PASS=$(generate_password)

# Definir usuario
USUARIO=`whoami`

# Definir los colores
ROJO='\033[0;31m'
VERDE='\033[0;32m'
BLUE='\033[0;34m'
AMARILLO='\033[0;33m'
NARANJA='\033[0;93m'
VIOLETA='\033[0;35m'
NC='\033[0m' # No Color

clear
# Imprimir instrucciones para el usuario
echo
echo
echo -e "${BLUE}################################################################################${NC}"
echo -e "${BLUE}################################################################################${NC}"
echo -e "${BLUE}################################################################################${NC}"
echo -e "######################################${AMARILLO}###${NC}#######################################"
echo -e "#####################################${AMARILLO}#####${NC}######################################"
echo -e "######################################${AMARILLO}###${NC}#######################################"
echo -e "${BLUE}################################################################################${NC}"
echo -e "${BLUE}################################################################################${NC}"
echo -e "${BLUE}################################################################################${NC}"
echo
echo
echo -e "${AMARILLO}     *. Inicie una nueva terminal y ejecute el siguiente comando: ${NC}"
echo "        ssh -L 9999:localhost:${PUERTO} ${USUARIO}@jupyter.ccad.unc.edu.ar"
echo
echo -e "${AMARILLO}     *. En su navegador acceda a localhost:9999${NC}"
echo "        Usuario: ${USUARIO}"
echo "        Contraseña: ${PASS}"
echo
echo
echo -e "${BLUE}################################################################################${NC}"
echo -e "${BLUE}################################################################################${NC}"
echo -e "${BLUE}################################################################################${NC}"
echo -e "######################################${AMARILLO}###${NC}#######################################"
echo -e "#####################################${AMARILLO}#####${NC}######################################"
echo -e "######################################${AMARILLO}###${NC}#######################################"
echo -e "${BLUE}################################################################################${NC}"
echo -e "${BLUE}################################################################################${NC}"
echo -e "${BLUE}################################################################################${NC}"
echo


# Ejecutar el script con las variables
cd $HOME/rstudio-server-conda/singularity/

#PORT=$(find_available_port) PASSWORD=$(generate_password) ./run_singularity.sh
PORT=${PUERTO} PASSWORD=${PASS} ./run_singularity.sh

