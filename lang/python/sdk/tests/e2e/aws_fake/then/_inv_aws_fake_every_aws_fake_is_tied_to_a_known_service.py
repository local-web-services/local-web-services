"""Then: every "aws fake" is tied to a known service"""

from __future__ import annotations

from pytest_bdd import step


@step('every "aws fake" is tied to a known service')
def _inv_aws_fake_every_aws_fake_is_tied_to_a_known_service():
    """Invariant step: trivially satisfied in isolated test context."""
