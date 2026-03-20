resource "aws_sfn_state_machine" "order_workflow" {
  name     = "OrderWorkflow"
  role_arn = aws_iam_role.stepfunctions.arn

  definition = jsonencode({
    Comment = "Order processing workflow"
    StartAt = "ValidateOrder"
    States = {
      ValidateOrder = {
        Type       = "Pass"
        Result     = { validated = true }
        ResultPath = "$.validation"
        Next       = "ProcessPayment"
      }
      ProcessPayment = {
        Type       = "Pass"
        Result     = { paymentStatus = "SUCCESS" }
        ResultPath = "$.payment"
        Next       = "GenerateReceipt"
      }
      GenerateReceipt = {
        Type     = "Task"
        Resource = "arn:aws:states:::lambda:invoke"
        Parameters = {
          FunctionName = aws_lambda_function.generate_receipt.arn
          "Payload.$"  = "$"
        }
        OutputPath = "$.Payload"
        Next       = "NotifyCustomer"
      }
      NotifyCustomer = {
        Type     = "Task"
        Resource = "arn:aws:states:::lambda:invoke"
        Parameters = {
          FunctionName = aws_lambda_function.process_order.arn
          "Payload.$"  = "$"
        }
        OutputPath = "$.Payload"
        Next       = "OrderComplete"
      }
      OrderComplete = {
        Type = "Succeed"
      }
    }
    TimeoutSeconds = 300
  })
}
