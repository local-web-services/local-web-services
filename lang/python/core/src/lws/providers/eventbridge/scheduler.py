"""Scheduled rule execution for EventBridge.

Parses AWS cron and rate expressions and runs background asyncio tasks
that fire events at the specified intervals.
"""

from __future__ import annotations

import asyncio
import logging
import time
from collections.abc import Callable, Coroutine
from dataclasses import dataclass

from croniter import croniter

logger = logging.getLogger(__name__)


@dataclass
class ScheduledRule:
    """A scheduled rule with its parsed schedule and callback."""

    rule_name: str
    schedule_expression: str
    callback: Callable[[], Coroutine]
    enabled: bool = True


def parse_rate_expression(expression: str) -> float:
    """Parse an AWS rate expression and return the interval in seconds.

    Supported formats::

        rate(1 minute)
        rate(5 minutes)
        rate(1 hour)
        rate(12 hours)
        rate(1 day)
        rate(7 days)

    Parameters
    ----------
    expression:
        The full rate expression string, e.g. ``"rate(5 minutes)"``.

    Returns
    -------
    float
        The interval in seconds.

    Raises
    ------
    ValueError
        If the expression cannot be parsed.
    """
    inner = _extract_inner(expression, "rate")
    parts = inner.strip().split()
    if len(parts) != 2:
        raise ValueError(f"Invalid rate expression: {expression}")

    value = int(parts[0])
    unit = parts[1].rstrip("s").lower()

    multipliers = {
        "minute": 60,
        "hour": 3600,
        "day": 86400,
    }

    if unit not in multipliers:
        raise ValueError(f"Unknown rate unit: {parts[1]} in {expression}")

    return float(value * multipliers[unit])


def parse_cron_expression(expression: str) -> str:
    """Convert an AWS cron expression to a standard five-field cron expression.

    AWS EventBridge cron format has six fields::

        cron(minutes hours day-of-month month day-of-week year)

    Standard cron has five fields::

        minutes hours day-of-month month day-of-week

    Parameters
    ----------
    expression:
        The full cron expression string, e.g.
        ``"cron(0 12 * * ? *)"``

    Returns
    -------
    str
        A standard five-field cron expression.

    Raises
    ------
    ValueError
        If the expression cannot be parsed.
    """
    inner = _extract_inner(expression, "cron")
    fields = inner.strip().split()
    if len(fields) != 6:
        raise ValueError(
            f"Expected 6 fields in AWS cron expression, got {len(fields)}: {expression}"
        )

    # Drop the year field (last)
    fields = fields[:5]

    # Replace AWS '?' with '*' (standard cron doesn't use '?')
    fields = [f.replace("?", "*") for f in fields]

    return " ".join(fields)


def get_next_fire_time(expression: str, base_time: float | None = None) -> float:
    """Return the next fire time as a Unix timestamp.

    Parameters
    ----------
    expression:
        An AWS schedule expression (``rate(...)`` or ``cron(...)``).
    base_time:
        The reference time as a Unix timestamp. Defaults to now.

    Returns
    -------
    float
        The next fire time as a Unix timestamp.
    """
    now = base_time if base_time is not None else time.time()

    if expression.startswith("rate("):
        interval = parse_rate_expression(expression)
        return now + interval

    if expression.startswith("cron("):
        standard_cron = parse_cron_expression(expression)
        cron = croniter(standard_cron, now)
        return cron.get_next(float)

    raise ValueError(f"Unsupported schedule expression: {expression}")


def _extract_inner(expression: str, prefix: str) -> str:
    """Extract the contents between parentheses from an expression."""
    stripped = expression.strip()
    expected_start = f"{prefix}("
    if not stripped.startswith(expected_start) or not stripped.endswith(")"):
        raise ValueError(f"Expected '{prefix}(...)' format, got: {expression}")
    return stripped[len(expected_start) : -1]


class ScheduleRunner:
    """Manages background tasks that fire scheduled EventBridge rules.

    Each scheduled rule gets its own asyncio task that sleeps until the
    next fire time, invokes the callback, then computes the next fire time.
    """

    def __init__(self) -> None:
        self._tasks: dict[str, asyncio.Task] = {}
        self._running = False

    async def start(self, rules: list[ScheduledRule]) -> None:
        """Start background tasks for all scheduled rules."""
        self._running = True
        for rule in rules:
            if not rule.enabled:
                continue
            task = asyncio.create_task(self._run_schedule(rule))
            self._tasks[rule.rule_name] = task

    async def stop(self) -> None:
        """Cancel all scheduled tasks and wait for them to finish."""
        self._running = False
        for task in self._tasks.values():
            task.cancel()
        for task in self._tasks.values():
            try:
                await task
            except asyncio.CancelledError:
                pass
        self._tasks.clear()

    async def _run_schedule(self, rule: ScheduledRule) -> None:
        """Run a single scheduled rule in a loop."""
        try:
            while self._running:
                delay = self._compute_delay(rule.schedule_expression)
                await asyncio.sleep(delay)
                if not self._running:
                    break
                try:
                    await rule.callback()
                except Exception:
                    logger.exception(
                        "Error executing scheduled rule %s",
                        rule.rule_name,
                    )
        except asyncio.CancelledError:
            return

    def _compute_delay(self, expression: str) -> float:
        """Compute the number of seconds until the next fire time."""
        next_time = get_next_fire_time(expression)
        delay = next_time - time.time()
        return max(0.1, delay)
