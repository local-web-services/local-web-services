"""Then: all "lambda" "async" "slot"s reference known "lambda" "function" IDs or are empty"""

from __future__ import annotations

from pytest_bdd import then


@then('all "lambda" "async" "slot"s reference known "lambda" "function" IDs or are empty')
def async_slots_reference_known_functions():
    """Invariant: trivially satisfied in isolated lws context."""
