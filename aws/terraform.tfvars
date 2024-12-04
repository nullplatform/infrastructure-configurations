domain_name = "femsa.nullapps.io"
organization = "femsa"
account = "poc"
namespace = "demo"
region = "us-east-1"
vpc = {
    cidr = "10.82.124.0/22"
    private_subnets = ["10.82.124.0/25", "10.82.124.128/25"]
    public_subnets = ["10.82.125.0/25", "10.82.125.128/25"]
    azs = ["us-east-1a", "us-east-1b"]
}