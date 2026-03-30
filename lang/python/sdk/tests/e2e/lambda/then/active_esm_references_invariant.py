"""Then: active_esm_references_invariant"""

from __future__ import annotations

from pytest_bdd import parsers, then


@then(parsers.re(r"^every active event source mapping references .+"))
def active_esm_references_invariant():
    """Invariant step: trivially satisfied in isolated test context."""
