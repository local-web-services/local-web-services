/**
 * Typed resource spec classes for LwsSession.
 *
 * Mirrors `lws_testing/_spec.py`.
 */

export class DynamoTable {
  constructor(
    public readonly name: string,
    public readonly hashKey: string,
    public readonly hashKeyType: string = "S",
    public readonly sortKey: string | undefined = undefined,
    public readonly sortKeyType: string = "S",
  ) {}
}

export class SqsQueue {
  constructor(
    public readonly name: string,
    public readonly visibilityTimeout: number = 30,
    public readonly isFifo: boolean = false,
  ) {}
}

export class S3Bucket {
  constructor(public readonly name: string) {}
}

export class SnsTopic {
  constructor(public readonly name: string) {}
}

export class SsmParameter {
  constructor(
    public readonly name: string,
    public readonly value: string = "",
    public readonly type: "String" | "StringList" | "SecureString" = "String",
  ) {}
}

export class Secret {
  constructor(
    public readonly name: string,
    public readonly secretString?: string,
  ) {}
}

export class StateMachine {
  constructor(
    public readonly name: string,
    public readonly definition: string,
    public readonly roleArn: string = "arn:aws:iam::000000000000:role/StepFunctionsRole",
  ) {}
}

export class EventBus {
  constructor(public readonly name: string) {}
}

export class CognitoUserPool {
  constructor(
    public readonly name: string,
    public readonly autoConfirmUsers: boolean = true,
  ) {}
}

export class LambdaFunction {
  constructor(
    public readonly name: string,
    public readonly handler: string = "index.handler",
    public readonly runtime: "nodejs20.x" | "nodejs18.x" | "nodejs16.x" = "nodejs20.x",
    public readonly codeDir?: string,
    public readonly environment: Record<string, string> = {},
    public readonly description: string = "",
  ) {}
}

export type ResourceSpec =
  | DynamoTable
  | SqsQueue
  | S3Bucket
  | SnsTopic
  | SsmParameter
  | Secret
  | StateMachine
  | EventBus
  | CognitoUserPool
  | LambdaFunction;
