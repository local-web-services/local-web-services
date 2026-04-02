"""Given: the "lambda" "function" tag was set"""

from __future__ import annotations

from pytest_bdd import given


@given('the "lambda" "function" tag was set')
def tag_is_set():
    """No-op: tag already created by 'tag exists on function' step."""
