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
        self.policy: str | None = None


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
    """In-memory store for all S3 Tables resources.

    Table buckets are keyed by their ARN.  The helper
    :meth:`get_bucket` also accepts a bare bucket name so that
    callers that receive either form can resolve the bucket without
    special-casing.
    """

    def __init__(self) -> None:
        self.table_buckets: dict[str, _TableBucket] = {}

    def get_bucket(self, arn_or_name: str) -> _TableBucket | None:
        """Look up a bucket by ARN or by bare name.

        Boto3 initially calls GetTableBucket with the bucket name, then
        uses the returned ARN for all subsequent calls.  Both forms must
        resolve to the same bucket.
        """
        # Direct ARN lookup
        if arn_or_name in self.table_buckets:
            return self.table_buckets[arn_or_name]
        # Fall back: search by name (used when caller only has the bare name)
        for bucket in self.table_buckets.values():
            if bucket.name == arn_or_name:
                return bucket
        return None

    def reset(self) -> None:
        """Clear all table buckets, namespaces, and tables."""
        self.table_buckets.clear()
