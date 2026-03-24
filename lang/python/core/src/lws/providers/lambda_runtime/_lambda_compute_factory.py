"""Factory for creating ICompute instances from Lambda function configurations."""

from __future__ import annotations

from pathlib import Path
from typing import Any

from lws.logging.logger import get_logger
from lws.providers.lambda_runtime._lambda_code_resolver import (
    resolve_code_path,
    resolve_code_path_from_name,
)

_logger = get_logger("ldk.lambda-mgmt")


def create_compute(
    func_config: dict[str, Any],
    project_dir: Path | None,
    sdk_env: dict[str, str],
) -> Any:
    """Create an ICompute provider from a Lambda function configuration dict."""
    from lws.interfaces import ComputeConfig  # pylint: disable=import-outside-toplevel
    from lws.providers.lambda_runtime.docker import (  # pylint: disable=import-outside-toplevel
        DockerCompute,
    )

    function_name = func_config["FunctionName"]
    runtime = func_config.get("Runtime", "nodejs18.x")
    handler = func_config.get("Handler", "index.handler")
    timeout = func_config.get("Timeout", 3)
    memory_size = func_config.get("MemorySize", 128)
    env_vars = func_config.get("Environment", {}).get("Variables", {})
    code_info = func_config.get("Code", {})
    filename = code_info.get("S3Key") or code_info.get("Filename")
    code_path = resolve_code_path(filename, project_dir)

    if code_path is None and project_dir is not None:
        code_path = resolve_code_path_from_name(function_name, project_dir)

    if code_path is None:
        code_path = Path(".")
        _logger.warning("Could not resolve code path for %s, using cwd", function_name)

    compute_config = ComputeConfig(
        function_name=function_name,
        handler=handler,
        runtime=runtime,
        code_path=code_path,
        timeout=timeout,
        memory_size=memory_size,
        environment=env_vars,
    )

    return DockerCompute(config=compute_config, sdk_env=sdk_env)
