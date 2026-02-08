"""Permission validator using application graph edges.

Checks that a handler has the appropriate permission edges to the target
resource for the requested operation. Uses ``EdgeType.PERMISSION`` edges
from the AppGraph to determine access.

Grant semantics:
  - ``grantRead``  -> allows get, query, scan
  - ``grantWrite`` -> allows put, delete
  - ``grantReadWrite`` -> allows all operations
"""

from __future__ import annotations

from ldk.graph.builder import EdgeType
from ldk.validation.engine import (
    ValidationContext,
    ValidationIssue,
    ValidationLevel,
    Validator,
)

# Maps grant types to the set of operations they allow.
_READ_OPS = frozenset({"get", "query", "scan", "get_item", "batch_get_items"})
_WRITE_OPS = frozenset({"put", "delete", "put_item", "delete_item", "update_item", "batch_write"})

_GRANT_ALLOWED_OPS: dict[str, frozenset[str]] = {
    "grantRead": _READ_OPS,
    "grantWrite": _WRITE_OPS,
    "grantReadWrite": _READ_OPS | _WRITE_OPS,
}


class PermissionValidator(Validator):
    """Validates that a handler has permission to perform an operation on a resource."""

    @property
    def name(self) -> str:
        return "permission"

    def validate(self, context: ValidationContext) -> list[ValidationIssue]:
        """Check permission edges in the application graph."""
        if context.app_graph is None:
            return []

        grants = _find_grants(context)
        if not grants:
            return [
                _no_permission_issue(context),
            ]

        operation = context.operation.lower()
        if _operation_allowed(grants, operation):
            return []

        return [
            _insufficient_permission_issue(context, grants),
        ]


def _find_grants(context: ValidationContext) -> list[str]:
    """Find all permission grants from handler to resource."""
    assert context.app_graph is not None
    grants: list[str] = []
    for edge in context.app_graph.edges:
        if (
            edge.edge_type == EdgeType.PERMISSION
            and edge.source == context.handler_id
            and edge.target == context.resource_id
        ):
            grant_type = edge.metadata.get("grant_type", "")
            if grant_type:
                grants.append(grant_type)
    return grants


def _operation_allowed(grants: list[str], operation: str) -> bool:
    """Check whether any of the grants allow the given operation."""
    for grant in grants:
        allowed = _GRANT_ALLOWED_OPS.get(grant, frozenset())
        if operation in allowed:
            return True
    return False


def _no_permission_issue(context: ValidationContext) -> ValidationIssue:
    """Create an issue for missing permission edges."""
    return ValidationIssue(
        level=ValidationLevel.ERROR,
        message=(
            f"Handler '{context.handler_id}' has no permission grant "
            f"to resource '{context.resource_id}'"
        ),
        resource=context.resource_id,
        operation=context.operation,
    )


def _insufficient_permission_issue(
    context: ValidationContext, grants: list[str]
) -> ValidationIssue:
    """Create an issue for insufficient permission grants."""
    return ValidationIssue(
        level=ValidationLevel.ERROR,
        message=(
            f"Handler '{context.handler_id}' has grants {grants} "
            f"which do not allow '{context.operation}' on '{context.resource_id}'"
        ),
        resource=context.resource_id,
        operation=context.operation,
    )
