#!/bin/bash

# Define el directorio donde está tu configuración de Terragrunt (que referencia al módulo de Terraform)
TERRAGRUNT_DIR="./"

# Moverse al directorio donde tienes el archivo terragrunt.hcl
cd $TERRAGRUNT_DIR || { echo "Error: No se pudo acceder al directorio $TERRAGRUNT_DIR"; exit 1; }

# Ejecutar Terragrunt para inicializar el módulo de Terraform que está referenciado en terragrunt.hcl
echo "-----------------------------------"
echo "-----------------------------------"
echo "Se inicia terragrunt"
terragrunt init
echo "-----------------------------------"
echo "-----------------------------------"

# Plan de Terragrunt
echo "-----------------------------------"
echo "-----------------------------------"
echo "Se ejecuta terragrunt-plan"
terragrunt plan
if [ $? -ne 0 ]; then
    echo "Error: Falló terragrunt plan"
    exit 1
fi
echo "-----------------------------------"
echo "-----------------------------------"

# Aplicar el módulo de Terraform a través de Terragrunt
echo "-----------------------------------"
echo "-----------------------------------"
echo "Aplicando la infraestructura en $TERRAGRUNT_DIR"
terragrunt apply --auto-approve
if [ $? -ne 0 ]; then
    echo "Error: Falló terragrunt apply"
    exit 1
fi
echo "-----------------------------------"
echo "-----------------------------------"

# Esperar unos segundos antes de ejecutar destroy (puedes cambiar el número de segundos si lo deseas)
echo "-----------------------------------"
echo "Esperando 10 segundos antes de ejecutar terragrunt-destroy..."
sleep 10
echo "-----------------------------------"

# Ejecutar Terraform Destroy para eliminar los recursos creados
echo "-----------------------------------"
echo "-----------------------------------"
echo "Destruyendo la infraestructura en $TERRAGRUNT_DIR"
echo "-----------------------------------"
terragrunt destroy --auto-approve
if [ $? -ne 0 ]; then
    echo "Error: Falló terragrunt destroy"
    exit 1
fi
echo "-----------------------------------"
echo "-----------------------------------"
echo "Terragrunt finalizó exitosamente"
echo "-----------------------------------"
echo "-----------------------------------"