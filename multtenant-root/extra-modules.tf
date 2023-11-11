##### Files for other modules to implement in the cluster_name, every time you add a module, you  must check the outputs file in the root module and add or uncomment the outputs, then replace each resource that uses data from this module instead of a resource previuosly created without terraform.
/* Example:

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
  vpc_cidr_block                       = data.aws_vpc.vpc_id.cidr_block  >> module.vpc.vpc_cidr_block
  vpc_public_subnets                   = data.aws_subnets.vpc_public_subnets.ids  >>  module.vpc.public_subnets
  vpc_private_subnets                  = data.aws_subnets.vpc_private_subnets.ids  >>  module.vpc.private_subnets
  vpc_database_subnets                 = data.aws_subnets.database_subnets.ids >> module.vpc.database_subnets
  vpc_database_subnet_group            = data.aws_db_subnet_group.database_subnet_group.name >> module.vpc.database_subnet_group_name
  cluster_endpoint_public_access       = var.cluster_endpoint_public_access
  cluster_endpoint_private_access      = var.cluster_endpoint_private_access
  cluster_endpoint_public_access_cidrs = var.cluster_endpoint_public_access_cidrs
  nat_gateway_ips                      = data.aws_nat_gateway.ngs.public_ip >> module.vpc.nat_public_ips

}

*/

/*
module "vpc" {
  source = "git::https://gaiden.visualstudio.com/DefaultCollection/KUBERNETES-MULTITENANT/_git/module-vpc?ref=main"

  # AWS Inputss
  environment = var.environment
  project     = var.project
  cluster_name = var.cluster_name
  # VPC Basic Details
  vpc_cidr_block            = var.vpc_cidr_block
  vpc_availability_zones             = var.vpc_availability_zones
  vpc_public_subnets  = var.vpc_public_subnets
  vpc_private_subnets = var.vpc_private_subnets

  # Database Subnets
  vpc_database_subnets                   = var.vpc_database_subnets
  vpc_create_database_subnet_group       = var.vpc_create_database_subnet_group
  vpc_create_database_subnet_route_table = var.vpc_create_database_subnet_route_table

  # NAT Gateways - Outbound Communication
  vpc_enable_nat_gateway = var.vpc_enable_nat_gateway
  vpc_single_nat_gateway = var.vpc_single_nat_gateway
*/

/*
# Modulo IAM.
 module "iam" {
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
}
*/
/*
module "iam_addons"
# apply just after eks is deploy
  source =  "git::https://gaiden.visualstudio.com/DefaultCollection/KUBERNETES-MULTITENANT/_git/module-iam-addons?ref=main"
 # in progress...
   
*/
/* En este se debe realizar mas trabajo....
 module "istio" {
   source =  "git::https://gaiden.visualstudio.com/DefaultCollection/KUBERNETES-MULTITENANT/_git/module-istio?ref=main"
   #source     = "../module-istio"
   depends_on = [module.private-node-group.node_group_private_id]
   # Locals Inputss
   environment = var.environment
   project     = var.project
   # #OIDC Provider Inputs
   eks_oidc_root_ca_thumbprint = var.eks_oidc_root_ca_thumbprint
   # Users Inputs
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
   namespace = var.namespace
 }
*/

 /* En este se debe realizar mas trabajo....
 module "namespaces" {
   source =  "git::https://gaiden.visualstudio.com/DefaultCollection/KUBERNETES-MULTITENANT/_git/module-namespaces?ref=main"
   #source     = "../module-namespaces"
   depends_on = [module.istio.istio_egress]
   namespace = var.namespace
 }
*/