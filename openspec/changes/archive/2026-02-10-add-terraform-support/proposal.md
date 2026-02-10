# Change: Add Terraform / OpenTofu project support

## Why

LWS currently only works with AWS CDK projects — it parses `cdk.out` to discover resources and pre-creates them locally. Developers using Terraform or OpenTofu to define their AWS infrastructure have no way to use LWS. Since LWS now supports always-on HTTP services with full management operations (CreateTable, CreateQueue, etc.), the infrastructure is in place to let Terraform's AWS provider talk directly to LWS endpoints. We just need to wire it up.

## What Changes

- `lws dev` SHALL detect Terraform projects (presence of `.tf` files, absence of `cdk.out`) and start in Terraform mode
- In Terraform mode, LWS SHALL start all service providers in always-on mode (no resource pre-creation) and generate a `_lws_override.tf` file that redirects the AWS provider's endpoints to local LWS ports
- The override file SHALL be cleaned up on shutdown and added to `.gitignore` if not already present
- A new `--mode` flag on `lws dev` SHALL allow explicitly selecting `cdk` or `terraform` mode
- Terraform mode SHALL also work with OpenTofu (identical provider configuration)
- Missing API operations that Terraform commonly calls (TagResource, ListTagsForResource, UpdateTable, etc.) SHALL be stubbed as no-ops to prevent `terraform apply` from failing on unimplemented operations

## Impact

- Affected specs: `cli`, `configuration`
- Affected code: `src/lws/cli/ldk.py` (dev command, project detection), new module `src/lws/terraform/override.py`, provider routes (stub handlers for missing operations)
- No breaking changes to existing CDK workflow
