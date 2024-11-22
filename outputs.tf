output "instance_id" {
    value       = "aws_instance.first_ec2.id"
    description = "El id de instancia EC2 creada"
}

output "instance_public_ip" {
    value       = "aws_instance.first_ec2.id"
    description = "La direccin IP publica de la instancia EC2"
}

output "vpc_id" {
    value       = "aws_vpc.main.id"
    description = "El ID de la VPC creada"
}