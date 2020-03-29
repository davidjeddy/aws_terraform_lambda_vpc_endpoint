# NOTE: change region in these two providers as desired

provider aws {
  region                  = "us-west-2"
  profile                 = "connechub_dev"
  shared_credentials_file = "$HOME/.aws/credentials"
  version                 = "~> 2.0"
}

provider aws {
  alias                   = "default"
  region                  = "us-west-2"
  profile                 = "connechub_dev"
  shared_credentials_file = "$HOME/.aws/credentials"
  version                 = "~> 2.0"
}

# Other Terraform providers

provider archive {
  version = "~> 1.3"
}

provider http {
  version = "~> 1.1"
}

provider random {
  version = "~> 2.2"
}

terraform {
  required_version = ">= 0.12.24"
}
