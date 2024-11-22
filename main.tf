# resource " aws_vpc" "main"{
#     cidr_block = var.cidr_block  
# }

# resource "aws_subnet" "subnet1"{
#     vpc_id              = aws_vpc.main.id
#     cidr_block          = "10.0.1.0/24"
#     availability_zone   = "${var.region}a" #para seleccionar la primera zona de disponibilidad en esa región. 
#                                             #Por ejemplo, si var.region es "us-west-2", la subred se creará en "us-west-2a"
# }

resource "aws_instance" "first_ec2"{
        ami             = var.ami  #variable definida en variable.tf
        instance_type   = var.instance_type #variable definida en variable.tf
        key_name        = var.key_name #variable definida en variable.tf


        #asocia la instancia con la subred que se creo
        subnet_id       = aws_subnet.subnet1.id 

        # se especifica el grupo de seguridad 
        vpc_security_group_ids = [aws_security_group.instance_sg.id]

        tags = { 
            Name        = "terraform_ec2"
        
        }
}