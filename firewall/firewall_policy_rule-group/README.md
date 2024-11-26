# Módulo de Terraform para Configurar un Firewall en AWS con Política y Grupos de Reglas

Este módulo de Terraform permite configurar un **firewall de red** en AWS utilizando el servicio AWS Network Firewall. Además del firewall, este módulo crea una **política de firewall** y un **grupo de reglas** asociado para definir las configuraciones de tráfico y seguridad de la red.

## Descripción

El módulo despliega los siguientes recursos:

1. **Firewall**: Implementa un firewall en AWS para controlar el tráfico de red.
2. **Policy**: Configura una política de firewall que define el comportamiento del firewall utilizando grupos de reglas.
3. **Rule Group**: Crea un grupo de reglas que especifica las reglas de tráfico de red, tanto para inspección con estado (stateful) como sin estado (stateless).

## Prerrequisitos

1. **AWS CLI Configurada**: Es necesario configurar las credenciales de AWS en tu entorno local. [Guía de configuración](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html).
2. **Terraform y Terragrunt Instalados**: [Instalación de Terraform](https://developer.hashicorp.com/terraform/downloads)

## Variables

- **Generales**
  - **`region`**: Región de AWS donde se desplegarán los recursos.
  - **`tags`**: Mapa de etiquetas aplicable a todos los recursos creados.
  - **`vpc_id`**: ID del VPC donde se implementará el firewall.
  - **`subnet_id`**: ID de la subnet donde se implementará el firewall.

- **Firewall**
  - **`create`**: Controles si se deben crear los recursos.
  - **`firewall_name`**: Nombre del firewall.
  - **`ip_address_type`**: Tipo de direcciones IP utilizadas por el firewall (ya sea IPV4 o IPV6).
  - **`delete_protection`**: Booleano para proteger contra la eliminación accidental del firewall.
  - **`description`**: Descripción del firewall.
  - **`encryption_configuration`**: Configuración de cifrado KMS (opcional).
  - **`firewall_policy_change_protection`**: Protección contra cambios en la política del firewall.
  - **`subnet_change_protection`**: Protección contra cambios en las subredes asociadas al firewall.
  - **`subnet_mapping`**: Configuración de las subredes públicas donde se desplegará el firewall.
  - **`create_logging_configuration`**: Controles si se debe crear una configuración de logging.
  - **`logging_configuration_destination_config`**: Una lista de al menos 1, máximo 2 bloques de configuración que describen el destino para la configuración de logging

- **Policy**
  - **`firewall_policy_name`**: Nombre de la política de firewall.
  - **`firewall_policy_description`**: Descripción de la política.

- **Rule Group**

  - **Stateless (sin estado)**
  - **`stateless_rule_group_name`**: Nombre del grupo de reglas sin estado.
  - **`stateless_rule_group_capacity`**: Capacidad del grupo de reglas sin estado.
  - **`stateless_rule_group_description`**: Descripción del grupo de reglas sin estado.
  - **`stateless_rule_group_type`**: Tipo de reglas para el grupo de reglas sin estado (ej. 'STATELESS').
  - **`stateless_protocol`**: Protocolo para las reglas sin estado.
  - **`stateless_destination_ports`**: Puertos de destino para las reglas sin estado.
  - **`stateless_rule_priority`**: Prioridad para las reglas sin estado.
  - **`stateless_default_actions`**: Acciones predeterminadas para las reglas sin estado.
  - **`stateless_fragment_default_actions`**: Acciones predeterminadas para los fragmentos de reglas sin estado.
  - **`stateless_destination`**: Dirección de destino para la regla sin estado.
  - **`stateless_source`**: Dirección de origen para la regla sin estado.
  
  - **Stateful (con estado)**
  - **`stateful_rule_group_name`**: Nombre del grupo de reglas con estado.
  - **`stateful_rule_group_capacity`**: Capacidad del grupo de reglas con estado.
  - **`stateful_rule_group_description`**: Descripción del grupo de reglas con estado.
  - **`stateful_rule_group_type`**: Tipo de reglas para el grupo de reglas con estado (ej. 'STATEFUL').
  - **`stateful_rule_action`**: Acción para las reglas con estado.
  - **`stateful_protocol`**: Protocolo para las reglas con estado.
  - **`stateful_destination_port`**: Puerto de destino para las reglas con estado.
  - **`stateful_destination`**: Dirección de destino para la regla con estado.
  - **`stateful_source`**: Dirección de origen para la regla con estado.
  - **`stateful_source_port`**: Puerto de origen para la regla con estado.
  - **`stateful_direction`**: Dirección para la regla con estado.
  - **`stateful_sid`**: SID base para las reglas stateful.


## Outputs

- **Firewall**
  - **`firewall_id`**: Identificador del firewall.
  - **`firewall_arn`**: ARN del firewall.
  - **`firewall_status`**: Estado actual del firewall.

- **Policy**
  - **`policy_id`**: Identificador de la política de firewall.
  - **`policy_arn`**: ARN de la política de firewall.

- **Rule Group**
  - **`rule_group_id`**: Identificador del grupo de reglas.
  - **`rule_group_arn`**: ARN del grupo de reglas.

# Recursos Adicionales

Para una mejor comprensión y configuración de AWS Network Firewall y Terraform, aquí tienes algunos recursos adicionales:

- **Documentación oficial de Terraform**: [Terraform by HashiCorp](https://developer.hashicorp.com/terraform/docs)  
  Información completa sobre el uso de Terraform, sus configuraciones, funciones y mejores prácticas.

- **AWS Network Firewall - Qué es AWS Network Firewall**: [Introducción a AWS Network Firewall](https://docs.aws.amazon.com/network-firewall/latest/developerguide/what-is-aws-network-firewall.html)  
  Descripción general del servicio AWS Network Firewall, cómo funciona y sus principales características.

- **AWS Network Firewall - Políticas de Firewall**: [Guía de Políticas de Firewall](https://docs.aws.amazon.com/network-firewall/latest/developerguide/firewall-policies.html)  
  Información detallada sobre cómo configurar y aplicar políticas de firewall en AWS Network Firewall.

- **AWS Network Firewall - Grupos de Reglas**: [Guía de Grupos de Reglas](https://docs.aws.amazon.com/network-firewall/latest/developerguide/rule-groups.html)  
  Detalles sobre la creación y uso de grupos de reglas en AWS Network Firewall para controlar el tráfico de red.

- **AWS Network Firewall - Configuración de Logging**: [Guía de Configuración de Logging](https://docs.aws.amazon.com/network-firewall/latest/developerguide/logging.html)  
  Información sobre cómo configurar el registro (logging) en AWS Network Firewall para monitorear eventos de tráfico y alertas.

- **Guía de configuración de AWS CLI**: [Configurar AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html)  
  Pasos para configurar la CLI de AWS y permitir que Terraform se autentique con tus credenciales de AWS.

- **Instalación de Terraform**: [Instalación de Terraform](https://developer.hashicorp.com/terraform/downloads)  
  Guía para descargar e instalar Terraform en tu entorno local.

- **Instalación de Terragrunt**: [Instalación de Terragrunt](https://terragrunt.gruntwork.io/docs/getting-started/install/)  
  Información sobre cómo instalar Terragrunt, una herramienta que facilita la gestión de configuraciones de Terraform.


