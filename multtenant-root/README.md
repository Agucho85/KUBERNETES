### Root Module ###
Contiene los siguientes archivos:
1) .gitignore:
    Configurado para poder validar su configuracion de Terraform y que no suba al git los archivos nuevos de terra, inlcuso un terrafom plan.

2) main.tf:
    Contiene la configuracion principal del modulo, lo cuales llamaa a otros modulos (child modules) y tambien tiene algun recurso de creacion directa (tieme_sleep).

3) outputs.tf:
    Aqui podemos exportar determinados datos que pueden ser utilizados a posterior en la consola

4) variables.tf:
    Contiene variables. TODAS deben tiene contenido.
    Ej:
    variable "aws_region" {
      description = "Region in which AWS Resources to be created"
      type        = string
      default     = "us-east-1"
    }

5) Los archivos *-data.tf contiene las data ya creada en el cuenta de AWS, que luego es consumida por otros modulos de terrafom para deplejar sus recursos.

6) providers.tf 
  Contiene:
    a- Los providers que utilizo el root module para desplegar los recursos. Estos podrian cambiar con las actualizaciones
    b- El backend (bucket de S3 y dynamo-db table) para poder ejectuar localmente el terra, esto es pizado por la configuracion del pipelines de ejecutarse en Azure Devops

7) extra-modules.tf: 
   Contiene la configuracion rapida para los otros child modules que por ahora no se estan usando, revisar con atencion en caso de usarlos.

8) azure-pipelines.yml 
  Yaml utilizado para desplegar el eks en ADO
  Se debe configurar la variable de PAT dentro de ADo. Este es un token que permite consultar los repositorios deonde se encuentran los child modules

9) azure-pipelines-destroy.yml
  Yaml utilizado para destruir el eks en ADO
  Se debe configurar la variable de PAT dentro de ADo. Este es un token que permite consultar los repositorios deonde se encuentran los child modules

10) Directorio modules. Contiene modulos que todavia no se acondicionaron para este codigo, debe ser modificados.


### Terraform - como ingresar al EKS ###
# Tener usuario con posibilidad de asumir el rol del RBAC en el eks. #
	Nuestro eks actual tiene como roles posibles para asumir dentro del eks a:
		- ${local-name}-eks-admin-role
		- ${local-name}-eks-readonly-role
			Nota: no utilizr ${local-name}-eks-master-role esto es solo para el servicio de aws.
	Debemos tener instalado aws cli y kubernetes cli en nuestra maquina.

# Configurar nuestro usuario en nuestra maquina (confiirmar que con un aws s3 ls) #

# Ir al archivo .aws/config y cargar al ultimo esto: #
...
[profile eks-admin4]   <nombre a discrecion>
role_arn = arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${local-name}-eks-admin-role <aqui colocamos el rol que queremos asumir>
source_profile = aws-user-profile  <aqui ponemos el nombre del perfil de aws que asumos para asumir el rol, lo tenemos configurar unas lineas mas arriba en este mismo archivo> 
...
Guardamos el archivo con estos agregados

# En nuestro cli, configuramos el cluster, a traves de un comando de aws con nos permite modificar el .kube/config. #
	 aws eks update-kubeconfig --region us-east-1 --name dirmod-test44 --profile eks-admin4
	 	Explicación:
	 	     aws eks update-kubeconfig: modificar el .kube/config en nuestra maquina
	 	     --region: la region donde esta nuestro cluster
	 	     --name: nombre del cluster
	 	     --profile: el profile cargado en el paso anterior que nos permite asumir el rol del rbac dentro del cluster (no tu profile de aws).
