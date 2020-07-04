variable "company" {
  type = string
  description = "Company name"
}
variable "environment" {
  type = string
  description = "Environment name"
}
variable "name" {
  type = string
  description = "Name"
}
variable "service" {
  type = string
  description = "Service name"
}
variable "domain_name" {
  type = string
  description = "Fully qualified domain name to create the certificate for"
}
variable "zone_id" {
  type = string
  description = "Id of the zone to add the certificate validation record"
}
variable "allow_overwrite" {
  type = bool
  description = "Flag to allow the overwriting of the a record for cert validation"
  default = true
}
variable "record_ttl" {
  type = number
  description = "TTL for cert validation a record"
  default = 300
}
variable "tags" {
  description = "Tags for the certificate resources"
  type        = "map"
  default     = {}
}
