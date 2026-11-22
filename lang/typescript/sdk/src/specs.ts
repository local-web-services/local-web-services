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

export type ResourceSpec =
  | DynamoTable
  | SqsQueue
  | S3Bucket
  | SnsTopic
  | SsmParameter
  | Secret
  | StateMachine;
