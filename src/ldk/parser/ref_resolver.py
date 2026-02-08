"""CloudFormation intrinsic-function and Ref resolver.

Walks an arbitrary JSON value tree and replaces intrinsic functions
(``Ref``, ``Fn::GetAtt``, ``Fn::Sub``, ``Fn::Join``, ``Fn::Select``,
``Fn::If``) with deterministic local values so that downstream stages
can work with concrete strings.
"""

from __future__ import annotations

import logging
import re
from typing import Any

logger = logging.getLogger(__name__)

# Pseudo-parameters that CDK templates commonly reference.
_PSEUDO_PARAMS: dict[str, str] = {
    "AWS::AccountId": "000000000000",
    "AWS::Region": "local",
    "AWS::StackId": "arn:ldk:cloudformation:local:000000000000:stack/local-stack/00000000",
    "AWS::StackName": "local-stack",
    "AWS::URLSuffix": "localhost",
    "AWS::NoValue": "",
    "AWS::Partition": "aws",
}

# Mapping from CFN resource type -> (service, resource-type-slug) used when
# generating deterministic ARNs.
_SERVICE_MAP: dict[str, tuple[str, str]] = {
    "AWS::Lambda::Function": ("lambda", "function"),
    "AWS::DynamoDB::Table": ("dynamodb", "table"),
    "AWS::SQS::Queue": ("sqs", "queue"),
    "AWS::SNS::Topic": ("sns", "topic"),
    "AWS::S3::Bucket": ("s3", "bucket"),
    "AWS::ApiGateway::RestApi": ("apigateway", "restapi"),
    "AWS::ApiGatewayV2::Api": ("apigateway", "httpapi"),
    "AWS::StepFunctions::StateMachine": ("states", "stateMachine"),
    "AWS::IAM::Role": ("iam", "role"),
    "AWS::Events::Rule": ("events", "rule"),
}


class RefResolver:
    """Resolve CloudFormation intrinsic functions to local placeholder values.

    Parameters
    ----------
    resource_map:
        ``logical_id -> local_value`` overrides supplied by the caller.
        If a logical ID is not present here the resolver will synthesise a
        deterministic ARN-style string.
    resource_types:
        ``logical_id -> AWS::* resource type`` mapping used to generate
        service-aware ARNs.
    conditions:
        ``condition_name -> bool`` mapping for ``Fn::If`` resolution.
    """

    def __init__(
        self,
        resource_map: dict[str, str] | None = None,
        resource_types: dict[str, str] | None = None,
        conditions: dict[str, bool] | None = None,
    ) -> None:
        self.resource_map: dict[str, str] = dict(resource_map or {})
        self.resource_types: dict[str, str] = dict(resource_types or {})
        self.conditions: dict[str, bool] = dict(conditions or {})

    # ------------------------------------------------------------------
    # Public API
    # ------------------------------------------------------------------

    def resolve(self, value: Any) -> Any:
        """Walk *value* and resolve all intrinsic functions recursively."""
        if isinstance(value, dict):
            return self._resolve_dict(value)
        if isinstance(value, list):
            return [self.resolve(item) for item in value]
        return value

    # ------------------------------------------------------------------
    # Internal dispatch
    # ------------------------------------------------------------------

    def _resolve_dict(self, d: dict) -> Any:
        # Single-key dicts may be intrinsic functions
        if len(d) == 1:
            key = next(iter(d))
            handler = self._intrinsic_handlers.get(key)
            if handler is not None:
                return handler(self, d[key])

        # Otherwise resolve every value inside the dict
        return {k: self.resolve(v) for k, v in d.items()}

    # ------------------------------------------------------------------
    # Intrinsic implementations
    # ------------------------------------------------------------------

    def _resolve_ref(self, logical_id: Any) -> str:
        logical_id = str(logical_id)
        if logical_id in _PSEUDO_PARAMS:
            return _PSEUDO_PARAMS[logical_id]
        if logical_id in self.resource_map:
            return self.resource_map[logical_id]
        return self._make_arn(logical_id)

    def _resolve_get_att(self, args: Any) -> str:
        if isinstance(args, list) and len(args) >= 2:
            logical_id = str(args[0])
            attribute = str(args[1])
            if logical_id in self.resource_map:
                return f"{self.resource_map[logical_id]}.{attribute}"
            return f"{self._make_arn(logical_id)}.{attribute}"
        if isinstance(args, str) and "." in args:
            logical_id, attribute = args.split(".", 1)
            if logical_id in self.resource_map:
                return f"{self.resource_map[logical_id]}.{attribute}"
            return f"{self._make_arn(logical_id)}.{attribute}"
        logger.warning("Unresolvable Fn::GetAtt: %s", args)
        return str(args)

    def _resolve_sub(self, value: Any) -> str:
        if isinstance(value, list):
            template_str = str(value[0])
            variables = value[1] if len(value) > 1 and isinstance(value[1], dict) else {}
            # Resolve the variable values first
            resolved_vars = {k: str(self.resolve(v)) for k, v in variables.items()}
        elif isinstance(value, str):
            template_str = value
            resolved_vars = {}
        else:
            logger.warning("Unresolvable Fn::Sub: %s", value)
            return str(value)

        def _replacer(match: re.Match) -> str:
            var_name = match.group(1)
            if var_name in resolved_vars:
                return resolved_vars[var_name]
            if var_name in _PSEUDO_PARAMS:
                return _PSEUDO_PARAMS[var_name]
            if var_name in self.resource_map:
                return self.resource_map[var_name]
            # Could be LogicalId.Attribute
            if "." in var_name:
                lid, attr = var_name.split(".", 1)
                if lid in self.resource_map:
                    return f"{self.resource_map[lid]}.{attr}"
                return f"{self._make_arn(lid)}.{attr}"
            return self._make_arn(var_name)

        return re.sub(r"\$\{([^}]+)\}", _replacer, template_str)

    def _resolve_join(self, args: Any) -> str:
        if not isinstance(args, list) or len(args) != 2:
            logger.warning("Unresolvable Fn::Join: %s", args)
            return str(args)
        delimiter = str(args[0])
        items = args[1]
        if not isinstance(items, list):
            logger.warning("Fn::Join second argument is not a list: %s", items)
            return str(items)
        resolved = [str(self.resolve(item)) for item in items]
        return delimiter.join(resolved)

    def _resolve_select(self, args: Any) -> Any:
        if not isinstance(args, list) or len(args) != 2:
            logger.warning("Unresolvable Fn::Select: %s", args)
            return str(args)
        index = int(args[0])
        items = self.resolve(args[1])
        if isinstance(items, list) and 0 <= index < len(items):
            return items[index]
        logger.warning("Fn::Select index %d out of range for %s", index, items)
        return ""

    def _resolve_if(self, args: Any) -> Any:
        if not isinstance(args, list) or len(args) != 3:
            logger.warning("Unresolvable Fn::If: %s", args)
            return str(args)
        condition_name = str(args[0])
        true_value = args[1]
        false_value = args[2]
        condition_result = self.conditions.get(condition_name, True)
        chosen = true_value if condition_result else false_value
        return self.resolve(chosen)

    # ------------------------------------------------------------------
    # Helpers
    # ------------------------------------------------------------------

    def _make_arn(self, logical_id: str) -> str:
        """Generate a deterministic local ARN for *logical_id*."""
        cfn_type = self.resource_types.get(logical_id, "")
        if cfn_type in _SERVICE_MAP:
            service, res_slug = _SERVICE_MAP[cfn_type]
        else:
            service = "unknown"
            res_slug = "resource"
        return f"arn:ldk:{service}:local:000000000000:{res_slug}/{logical_id}"

    # Dispatch table (class-level)
    _intrinsic_handlers: dict[str, Any] = {
        "Ref": _resolve_ref,
        "Fn::GetAtt": _resolve_get_att,
        "Fn::Sub": _resolve_sub,
        "Fn::Join": _resolve_join,
        "Fn::Select": _resolve_select,
        "Fn::If": _resolve_if,
    }
