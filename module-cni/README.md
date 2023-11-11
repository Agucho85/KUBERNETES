### Child Module ###
Contiene los siguientes archivos:
1) .gitignore:
    Configurado para poder validar su configuracion de Terraform y que no suba al git los archivos nuevos de terra.
2) main.tf:
    Contiene la configuracion principal del module, sus recursos
3) outputs.tf:
    Aqui podemos exportar determinados datos hacia el root module y de ahi porder utilizarlo en otros child modules posteriores
4) variables.tf:
    Contiene variables.
        En general no tienen contenido, que deben ser completadas en el root module.
    Ej:
    variable "aws_region" {
      description = "Region in which AWS Resources to be created"
      type        = string
    }
    Las que tiene contenido, no hace falta cargarlas en el root module, esto podria implicar un limitación en el root module, es utilizado generalmente para que determinados datos no puedan ser cambiados por desarrolladores al momento de levantar recusros.
    Ej:
    variable "aws_region" {
      description = "Region in which AWS Resources to be created"
      type        = string
      default     = "us-east-1"
    }