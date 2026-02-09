"""LDK interfaces -- ABCs, dataclasses, enums, and exceptions.

All public symbols are re-exported here so consumers can do:

    from lws.interfaces import Provider, ICompute, LambdaContext, ...
"""

from lws.interfaces.compute import (
    ComputeConfig,
    ICompute,
    InvocationResult,
    LambdaContext,
)
from lws.interfaces.event_bus import IEventBus
from lws.interfaces.key_value_store import (
    GsiDefinition,
    IKeyValueStore,
    KeyAttribute,
    KeySchema,
    TableConfig,
)
from lws.interfaces.object_store import IObjectStore
from lws.interfaces.provider import (
    Provider,
    ProviderError,
    ProviderStartError,
    ProviderStatus,
    ProviderStopError,
)
from lws.interfaces.queue import IQueue
from lws.interfaces.state_machine import IStateMachine

__all__ = [
    # provider.py
    "Provider",
    "ProviderError",
    "ProviderStartError",
    "ProviderStatus",
    "ProviderStopError",
    # compute.py
    "ComputeConfig",
    "ICompute",
    "InvocationResult",
    "LambdaContext",
    # key_value_store.py
    "GsiDefinition",
    "IKeyValueStore",
    "KeyAttribute",
    "KeySchema",
    "TableConfig",
    # queue.py
    "IQueue",
    # object_store.py
    "IObjectStore",
    # event_bus.py
    "IEventBus",
    # state_machine.py
    "IStateMachine",
]
