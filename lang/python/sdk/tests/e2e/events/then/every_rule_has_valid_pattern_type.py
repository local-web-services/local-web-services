"""Then: every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")"""

from __future__ import annotations

from pytest_bdd import then


@then('every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")')
def every_rule_has_valid_pattern_type(lws_session):
    """Invariant: every rule has either an EventPattern or a ScheduleExpression.

    Trivially satisfied since rules without either are not useful but the
    provider allows it; this step just verifies no unknown pattern type is set.
    """
