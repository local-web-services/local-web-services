"""SDK endpoint redirection environment builder.

Builds environment variable dictionaries that redirect AWS SDK calls to local
service endpoints provided by LDK.
"""

from __future__ import annotations


def build_sdk_env(endpoints: dict[str, str]) -> dict[str, str]:
    """Build an environment dict that redirects AWS SDK calls to local endpoints.

    For each service in *endpoints*, creates an ``AWS_ENDPOINT_URL_<SERVICE>``
    variable with the service name uppercased.  The returned dict always includes
    dummy AWS credentials and a default region so the SDK never falls back to
    real credentials.

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
    }

    for service_name, url in endpoints.items():
        var_name = f"AWS_ENDPOINT_URL_{service_name.upper()}"
        env[var_name] = url

    return env
