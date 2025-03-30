variable "universal_syslog_registry" {
  description = "The registry for the universal syslog image"
  type        = string
  default     = "127.0.0.1:5001/us/container"
}
variable "universal_syslog_image" {
  description = "The universal syslog image"
  type        = string
  default     = "universal-syslog"
}
variable "universal_syslog_image_tag" {
  description = "The universal syslog image tag"
  type        = string
}

variable "universal_syslog_chart_tag" {
  description = "The universal syslog chart tag"
  type        = string
}
