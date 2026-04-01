"""Per-account state registry for LWS service providers.

Provides ``PerAccountStateRegistry`` — a lazily-instantiated registry that
maps account IDs to isolated state objects — and the
``extract_account_id_from_token`` helper that decodes the account ID from
an ``lws-acct-{account_id}-{uuid}`` session token.
"""

from __future__ import annotations

import re
from collections.abc import Callable
from typing import Generic, TypeVar

_TOKEN_RE = re.compile(r"^lws-acct-(\d{12})-")

DEFAULT_ACCOUNT_ID = "000000000000"

T = TypeVar("T")


def extract_account_id_from_token(token: str) -> str:
    """Return the account ID embedded in an lws-acct-* session token.

    Falls back to ``DEFAULT_ACCOUNT_ID`` when the token is absent or does
    not follow the ``lws-acct-{account_id}-{uuid}`` format.
    """
    match = _TOKEN_RE.match(token)
    return match.group(1) if match else DEFAULT_ACCOUNT_ID


class PerAccountStateRegistry(Generic[T]):
    """Lazily-instantiated, per-account state registry.

    State is isolated between accounts: reads and writes in account A
    never affect account B.  State for an account is created on the first
    call to ``get`` for that account.

    Args:
        factory: Zero-argument callable that returns a fresh state object.
    """

    def __init__(self, factory: Callable[[], T]) -> None:
        self._factory = factory
        self._accounts: dict[str, T] = {}

    def get(self, account_id: str) -> T:
        """Return (or lazily create) the state for ``account_id``."""
        if account_id not in self._accounts:
            self._accounts[account_id] = self._factory()
        return self._accounts[account_id]
