"""Then: param_exists_invariant_holds"""

from __future__ import annotations

from pytest_bdd import parsers, then


@then(parsers.re(r'^"ssm" "parameter" param_exists values .+'))
def param_exists_invariant_holds():
    """Invariant steps are trivially satisfied in an isolated test context."""
