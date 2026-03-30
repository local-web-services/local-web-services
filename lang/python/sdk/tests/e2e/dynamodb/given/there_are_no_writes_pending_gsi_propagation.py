"""Given: there are no writes pending propagation to the "GSI" """

from __future__ import annotations

from pytest_bdd import given


@given('there are no writes pending propagation to the "GSI"')
def there_are_no_writes_pending_gsi_propagation():
    """No-op: no GSI writes are pending by default."""
