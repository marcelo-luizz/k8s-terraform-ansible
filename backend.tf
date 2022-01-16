terraform {
    backend "s3" {
        region = "us-east-1"
        bucket = "k8s_remote_state"
        encrypt = "true"
        key = "terraform.tfstate"
    }
}

