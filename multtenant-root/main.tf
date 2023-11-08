# Datasource: AWS Partition
# Use this data source to lookup information about the current AWS partition in which Terraform is working
data "aws_partition" "current" {}
data "aws_caller_identity" "current" {}
output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

# Modulo IAM, reemplazado por data-source de los recursos existente.
/* module "iam" {
  source = "git::https://gaiden.visualstudio.com/DefaultCollection/KUBERNETES-MULTITENANT/_git/module-iam?ref=main"
  source = "../modulo-iam"
  # AWS Inputs
  aws_region = var.aws_region

  # locals variables
  environment = var.environment
  project     = var.project

  #Users Inputs
  users_admin      = var.users_admin
  users_developers = var.users_developers

  aws_caller_identity = data.aws_caller_identity.current
  cluster_name        = var.cluster_name
} */

module "eks" {
  source = "git::https://gaiden.visualstudio.com/DefaultCollection/KUBERNETES-MULTITENANT/_git/module-eks?ref=main"
  #source = "../module-eks"
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

resource "time_sleep" "wait_1_minute" {
  depends_on = [module.eks.cluster_certificate_authority_data]

  create_duration = "1m"
}

module "cni" {
  source = "git::https://gaiden.visualstudio.com/DefaultCollection/KUBERNETES-MULTITENANT/_git/module-cni?ref=main"
  #source = "../module-cni"

  depends_on   = [time_sleep.wait_1_minute]
  aws_region   = var.aws_region
  project      = var.project
  cluster_name = var.cluster_name
}

module "private_node_group" {
  source = "git::https://gaiden.visualstudio.com/DefaultCollection/KUBERNETES-MULTITENANT/_git/module-private-node-group?ref=main"
  #source = "../module-private-node-group"

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

# module "istio" {
#   source =  "git::https://gaiden.visualstudio.com/DefaultCollection/KUBERNETES-MULTITENANT/_git/module-istio?ref=main"
#   #source     = "../module-istio"
#   depends_on = [module.private-node-group.node_group_private_id]
#   # Locals Inputss
#   environment = var.environment
#   project     = var.project

#   # #OIDC Provider Inputs
#   eks_oidc_root_ca_thumbprint = var.eks_oidc_root_ca_thumbprint

#   # Users Inputs
#   users_admin      = var.users_admin
#   users_developers = var.users_developers

#   # AWS Inputs  
#   aws_region = var.aws_region

#   # VPC Input Variables
#   vpc_id                    = data.aws_vpc.vpc_id.id
#   vpc_region                = var.aws_region
#   vpc_cidr_block            = data.aws_vpc.vpc_id.cidr_block
#   vpc_public_subnets        = data.aws_subnets.vpc_public_subnets.ids
#   vpc_private_subnets       = data.aws_subnets.vpc_private_subnets.ids
#   vpc_database_subnets      = data.aws_subnets.database_subnets.ids
#   vpc_database_subnet_group = data.aws_db_subnet_group.database_subnet_group.name
#   nat_gateway_ips           = data.aws_nat_gateway.ngs.public_ip

#   # module eks imputs
#   cluster_version                      = var.cluster_version
#   cluster_endpoint_public_access       = var.cluster_endpoint_public_access
#   cluster_endpoint_private_access      = var.cluster_endpoint_private_access
#   cluster_endpoint_public_access_cidrs = var.cluster_endpoint_public_access_cidrs
#   cluster_service_ipv4_cidr            = var.cluster_service_ipv4_cidr

#   # EKS Private Node Group Inputs
#   cluster_name          = var.cluster_name
#   capacity_type_private = var.capacity_type_private
#   desired_size_private  = var.desired_size_private
#   disk_size_private     = var.disk_size_private
#   min_size_private      = var.min_size_private
#   max_size_private      = var.max_size_private

#   # EKS ConfigMap Inputs
#   eks_master_role_arn     = data.aws_iam_role.eks_master_role.arn
#   eks_master_role_name    = data.aws_iam_role.eks_master_role.name
#   eks_nodegroup_role_arn  = data.aws_iam_role.eks_nodegroup_role.arn
#   eks_nodegroup_role_name = data.aws_iam_role.eks_nodegroup_role.name
#   eks_admin_role_arn      = data.aws_iam_role.eks_admin_role.arn
#   eks_admin_role_name     = data.aws_iam_role.eks_admin_role.name
#   eks_developer_role_arn  = data.aws_iam_role.eks_developer_role.arn
#   eks_developer_role_name = data.aws_iam_role.eks_developer_role.name

#   namespace = var.namespace
# }

# module "namespaces" {
#   source =  "git::https://gaiden.visualstudio.com/DefaultCollection/KUBERNETES-MULTITENANT/_git/module-namespaces?ref=main"
#   #source     = "../module-namespaces"
#   depends_on = [module.istio.istio_egress]

#   namespace = var.namespace
# }



module "ebs_autoscaler" {
  source =  "git::https://gaiden.visualstudio.com/DefaultCollection/KUBERNETES-MULTITENANT/_git/module-ebs-autoscaler?ref=main"
  
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

module "loadbalancer" {
  source = "git::https://gaiden.visualstudio.com/DefaultCollection/KUBERNETES-MULTITENANT/_git/module-lb?ref=main"
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