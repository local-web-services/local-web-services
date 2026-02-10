"""SDK endpoint redirection environment builder.

Builds environment variable dictionaries that redirect AWS SDK calls to local
service endpoints provided by LDK.
"""

from __future__ import annotations


_SERVICE_ID_MAP: dict[str, str] = {
    "secretsmanager": "SECRETS_MANAGER",
    "stepfunctions": "SFN",
    "cognito-idp": "COGNITO_IDENTITY_PROVIDER",
    "events": "EVENTBRIDGE",
}


def build_sdk_env(endpoints: dict[str, str]) -> dict[str, str]:
    """Build an environment dict that redirects AWS SDK calls to local endpoints.

    For each service in *endpoints*, creates an ``AWS_ENDPOINT_URL_<SERVICE>``
    variable using the AWS SDK's canonical service ID.  The returned dict always
    includes dummy AWS credentials and a default region so the SDK never falls
    back to real credentials.

    Args:
        endpoints: Mapping of lowercase service names to their local URLs.
                   For example: ``{"dynamodb": "http://localhost:4566"}``.

    Returns:
        A dict of environment variable names to values.
    """
    env: dict[str, str] = {
        "AWS_ACCESS_KEY_ID": "ldk-local",
        "AWS_SECRET_ACCESS_KEY": "ldk-local",
        "AWS_DEFAULT_REGION": "us-east-1",
        "AWS_REGION": "us-east-1",
    }

    for service_name, url in endpoints.items():
        sdk_id = _SERVICE_ID_MAP.get(service_name, service_name.upper())
        var_name = f"AWS_ENDPOINT_URL_{sdk_id}"
        env[var_name] = url

    return env
