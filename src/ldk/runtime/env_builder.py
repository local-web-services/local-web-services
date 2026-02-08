"""Lambda environment variable resolution and injection.

Builds the full environment dict for a Lambda function invocation by merging
the function's own env vars, resolved CloudFormation references, SDK endpoint
redirections, and standard Lambda runtime variables.
"""

from __future__ import annotations

import json

from ldk.runtime.sdk_env import build_sdk_env


def build_lambda_env(
    function_name: str,
    function_env: dict[str, str],
    local_endpoints: dict[str, str],
    resolved_refs: dict[str, str],
) -> dict[str, str]:
    """Build the complete environment dict for a Lambda invocation.

    Args:
        function_name: The Lambda function name.
        function_env: Environment variables defined in the CDK Lambda construct.
        local_endpoints: Mapping of service names to local endpoint URLs
                         (forwarded to :func:`build_sdk_env`).
        resolved_refs: Mapping of CloudFormation reference placeholders to
                       their resolved local values.

    Returns:
        A merged dict ready to be passed as the subprocess environment.
    """
    # Start with a copy of the function-level env vars.
    env: dict[str, str] = {}
    for key, value in function_env.items():
        env[key] = _resolve_value(value, resolved_refs)

    # Merge SDK endpoint redirection vars (overrides function_env if overlapping).
    sdk_env = build_sdk_env(local_endpoints)
    env.update(sdk_env)

    # Standard Lambda runtime variables.
    env["AWS_LAMBDA_FUNCTION_NAME"] = function_name
    env["AWS_LAMBDA_FUNCTION_VERSION"] = "$LATEST"
    env["AWS_LAMBDA_FUNCTION_MEMORY_SIZE"] = "128"
    env["AWS_REGION"] = "us-east-1"
    env["AWS_DEFAULT_REGION"] = "us-east-1"

    return env


def _resolve_value(value: str, resolved_refs: dict[str, str]) -> str:
    """Replace CloudFormation reference placeholders in *value*.

    If the value itself is a key in *resolved_refs*, return the resolved value.
    Also handles JSON-encoded CloudFormation intrinsic references like
    ``{"Ref": "MyResource"}`` by checking the resource name in *resolved_refs*.
    """
    # Direct match -- the value is a known placeholder.
    if value in resolved_refs:
        return resolved_refs[value]

    # JSON-encoded Ref (e.g. '{"Ref": "MyTable"}')
    try:
        parsed = json.loads(value)
        if isinstance(parsed, dict) and "Ref" in parsed:
            ref_name = parsed["Ref"]
            if ref_name in resolved_refs:
                return resolved_refs[ref_name]
    except (json.JSONDecodeError, TypeError):
        pass

    return value
