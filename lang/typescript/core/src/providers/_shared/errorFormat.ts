/**
 * AWS wire-protocol error response formatting.
 *
 * Mirrors the error format helpers in `providers/_shared/aws_chaos.py`.
 */

/** The response format a service uses for errors. */
export type ErrorFormat = "json" | "xml_s3" | "xml_iam";

/** A single injectable error spec. */
export interface AwsErrorSpec {
  type: string;
  message: string;
  statusCode?: number;
  weight?: number;
}

/** HTTP status codes for well-known AWS error types. */
const AWS_ERROR_STATUS_CODES: Record<string, number> = {
  AccessDeniedException: 403,
  InvalidParameterException: 400,
  InvalidParameterValueException: 400,
  ValidationException: 400,
  DuplicateResourceException: 409,
  LimitExceededException: 429,
  ResourceNotFoundException: 404,
  ResourceNotFoundFault: 404,
  InvalidStateException: 409,
  ServiceUnavailableException: 503,
  InternalServerError: 500,
  ThrottlingException: 429,
  // IAM / STS
  NoSuchEntityException: 404,
  NoSuchEntity: 404,
  EntityAlreadyExistsException: 409,
  EntityAlreadyExists: 409,
  // S3
  NoSuchKey: 404,
  NoSuchBucket: 404,
  BucketAlreadyExists: 409,
  BucketAlreadyOwnedByYou: 409,
  AccessDenied: 403,
  // DynamoDB
  ConditionalCheckFailedException: 400,
  ProvisionedThroughputExceededException: 400,
  // SQS
  "AWS.SimpleQueueService.NonExistentQueue": 400,
  QueueDoesNotExist: 400,
  QueueNameExists: 400,
  // Cognito
  UserNotFoundException: 404,
  UsernameExistsException: 400,
  NotAuthorizedException: 401,
  // Step Functions
  StateMachineDoesNotExist: 400,
  ExecutionDoesNotExist: 400,
  // SNS
  NotFoundException: 404,
  // EventBridge
  ResourceAlreadyExistsException: 409,
};

function resolveStatusCode(error: AwsErrorSpec): number {
  if (error.statusCode !== undefined) return error.statusCode;
  return AWS_ERROR_STATUS_CODES[error.type] ?? 400;
}

export interface ErrorResponse {
  statusCode: number;
  contentType: string;
  body: string;
}

export function formatJsonError(error: AwsErrorSpec): ErrorResponse {
  return {
    statusCode: resolveStatusCode(error),
    contentType: "application/x-amz-json-1.0",
    body: JSON.stringify({ __type: error.type, message: error.message }),
  };
}

export function formatS3XmlError(error: AwsErrorSpec): ErrorResponse {
  const xml =
    `<?xml version='1.0' encoding='UTF-8'?><Error>` +
    `<Code>${error.type}</Code>` +
    `<Message>${error.message}</Message>` +
    `<Resource>/</Resource>` +
    `<RequestId>00000000-0000-0000-0000-000000000000</RequestId>` +
    `</Error>`;
  return { statusCode: resolveStatusCode(error), contentType: "application/xml", body: xml };
}

export function formatIamXmlError(error: AwsErrorSpec): ErrorResponse {
  const xml =
    `<ErrorResponse><Error>` +
    `<Type>Sender</Type>` +
    `<Code>${error.type}</Code>` +
    `<Message>${error.message}</Message>` +
    `</Error><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ErrorResponse>`;
  return { statusCode: resolveStatusCode(error), contentType: "text/xml", body: xml };
}

export function formatError(error: AwsErrorSpec, fmt: ErrorFormat): ErrorResponse {
  if (fmt === "json") return formatJsonError(error);
  if (fmt === "xml_s3") return formatS3XmlError(error);
  return formatIamXmlError(error);
}
