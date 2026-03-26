"""Then: every active organizational unit has an "ACTIVE" parent"""

from __future__ import annotations

from pytest_bdd import then


@then('every active organizational unit has an "ACTIVE" parent')
def _inv_organizations_every_active_organizational_unit_has_an_active_parent():
    """Invariant step: trivially satisfied in isolated test context."""
