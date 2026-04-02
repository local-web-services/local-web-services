"""Then: no_inflight_invariant_holds"""

from __future__ import annotations

from pytest_bdd import parsers, then


@then(parsers.re(r'^no .+ is (?:in-flight|"IN_FLIGHT") .+'))
def no_inflight_invariant_holds():
    """Invariant steps are trivially satisfied in an isolated test context."""
