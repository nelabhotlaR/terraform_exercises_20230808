
variable "SKYPE_SENDER_QUEUE_URL" {
  description = "Skype Sender Queue Url"
  type        = string
  default     = ""
}

variable "CHATGPT_API_KEY" {
  description = "ChatGPT open api key"
  type        = string
  default     = ""
}

variable "CHATGPT_VERSION" {
  description = "ChatGPT Version"
  type        = string
  default     = "gpt-3.5-turbo"
}

variable "URL" {
  description = "Newsletter URL"
  type        = string
  default     = ""
}

variable "DEFAULT_CATEGORY" {
  description = "Newsletter default category"
  type        = string
  default     = ""
}

variable "API_KEY_VALUE" {
  description = "Newsletter API key"
  type        = string
  default     = ""
}

variable "employee_list" {
  description = "List of employee names"
  type        = list(string)
  default     = ["Raji", "Mohan", "Akkul", "Drishya", "Raghava", "Shiva", "Indira", "RohanD", "Sravanti", "Preedhi", "Ajitava", "Archana"]
}

variable "LOCALSTACK_ENV" {
  description = "Local Stack Env"
  type        = string
  default     = ""
}

variable "ETC_CHANNEL" {
  description = "Etc channel id"
  type        = string
  default     = ""
}

variable "Qxf2Bot_USER" {
  description = "Qxf2Bot_USER"
  type        = string
  default     = ""
}