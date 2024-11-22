#!/bin/bash

# Ruta donde se almacenan los archivos generados por Terragrunt y Terraform
TERRAGRUNT_CACHE=".terragrunt-cache"
TERRAFORM_LOCK=".terraform.lock.hcl"

# Función para borrar la carpeta .terragrunt-cache
delete_terragrunt_cache() {
    echo "----------------------------------------"
    if [ -d "$TERRAGRUNT_CACHE" ]; then
        echo "Borrando carpeta $TERRAGRUNT_CACHE..."
        rm -rf "$TERRAGRUNT_CACHE"
        echo "Carpeta $TERRAGRUNT_CACHE eliminada."
    else
        echo "No se encontró la carpeta $TERRAGRUNT_CACHE."
    fi
    echo "----------------------------------------"
}

# Función para borrar el archivo .terraform.lock.hcl
delete_terraform_lock() {
    echo "----------------------------------------"
    if [ -f "$TERRAFORM_LOCK" ]; then
        echo "Borrando archivo $TERRAFORM_LOCK..."
        rm -f "$TERRAFORM_LOCK"
        echo "Archivo $TERRAFORM_LOCK eliminado."
    else
        echo "No se encontró el archivo $TERRAFORM_LOCK."
    fi
    echo "----------------------------------------"
}

# Ejecutar las funciones
echo "----------------------------------------"
delete_terragrunt_cache


echo "----------------------------------------"
delete_terraform_lock


echo "----------------------------------------"
echo "Limpieza completada."
echo "----------------------------------------"
