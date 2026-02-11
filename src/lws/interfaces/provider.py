"""Provider lifecycle and base interface definitions."""

from abc import ABC, abstractmethod
from enum import Enum


class ProviderStatus(Enum):
    """Lifecycle status of a provider."""

    STOPPED = "stopped"
    STARTING = "starting"
    RUNNING = "running"
    ERROR = "error"


class ProviderError(Exception):
    """Base exception for provider-related errors."""


class ProviderStartError(ProviderError):
    """Raised when a provider fails to start."""


class ProviderStopError(ProviderError):
    """Raised when a provider fails to stop."""


class Provider(ABC):
    """Abstract base class for all LDK providers.

    Defines the lifecycle contract that every provider must implement:
    start, stop, health_check, and a name property.
    """

    @property
    @abstractmethod
    def name(self) -> str:
        """Return the unique name of this provider."""

    @abstractmethod
    async def start(self) -> None:
        """Start the provider, making it ready to serve requests."""

    @abstractmethod
    async def stop(self) -> None:
        """Stop the provider and release any resources."""

    @abstractmethod
    async def health_check(self) -> bool:
        """Check whether the provider is healthy and operational."""
