resource "aws_vpc" "main" {
    #rango de direcciones ip
    cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "subnet1"{
    #especificacion a que vpc pertenece
    vpc_id            = aws_vpc.main.id
    cidr_block        = "10.0.1.0/24"
    #que zona se ejecutara esa subred
    availability_zone = "us-west-2a"
}