# Datasource: AWS Partition
# Use this data source to lookup information about the current AWS partition in which Terraform is working
data "aws_partition" "current" {}
data "aws_caller_identity" "current" {}
output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

# Creacion del cluster de EKS
module "eks" {
  #source = "git::https://***/_git/module-eks?ref=main"
  source = "../module-eks"
  # AWS Inputss
  aws_region  = var.aws_region
  environment = var.environment
  project     = var.project

  #OIDC Provider Inputs
  eks_oidc_root_ca_thumbprint = var.eks_oidc_root_ca_thumbprint

  # EKS Cluster Inputs
  cluster_name              = var.cluster_name
  eks_master_role_arn       = data.aws_iam_role.eks_master_role.arn
  cluster_service_ipv4_cidr = var.cluster_service_ipv4_cidr
  cluster_version           = var.cluster_version

  #Users Inputs
  users_admin      = var.users_admin
  users_developers = var.users_developers

  vpc_region                           = var.aws_region
  vpc_cidr_block                       = data.aws_vpc.vpc_id.cidr_block
  vpc_public_subnets                   = data.aws_subnets.vpc_public_subnets.ids
  vpc_private_subnets                  = data.aws_subnets.vpc_private_subnets.ids
  vpc_database_subnets                 = data.aws_subnets.database_subnets.ids
  vpc_database_subnet_group            = data.aws_db_subnet_group.database_subnet_group.name
  cluster_endpoint_public_access       = var.cluster_endpoint_public_access
  cluster_endpoint_private_access      = var.cluster_endpoint_private_access
  cluster_endpoint_public_access_cidrs = var.cluster_endpoint_public_access_cidrs
  nat_gateway_ips                      = data.aws_nat_gateway.ngs.public_ip
}

# Paso necesario para que este activo el EKS
resource "time_sleep" "wait_1_minute" {
  depends_on = [module.eks.cluster_certificate_authority_data]
  create_duration = "1m"
}

# Addons CNI para poder asignar mas ips a los nodos. 
module "cni" {
  #source = "git::https://***/_git/module-cni?ref=main"
  source = "../module-cni"

  depends_on   = [time_sleep.wait_1_minute]
  aws_region   = var.aws_region
  project      = var.project
  cluster_name = var.cluster_name
}

# Creacion de el grupo de nodos privados (buena practica llamar los modulos  con varios palabras con guion bajo)
module "private_node_group" {
  #source = "git::https://***/_git/module-private-node-group?ref=main"
  source = "../module-private-node-group"

  depends_on = [module.cni.enable_prefix_delegation]
  # AWS Inputss
  environment = var.environment
  project     = var.project

  #OIDC Provider Inputs
  eks_oidc_root_ca_thumbprint = var.eks_oidc_root_ca_thumbprint

  #Users Inputs
  users_admin      = var.users_admin
  users_developers = var.users_developers

  # AWS Inputs
  aws_region = var.aws_region

  # VPC Input Variables
  vpc_id                    = data.aws_vpc.vpc_id.id
  vpc_region                = var.aws_region
  vpc_cidr_block            = data.aws_vpc.vpc_id.cidr_block
  vpc_public_subnets        = data.aws_subnets.vpc_public_subnets.ids
  vpc_private_subnets       = data.aws_subnets.vpc_private_subnets.ids
  vpc_database_subnets      = data.aws_subnets.database_subnets.ids
  vpc_database_subnet_group = data.aws_db_subnet_group.database_subnet_group.name
  nat_gateway_ips           = data.aws_nat_gateway.ngs.public_ip

  # module eks imputs
  cluster_version                      = var.cluster_version
  cluster_endpoint_public_access       = var.cluster_endpoint_public_access
  cluster_endpoint_private_access      = var.cluster_endpoint_private_access
  cluster_endpoint_public_access_cidrs = var.cluster_endpoint_public_access_cidrs
  cluster_service_ipv4_cidr            = var.cluster_service_ipv4_cidr

  # EKS Private Node Group Inputs
  cluster_name          = var.cluster_name
  instance_type_private = var.instance_type_private
  capacity_type_private = var.capacity_type_private
  desired_size_private  = var.desired_size_private
  disk_size_private     = var.disk_size_private
  min_size_private      = var.min_size_private
  max_size_private      = var.max_size_private

  # EKS ConfigMap Inputs
  eks_master_role_arn     = data.aws_iam_role.eks_master_role.arn
  eks_master_role_name    = data.aws_iam_role.eks_master_role.name
  eks_nodegroup_role_arn  = data.aws_iam_role.eks_nodegroup_role.arn
  eks_nodegroup_role_name = data.aws_iam_role.eks_nodegroup_role.name
  eks_admin_role_arn      = data.aws_iam_role.eks_admin_role.arn
  eks_admin_role_name     = data.aws_iam_role.eks_admin_role.name
  eks_developer_role_arn  = data.aws_iam_role.eks_developer_role.arn
  eks_developer_role_name = data.aws_iam_role.eks_developer_role.name
}

# Creacion de los recurso de CSI, autoescaler y metrics server
module "ebs_autoscaler" {
  # source =  "git::https://***/_git/module-ebs-autoscaler?ref=main"
  source = "../module-ebs-autoscaler"

  depends_on = [ module.private_node_group.node_group_private_arn ]
  # AWS Inputss
  environment = var.environment
  project     = var.project
  aws_region = var.aws_region
  
  # Cluster imputs  
  cluster_name = var.cluster_name
  cluster_id = module.eks.cluster_id

  #IAM Imputs
  ebs_csi_iam_role_arn = data.aws_iam_role.ebs_csi_iam_role.arn
  cluster_autoscaler_iam_role_arn = data.aws_iam_role.cluster_autoscaler_iam_role.arn
}

# Creacion de los recurso de balanceador de carga
module "loadbalancer" {
  #source = "git::https://*****/_git/module-lb?ref=main"
  source = "../module-lb"

  depends_on = [ module.private_node_group.node_group_private_arn ]
  
  # AWS Inputss
  environment = var.environment
  project     = var.project
  aws_region = var.aws_region
  
  # Cluster imputs  
  cluster_name = var.cluster_name
  cluster_id = module.eks.cluster_id
  lbc_iam_role_arn = data.aws_iam_role.lbc_iam_role.arn
  vpc_id = data.aws_vpc.vpc_id.id
}