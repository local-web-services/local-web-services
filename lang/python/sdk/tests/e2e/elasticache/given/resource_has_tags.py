"""Given: the "elasticache" "resource" has tags"""

from __future__ import annotations

from pytest_bdd import given


@given('the "elasticache" "resource" has tags')
def resource_has_tags():
    """No-op: resource tag state is managed by test setup."""
