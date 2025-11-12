variable "project" { 
    description = "name of the project"
    type = string 
    }

variable "env"     { 
    description = "enviroment workspace"
    type = string
     }
variable "cidr_block" {
     description = "cidr block range"
     type = string 
     }
variable "public_subnets" { 
    description = "subnet id"
    type = list(string)
     }
variable "tags" { type = map(string) }


variable "private_subnets" { 
    description = "subnet id"
    type = list(string)
     }

     
variable "azs" {
     description = "availabilty zones for the subnets"
     type = list(string)
     }



variable "cluster_name" {
  type = string
}
