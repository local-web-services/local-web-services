"""Given: targets are removed from an "eventbridge" "rule" """

from __future__ import annotations

from pytest_bdd import given


@given('targets are removed from an "eventbridge" "rule"')
def events_targets_have_been_removed():
    """No-op: fresh state has no targets, simulates previously removed targets."""
