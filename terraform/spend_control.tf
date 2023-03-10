resource "azurerm_consumption_budget_resource_group" "spend_limit_server" {
  name              = "Consumption budget for Server"
  resource_group_id = azurerm_resource_group.rg.id
  # amount is local currency (here, NOK)
  amount     = 1000
  time_grain = "Monthly"
  time_period {
    start_date = format("%s-01T00:00:00Z", formatdate("YYYY-MM", timestamp()))
  }

  notification {
    enabled = true
    # In percent
    threshold      = 90.0
    operator       = "EqualTo"
    threshold_type = "Forecasted"

    contact_emails = [
      var.alert_email
    ]
  }
}