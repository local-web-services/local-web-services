"""IObjectStore interface for S3-like object storage operations."""

from abc import abstractmethod

from lws.interfaces.provider import Provider


class IObjectStore(Provider):
    """Abstract interface for object store providers (S3-like).

    Implementations provide put, get, delete, and list operations
    against a local or remote object store.
    """

    @abstractmethod
    async def put_object(
        self,
        bucket_name: str,
        key: str,
        body: bytes,
        content_type: str | None = None,
    ) -> None:
        """Store an object in the given bucket under the specified key."""
        ...

    @abstractmethod
    async def get_object(self, bucket_name: str, key: str) -> bytes | None:
        """Retrieve an object by key. Returns None if not found."""
        ...

    @abstractmethod
    async def delete_object(self, bucket_name: str, key: str) -> None:
        """Delete an object by key."""
        ...

    @abstractmethod
    async def list_objects(self, bucket_name: str, prefix: str = "") -> list[str]:
        """List object keys in the bucket matching the given prefix."""
        ...

    @abstractmethod
    async def create_bucket(self, bucket_name: str) -> None:
        """Create a bucket."""
        ...

    @abstractmethod
    async def delete_bucket(self, bucket_name: str) -> None:
        """Delete a bucket."""
        ...

    @abstractmethod
    async def head_bucket(self, bucket_name: str) -> dict:
        """Return bucket metadata dict."""
        ...

    @abstractmethod
    async def list_buckets(self) -> list[str]:
        """Return list of bucket names."""
        ...
