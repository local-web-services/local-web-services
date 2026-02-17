"""Shared chaos engineering helpers used by both AWS and mock server middleware."""

from __future__ import annotations

import asyncio
import random


async def apply_chaos_latency(latency_min_ms: int, latency_max_ms: int) -> None:
    """Inject random latency between min and max milliseconds."""
    if latency_max_ms > 0:
        delay = random.uniform(latency_min_ms, latency_max_ms)
        await asyncio.sleep(delay / 1000.0)


def should_inject_error(error_rate: float) -> bool:
    """Return True if an error should be injected based on the error rate."""
    return error_rate > 0 and random.random() < error_rate
