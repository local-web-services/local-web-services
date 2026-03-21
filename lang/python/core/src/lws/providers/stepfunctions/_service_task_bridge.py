"""Service task bridge for Step Functions service integration ARNs.

Dispatches ``arn:aws:states:::service:operation`` resource ARNs to local
in-process provider instances, avoiding HTTP round-trips.

Also contains thin adapters for SSM and SecretsManager state objects so
they can be injected directly into the bridge without HTTP round-trips.
"""

from __future__ import annotations

from typing import Any

_SERVICE_INTEGRATION_PREFIXES = (
    "arn:aws:states:::dynamodb:",
    "arn:aws:states:::sqs:",
    "arn:aws:states:::sns:",
    "arn:aws:states:::s3:",
    "arn:aws:states:::secretsmanager:",
    "arn:aws:states:::ssm:",
    "arn:aws:states:::events:",
)


class ServiceTaskBridge:
    """Dispatches service integration ARNs to local service providers.

    Handles ``arn:aws:states:::service:operation`` patterns by calling
    the appropriate in-process provider method directly.

    Parameters field values with ``.$`` suffix are resolved by the engine
    before this bridge is invoked, so the payload is always a plain dict.
    """

    def __init__(self, service_providers: dict[str, Any]) -> None:
        self._services = service_providers

    def handles(self, resource_arn: str) -> bool:
        """Return True if this bridge can handle the given resource ARN."""
        return resource_arn.startswith(_SERVICE_INTEGRATION_PREFIXES)

    async def invoke(self, resource_arn: str, payload: Any) -> Any:
        """Dispatch a service integration call to the appropriate provider."""
        if "dynamodb:putItem" in resource_arn:
            return await self._invoke_dynamodb_put_item(payload)
        if "dynamodb:getItem" in resource_arn:
            return await self._invoke_dynamodb_get_item(payload)
        if "sqs:sendMessage" in resource_arn:
            return await self._invoke_sqs_send_message(payload)
        if "sns:publish" in resource_arn:
            return await self._invoke_sns_publish(payload)
        if "s3:getObject" in resource_arn:
            return await self._invoke_s3_get_object(payload)
        if "s3:putObject" in resource_arn:
            return await self._invoke_s3_put_object(payload)
        if "secretsmanager:getSecretValue" in resource_arn:
            return await self._invoke_secretsmanager_get_secret_value(payload)
        if "ssm:getParameter" in resource_arn:
            return await self._invoke_ssm_get_parameter(payload)
        if "events:putEvents" in resource_arn:
            return await self._invoke_events_put_events(payload)
        raise RuntimeError(f"Unsupported service integration ARN: {resource_arn}")

    async def _invoke_dynamodb_put_item(self, payload: Any) -> dict:
        """Invoke DynamoDB putItem via the registered provider."""
        dynamodb = self._services.get("dynamodb")
        if dynamodb is None:
            raise RuntimeError("No DynamoDB provider registered for service task bridge")
        params = payload if isinstance(payload, dict) else {}
        table_name = params.get("TableName", "")
        item = params.get("Item", {})
        await dynamodb.put_item(table_name, item)
        return {}

    async def _invoke_dynamodb_get_item(self, payload: Any) -> dict:
        """Invoke DynamoDB getItem via the registered provider."""
        dynamodb = self._services.get("dynamodb")
        if dynamodb is None:
            raise RuntimeError("No DynamoDB provider registered for service task bridge")
        params = payload if isinstance(payload, dict) else {}
        table_name = params.get("TableName", "")
        key = params.get("Key", {})
        item = await dynamodb.get_item(table_name, key)
        if item is None:
            return {"Item": {}}
        return {"Item": item}

    async def _invoke_sqs_send_message(self, payload: Any) -> dict:
        """Invoke SQS sendMessage via the registered provider."""
        sqs = self._services.get("sqs")
        if sqs is None:
            raise RuntimeError("No SQS provider registered for service task bridge")
        params = payload if isinstance(payload, dict) else {}
        queue_url_or_name = params.get("QueueUrl", "")
        queue_name = (
            queue_url_or_name.rsplit("/", 1)[-1] if "/" in queue_url_or_name else queue_url_or_name
        )
        message_body = params.get("MessageBody", "")
        message_id = await sqs.send_message(queue_name=queue_name, message_body=message_body)
        return {"MessageId": message_id}

    async def _invoke_sns_publish(self, payload: Any) -> dict:
        """Invoke SNS publish via the registered provider."""
        sns = self._services.get("sns")
        if sns is None:
            raise RuntimeError("No SNS provider registered for service task bridge")
        params = payload if isinstance(payload, dict) else {}
        topic_arn = params.get("TopicArn", "")
        topic_name = topic_arn.rsplit(":", 1)[-1] if ":" in topic_arn else topic_arn
        message = params.get("Message", "")
        message_id = await sns.publish(topic_name=topic_name, message=message)
        return {"MessageId": message_id}

    async def _invoke_s3_get_object(self, payload: Any) -> dict:
        """Invoke S3 getObject via the registered provider."""
        s3 = self._services.get("s3")
        if s3 is None:
            raise RuntimeError("No S3 provider registered for service task bridge")
        params = payload if isinstance(payload, dict) else {}
        bucket = params.get("Bucket", "")
        key = params.get("Key", "")
        body = await s3.get_object(bucket, key)
        if body is None:
            raise RuntimeError(f"S3 object not found: s3://{bucket}/{key}")
        return {"Body": body.decode("utf-8") if isinstance(body, bytes) else body}

    async def _invoke_s3_put_object(self, payload: Any) -> dict:
        """Invoke S3 putObject via the registered provider."""
        s3 = self._services.get("s3")
        if s3 is None:
            raise RuntimeError("No S3 provider registered for service task bridge")
        params = payload if isinstance(payload, dict) else {}
        bucket = params.get("Bucket", "")
        key = params.get("Key", "")
        body_raw = params.get("Body", "")
        body = body_raw.encode("utf-8") if isinstance(body_raw, str) else body_raw
        await s3.put_object(bucket, key, body)
        return {}

    async def _invoke_secretsmanager_get_secret_value(self, payload: Any) -> dict:
        """Invoke SecretsManager getSecretValue via the registered adapter."""
        secretsmanager = self._services.get("secretsmanager")
        if secretsmanager is None:
            raise RuntimeError("No SecretsManager provider registered for service task bridge")
        params = payload if isinstance(payload, dict) else {}
        secret_id = params.get("SecretId", "")
        return secretsmanager.get_secret_value(secret_id)

    async def _invoke_ssm_get_parameter(self, payload: Any) -> dict:
        """Invoke SSM getParameter via the registered adapter."""
        ssm = self._services.get("ssm")
        if ssm is None:
            raise RuntimeError("No SSM provider registered for service task bridge")
        params = payload if isinstance(payload, dict) else {}
        name = params.get("Name", "")
        return ssm.get_parameter(name)

    async def _invoke_events_put_events(self, payload: Any) -> dict:
        """Invoke EventBridge putEvents via the registered provider."""
        eventbridge = self._services.get("eventbridge")
        if eventbridge is None:
            raise RuntimeError("No EventBridge provider registered for service task bridge")
        params = payload if isinstance(payload, dict) else {}
        entries = params.get("Entries", [])
        results = await eventbridge.put_events(entries)
        return {"Entries": results, "FailedEntryCount": 0}


class _CompositeComputeInvoker:
    """Combines a ServiceTaskBridge with a LambdaComputeBridge.

    Service integration ARNs are dispatched to the service bridge;
    all other ARNs fall through to the Lambda bridge.
    """

    def __init__(
        self,
        service_bridge: ServiceTaskBridge,
        lambda_bridge: Any,
    ) -> None:
        self._service_bridge = service_bridge
        self._lambda_bridge = lambda_bridge

    async def invoke_function(self, resource_arn: str, payload: Any) -> Any:
        """Route to service bridge or Lambda bridge based on the resource ARN."""
        if self._service_bridge.handles(resource_arn):
            return await self._service_bridge.invoke(resource_arn, payload)
        return await self._lambda_bridge.invoke_function(resource_arn, payload)


# ---------------------------------------------------------------------------
# Thin adapters for SSM and SecretsManager state objects
# ---------------------------------------------------------------------------


class SsmStateAdapter:
    """Thin adapter exposing SSM GetParameter directly from in-memory state.

    Wraps ``_SsmState`` so it can be passed to ``ServiceTaskBridge`` without
    going through the HTTP layer.
    """

    def __init__(self, state: Any) -> None:
        self._state = state

    def get_parameter(self, name: str) -> dict:
        """Return a GetParameter-style response dict for the named parameter."""
        param = self._state.parameters.get(name)
        if param is None:
            raise KeyError(f"Parameter not found: {name}")
        return {
            "Parameter": {
                "Name": param.name,
                "Type": param.type,
                "Value": param.value,
                "Version": param.version,
                "ARN": param.arn,
            }
        }


class SecretsManagerStateAdapter:
    """Thin adapter exposing SecretsManager GetSecretValue from in-memory state.

    Wraps ``_SecretsState`` so it can be passed to ``ServiceTaskBridge``
    without going through the HTTP layer.
    """

    def __init__(self, state: Any) -> None:
        self._state = state

    def get_secret_value(self, secret_id: str) -> dict:
        """Return a GetSecretValue-style response dict for the named secret."""
        secret = self._find_secret(secret_id)
        if secret is None or secret.deleted_date is not None:
            raise KeyError(f"Secret not found: {secret_id}")
        version = self._resolve_current_version(secret)
        if version is None:
            raise KeyError(f"No current version for secret: {secret_id}")
        result: dict = {
            "ARN": secret.arn,
            "Name": secret.name,
            "VersionId": version.version_id,
            "VersionStages": version.stages,
        }
        if version.secret_string is not None:
            result["SecretString"] = version.secret_string
        if version.secret_binary is not None:
            result["SecretBinary"] = version.secret_binary
        return result

    def _find_secret(self, secret_id: str) -> Any:
        """Find a secret by name or ARN."""
        secrets = self._state.secrets
        if secret_id in secrets:
            return secrets[secret_id]
        for secret in secrets.values():
            if secret.arn == secret_id:
                return secret
        return None

    def _resolve_current_version(self, secret: Any) -> Any:
        """Return the AWSCURRENT version of a secret."""
        for version in secret.versions.values():
            if "AWSCURRENT" in version.stages:
                return version
        return None
