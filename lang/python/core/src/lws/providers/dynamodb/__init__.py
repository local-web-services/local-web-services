"""SQLite-backed DynamoDB provider."""

from lws.providers.dynamodb.provider import SqliteDynamoProvider
from lws.providers.dynamodb.streams import StreamConfiguration, StreamDispatcher, StreamViewType

__all__ = [
    "SqliteDynamoProvider",
    "StreamConfiguration",
    "StreamDispatcher",
    "StreamViewType",
]
