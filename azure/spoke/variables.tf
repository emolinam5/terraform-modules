variable "environment" {
  description = "The environment name used for resource naming (e.g., dev, staging, prod)"
  type        = string

  validation {
    condition     = can(regex("^(dev|staging|prod|test)$", var.environment))
    error_message = "Environment must be one of: dev, staging, prod, test."
  }
}

variable "location" {
  description = "The Azure Region where the Resource Group should exist. Changing this forces a new Resource Group to be created."
  type        = string

  validation {
    condition     = can(regex("^[a-z]+[a-z0-9]*$", var.location))
    error_message = "Location must be a valid Azure region name (e.g., eastus, westeurope)."
  }
}

variable "name" {
  description = "The name which should be used. Changing this forces a new spoke to be created."
  type        = string

  validation {
    condition     = length(var.name) > 0 && length(var.name) <= 90
    error_message = "Name must be between 1 and 90 characters."
  }

  validation {
    condition     = can(regex("^[a-zA-Z0-9._()-]+$", var.name))
    error_message = "Name can only contain alphanumerics, underscores, parentheses, hyphens, and periods."
  }
}

variable "virtual_network_name" {
  description = "The name of the virtual network. Changing this forces a new resource to be created."
  type        = string

  validation {
    condition     = length(var.virtual_network_name) > 0 && length(var.virtual_network_name) <= 64
    error_message = "Virtual network name must be between 1 and 64 characters."
  }

  validation {
    condition     = can(regex("^[a-zA-Z0-9][a-zA-Z0-9._-]*[a-zA-Z0-9_]$", var.virtual_network_name))
    error_message = "Virtual network name must start with alphanumeric, end with alphanumeric or underscore, and contain only alphanumerics, underscores, hyphens, and periods."
  }
}

variable "vnet" {
  description = "The address space that is used the virtual network. You can supply more than one address space."
  type        = string

  validation {
    condition     = can(cidrhost(var.vnet, 0))
    error_message = "VNet must be a valid CIDR block (e.g., 10.1.0.0/16)."
  }

  validation {
    condition     = can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}/[0-9]{1,2}$", var.vnet))
    error_message = "VNet must be in valid CIDR notation (e.g., 10.1.0.0/16)."
  }
}
