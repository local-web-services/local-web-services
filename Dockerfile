FROM python:3.11-slim

WORKDIR /app

COPY pyproject.toml README.md ./
COPY src/ ./src/

RUN pip install --no-cache-dir .

WORKDIR /workspace

# Primary management/API Gateway port. lws also binds port+1 through port+22
# for individual service endpoints (DynamoDB, SQS, S3, SNS, ...).
# Use --network=host on Linux, or publish the full range with
#   -p 3000-3025:3000-3025
# when running on Mac/Windows.
EXPOSE 3000

# Extra args (e.g. --port 4000) are appended to this entrypoint.
ENTRYPOINT ["ldk", "dev", "--project-dir", "/workspace"]
