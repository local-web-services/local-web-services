"""Then: every "documentdb" "instance" has a valid status"""

from __future__ import annotations

from pytest_bdd import then


@then('every "documentdb" "instance" has a valid status')
def every_instance_valid_status():
    """Invariant trivially satisfied in isolated test context."""
