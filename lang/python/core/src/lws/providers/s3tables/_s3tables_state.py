"""In-memory state classes for the S3 Tables provider."""

from __future__ import annotations

from datetime import UTC, datetime

_ACCOUNT_ID = "000000000000"
_REGION = "us-east-1"


class _Table:
    """Represents a single table within a namespace."""

    def __init__(self, name: str, namespace: str, table_bucket_arn: str, fmt: str) -> None:
        self.name = name
        self.namespace = namespace
        self.table_bucket_arn = table_bucket_arn
        self.format = fmt
        self.arn = f"{table_bucket_arn}/table/{namespace}/{name}"
        self.created_date = datetime.now(UTC).isoformat()


class _Namespace:
    """Represents a namespace within a table bucket."""

    def __init__(self, namespace: list[str], table_bucket_arn: str) -> None:
        self.namespace = namespace
        self.table_bucket_arn = table_bucket_arn
        self.created_date = datetime.now(UTC).isoformat()
        self.tables: dict[str, _Table] = {}


class _TableBucket:
    """Represents a table bucket."""

    def __init__(self, name: str) -> None:
        self.name = name
        self.arn = f"arn:aws:s3tables:{_REGION}:{_ACCOUNT_ID}:bucket/{name}"
        self.created_date = datetime.now(UTC).isoformat()
        self.namespaces: dict[str, _Namespace] = {}


class _S3TablesState:
    """In-memory store for all S3 Tables resources."""

    def __init__(self) -> None:
        self.table_buckets: dict[str, _TableBucket] = {}
