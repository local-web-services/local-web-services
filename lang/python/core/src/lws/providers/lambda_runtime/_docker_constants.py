"""Constants and configuration for the Docker-based Lambda runtime provider."""

from __future__ import annotations

# AWS Lambda allocates 1 vCPU per 1769 MB of memory.
MB_PER_VCPU = 1769

# Minimum CPU allocation in nano-CPUs (128 millicores).
MIN_NANO_CPUS = 128_000_000

# Runtime → Docker image mapping (official AWS Lambda base images from ECR Public).
RUNTIME_IMAGES: dict[str, str] = {
    "nodejs18.x": "public.ecr.aws/lambda/nodejs:18",
    "nodejs20.x": "public.ecr.aws/lambda/nodejs:20",
    "nodejs22.x": "public.ecr.aws/lambda/nodejs:22",
    "python3.9": "public.ecr.aws/lambda/python:3.9",
    "python3.10": "public.ecr.aws/lambda/python:3.10",
    "python3.11": "public.ecr.aws/lambda/python:3.11",
    "python3.12": "public.ecr.aws/lambda/python:3.12",
    "python3.13": "public.ecr.aws/lambda/python:3.13",
}

# EOL runtimes that are no longer supported.
EOL_RUNTIMES: set[str] = {"nodejs14.x", "nodejs16.x", "python3.8"}
