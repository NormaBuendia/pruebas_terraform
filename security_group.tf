resource "aws_security_group" "instance_sg" {
    vpc_id = aws_vpc.main.id   #referencia a la VPC creada en vpc.tf 

# Reglas de entrada
    ingress {
        from_port   = 22 #puerto SSH
        to_port     = 22
        protocol    = "tcp" #protocolo de comunicacion que garantiza la entrega de datos
        cidr_blocks = ["0.0.0.0/0"]  # Permite acceso desde cualquier IP
    }

     ingress {
        from_port   = 80 #puerto para HTTP
        to_port     = 80
        protocol    = "tcp" #protocolo de comunicacion que garantiza la entrega de datos
        cidr_blocks = ["0.0.0.0/0"]  # Permite acceso HTTP desde cualquier IP
    }

#Reglas de salida
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1" #permite todo el trafico de salida
        cidr_blocks = ["0.0.0.0/0"] 
    }

    tags = {
        Name = "instance_security_group"
    }
}