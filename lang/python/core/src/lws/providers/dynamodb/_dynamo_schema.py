"""DynamoDB schema helpers: key extraction, GSI projection, table description, stream helpers.

All implementations live in :mod:`lws.providers.dynamodb._provider_helpers`.
This module re-exports them for backward compatibility.
"""

from lws.providers.dynamodb._provider_helpers import (  # noqa: F401
    _build_keys_dict,
    _extract_key_names,
    _extract_key_value,
    _extract_sk,
    _find_gsi,
    _project_item_for_gsi,
    apply_gsi_projection,
    build_table_description as _build_table_description,
    delete_gsi_entry,
    emit_delete_stream_event,
    emit_stream_event,
    fetch_item_json,
    update_gsi_entry,
)
