package tests

import (
	"context"
	"fmt"
	"net/http"
	"os"
	"strings"
	"testing"
	"time"

	"github.com/cucumber/godog"
	core "github.com/local-web-services/local-web-services-go-core/lws"
)

func TestMain(m *testing.M) {
	var err error
	sharedServer, err = core.StartServer(basePort)
	if err != nil {
		fmt.Printf("Failed to start server: %v\n", err)
		os.Exit(1)
	}

	if err := awaitReady(); err != nil {
		fmt.Printf("Server not ready: %v\n", err)
		sharedServer.Close()
		os.Exit(1)
	}

	opts := godog.Options{
		Format: "pretty",
		Tags:   "@minimal,@standard&&~@internal,@capacity&&~@lifecycle&&~@internal",
		Paths: []string{
			"../../../../lang/specification/sdk/features",
			"../../../../lang/specification/core/informal/sns_sqs/sequences.feature",
			"../../../../lang/specification/core/informal/events_sqs/sequences.feature",
			"../../../../lang/specification/core/informal/events_sns/sequences.feature",
			"../../../../lang/specification/core/informal/events_dynamodb/sequences.feature",
			"../../../../lang/specification/core/informal/events_stepfunctions/sequences.feature",
			"../../../../lang/specification/core/informal/s3api_sns/sequences.feature",
			"../../../../lang/specification/core/informal/s3api_sqs/sequences.feature",
			"../../../../lang/specification/core/informal/s3api_events/sequences.feature",
			"../../../../lang/specification/core/informal/stepfunctions_sqs/sequences.feature",
			"../../../../lang/specification/core/informal/stepfunctions_dynamodb/sequences.feature",
			"../../../../lang/specification/core/informal/stepfunctions_sns/sequences.feature",
			"../../../../lang/specification/core/informal/stepfunctions_s3api/sequences.feature",
			"../../../../lang/specification/core/informal/stepfunctions_secretsmanager/sequences.feature",
			"../../../../lang/specification/core/informal/stepfunctions_ssm/sequences.feature",
			"../../../../lang/specification/core/informal/stepfunctions_events/sequences.feature",
			"../../../../lang/specification/core/informal/secretsmanager_events/sequences.feature",
			"../../../../lang/specification/core/informal/ssm_events/sequences.feature",
			// SQS service feature files
			"../../../../lang/specification/core/informal/sqs/create_queue.feature",
			"../../../../lang/specification/core/informal/sqs/delete_queue.feature",
			"../../../../lang/specification/core/informal/sqs/send_message.feature",
			"../../../../lang/specification/core/informal/sqs/receive_message.feature",
			"../../../../lang/specification/core/informal/sqs/delete_message.feature",
			"../../../../lang/specification/core/informal/sqs/change_message_visibility.feature",
			"../../../../lang/specification/core/informal/sqs/purge_queue.feature",
			"../../../../lang/specification/core/informal/sqs/get_queue_attributes.feature",
			"../../../../lang/specification/core/informal/sqs/visibility_timeout_expires.feature",
			"../../../../lang/specification/core/informal/sqs/redrive_to_dead_letter_queue.feature",
			// SNS service feature files
			"../../../../lang/specification/core/informal/sns/create_topic.feature",
			"../../../../lang/specification/core/informal/sns/delete_topic.feature",
			"../../../../lang/specification/core/informal/sns/subscribe.feature",
			"../../../../lang/specification/core/informal/sns/unsubscribe.feature",
			"../../../../lang/specification/core/informal/sns/publish.feature",
			"../../../../lang/specification/core/informal/sns/confirm_subscription.feature",
			"../../../../lang/specification/core/informal/sns/delivery_succeeds.feature",
			"../../../../lang/specification/core/informal/sns/delivery_fails.feature",
			"../../../../lang/specification/core/informal/sns/retry_exhausted.feature",
			"../../../../lang/specification/core/informal/sns/confirmation_token_expires.feature",
			// S3api service feature files
			"../../../../lang/specification/core/informal/s3api/create_bucket.feature",
			"../../../../lang/specification/core/informal/s3api/delete_bucket.feature",
			"../../../../lang/specification/core/informal/s3api/list_buckets.feature",
			"../../../../lang/specification/core/informal/s3api/put_bucket_versioning.feature",
			"../../../../lang/specification/core/informal/s3api/put_object.feature",
			"../../../../lang/specification/core/informal/s3api/get_object.feature",
			"../../../../lang/specification/core/informal/s3api/delete_object.feature",
			"../../../../lang/specification/core/informal/s3api/head_object.feature",
			"../../../../lang/specification/core/informal/s3api/list_objects_v2.feature",
			"../../../../lang/specification/core/informal/s3api/copy_object.feature",
			"../../../../lang/specification/core/informal/s3api/create_multipart_upload.feature",
			"../../../../lang/specification/core/informal/s3api/upload_part.feature",
			"../../../../lang/specification/core/informal/s3api/complete_multipart_upload.feature",
			"../../../../lang/specification/core/informal/s3api/abort_multipart_upload.feature",
			"../../../../lang/specification/core/informal/s3api/delete_bucket_requires_empty.feature",
			"../../../../lang/specification/core/informal/s3api/lifecycle_expire_object.feature",
			// SSM service feature files
			"../../../../lang/specification/core/informal/ssm/put_parameter_create.feature",
			"../../../../lang/specification/core/informal/ssm/get_parameter.feature",
			"../../../../lang/specification/core/informal/ssm/delete_parameter.feature",
			"../../../../lang/specification/core/informal/ssm/delete_parameters.feature",
			"../../../../lang/specification/core/informal/ssm/describe_parameters.feature",
			"../../../../lang/specification/core/informal/ssm/get_parameters.feature",
			"../../../../lang/specification/core/informal/ssm/get_parameters_by_path.feature",
			"../../../../lang/specification/core/informal/ssm/add_tags_to_resource.feature",
			"../../../../lang/specification/core/informal/ssm/list_tags_for_resource.feature",
			"../../../../lang/specification/core/informal/ssm/remove_tags_from_resource.feature",
			"../../../../lang/specification/core/informal/ssm/put_parameter_no_overwrite_conflict.feature",
			"../../../../lang/specification/core/informal/ssm/put_parameter_overwrite.feature",
			"../../../../lang/specification/core/informal/ssm/no_parameter_exists_after_delete.feature",
			// Secrets Manager service feature files
			"../../../../lang/specification/core/informal/secretsmanager/create_secret.feature",
			"../../../../lang/specification/core/informal/secretsmanager/delete_secret.feature",
			"../../../../lang/specification/core/informal/secretsmanager/get_secret_value.feature",
			"../../../../lang/specification/core/informal/secretsmanager/put_secret_value.feature",
			"../../../../lang/specification/core/informal/secretsmanager/list_secrets.feature",
			"../../../../lang/specification/core/informal/secretsmanager/describe_secret.feature",
			"../../../../lang/specification/core/informal/secretsmanager/update_secret.feature",
			"../../../../lang/specification/core/informal/secretsmanager/restore_secret.feature",
			"../../../../lang/specification/core/informal/secretsmanager/tag_resource.feature",
			"../../../../lang/specification/core/informal/secretsmanager/untag_resource.feature",
			"../../../../lang/specification/core/informal/secretsmanager/rotation_event.feature",
			"../../../../lang/specification/core/informal/secretsmanager/recovery_window_expires.feature",
			"../../../../lang/specification/core/informal/secretsmanager/at_most_one_current_version_per_secret.feature",
			"../../../../lang/specification/core/informal/secretsmanager/at_most_one_previous_version_per_secret.feature",
			"../../../../lang/specification/core/informal/secretsmanager/deleted_secret_with_closed_window_not_restored.feature",
			"../../../../lang/specification/core/informal/secretsmanager/secret_names_are_unique.feature",
			"../../../../lang/specification/core/informal/secretsmanager/version_ids_are_unique.feature",
			// Events service feature files
			"../../../../lang/specification/core/informal/events/create_event_bus.feature",
			"../../../../lang/specification/core/informal/events/delete_event_bus.feature",
			"../../../../lang/specification/core/informal/events/describe_event_bus.feature",
			"../../../../lang/specification/core/informal/events/list_event_buses.feature",
			"../../../../lang/specification/core/informal/events/put_rule.feature",
			"../../../../lang/specification/core/informal/events/delete_rule.feature",
			"../../../../lang/specification/core/informal/events/describe_rule.feature",
			"../../../../lang/specification/core/informal/events/list_rules.feature",
			"../../../../lang/specification/core/informal/events/disable_rule.feature",
			"../../../../lang/specification/core/informal/events/enable_rule.feature",
			"../../../../lang/specification/core/informal/events/put_targets.feature",
			"../../../../lang/specification/core/informal/events/list_targets_by_rule.feature",
			"../../../../lang/specification/core/informal/events/remove_targets.feature",
			"../../../../lang/specification/core/informal/events/put_events.feature",
			"../../../../lang/specification/core/informal/events/retry_dead_letter.feature",
			"../../../../lang/specification/core/informal/events/default_bus_cannot_be_deleted.feature",
			"../../../../lang/specification/core/informal/events/delete_rule_requires_no_targets.feature",
			// Organizations service feature files
			"../../../../lang/specification/core/informal/organizations/create_organization.feature",
			"../../../../lang/specification/core/informal/organizations/create_account.feature",
			"../../../../lang/specification/core/informal/organizations/create_organizational_unit.feature",
			"../../../../lang/specification/core/informal/organizations/create_policy.feature",
			"../../../../lang/specification/core/informal/organizations/delete_organizational_unit.feature",
			"../../../../lang/specification/core/informal/organizations/attach_policy.feature",
			"../../../../lang/specification/core/informal/organizations/detach_policy.feature",
			"../../../../lang/specification/core/informal/organizations/move_account.feature",
			// StepFunctions service feature files
			"../../../../lang/specification/core/informal/stepfunctions/create_state_machine.feature",
			"../../../../lang/specification/core/informal/stepfunctions/delete_state_machine.feature",
			"../../../../lang/specification/core/informal/stepfunctions/describe_state_machine.feature",
			"../../../../lang/specification/core/informal/stepfunctions/list_state_machines.feature",
			"../../../../lang/specification/core/informal/stepfunctions/list_executions.feature",
			"../../../../lang/specification/core/informal/stepfunctions/list_state_machine_versions.feature",
			"../../../../lang/specification/core/informal/stepfunctions/list_tags_for_resource.feature",
			"../../../../lang/specification/core/informal/stepfunctions/start_execution.feature",
			"../../../../lang/specification/core/informal/stepfunctions/start_sync_execution.feature",
			"../../../../lang/specification/core/informal/stepfunctions/stop_execution.feature",
			"../../../../lang/specification/core/informal/stepfunctions/describe_execution.feature",
			"../../../../lang/specification/core/informal/stepfunctions/get_execution_history.feature",
			"../../../../lang/specification/core/informal/stepfunctions/update_state_machine.feature",
			"../../../../lang/specification/core/informal/stepfunctions/tag_resource.feature",
			"../../../../lang/specification/core/informal/stepfunctions/untag_resource.feature",
			"../../../../lang/specification/core/informal/stepfunctions/validate_state_machine_definition.feature",
			"../../../../lang/specification/core/informal/stepfunctions/sync_execution_only_for_express.feature",
			// DynamoDB service feature files
			"../../../../lang/specification/core/informal/dynamodb/activate_table.feature",
			"../../../../lang/specification/core/informal/dynamodb/clear_rolled_back.feature",
			"../../../../lang/specification/core/informal/dynamodb/clear_transaction.feature",
			"../../../../lang/specification/core/informal/dynamodb/commit_transaction.feature",
			"../../../../lang/specification/core/informal/dynamodb/conditional_put_item.feature",
			"../../../../lang/specification/core/informal/dynamodb/create_table.feature",
			"../../../../lang/specification/core/informal/dynamodb/delete_item.feature",
			"../../../../lang/specification/core/informal/dynamodb/delete_table.feature",
			"../../../../lang/specification/core/informal/dynamodb/describe_table.feature",
			"../../../../lang/specification/core/informal/dynamodb/finish_delete_table.feature",
			"../../../../lang/specification/core/informal/dynamodb/get_item.feature",
			"../../../../lang/specification/core/informal/dynamodb/list_tables.feature",
			"../../../../lang/specification/core/informal/dynamodb/propagate_g_s_i.feature",
			"../../../../lang/specification/core/informal/dynamodb/put_item.feature",
			"../../../../lang/specification/core/informal/dynamodb/query.feature",
			"../../../../lang/specification/core/informal/dynamodb/scan.feature",
			"../../../../lang/specification/core/informal/dynamodb/set_throttle_reads.feature",
			"../../../../lang/specification/core/informal/dynamodb/set_throttle_writes.feature",
			"../../../../lang/specification/core/informal/dynamodb/transact_write_items.feature",
			"../../../../lang/specification/core/informal/dynamodb/update_item.feature",
			// Lambda service feature files
			"../../../../lang/specification/core/informal/lambda/create_function.feature",
			"../../../../lang/specification/core/informal/lambda/delete_function.feature",
			"../../../../lang/specification/core/informal/lambda/delete_failed_function.feature",
			"../../../../lang/specification/core/informal/lambda/update_function_code.feature",
			"../../../../lang/specification/core/informal/lambda/update_function_configuration.feature",
			"../../../../lang/specification/core/informal/lambda/add_permission.feature",
			"../../../../lang/specification/core/informal/lambda/remove_permission.feature",
			"../../../../lang/specification/core/informal/lambda/set_reserved_concurrency.feature",
			"../../../../lang/specification/core/informal/lambda/tag_resource.feature",
			"../../../../lang/specification/core/informal/lambda/untag_resource.feature",
			"../../../../lang/specification/core/informal/lambda/create_event_source_mapping.feature",
			"../../../../lang/specification/core/informal/lambda/delete_event_source_mapping.feature",
			"../../../../lang/specification/core/informal/lambda/delete_disabled_event_source_mapping.feature",
			"../../../../lang/specification/core/informal/lambda/activate_event_source_mapping.feature",
			"../../../../lang/specification/core/informal/lambda/disable_event_source_mapping.feature",
			"../../../../lang/specification/core/informal/lambda/enable_event_source_mapping.feature",
			"../../../../lang/specification/core/informal/lambda/finish_delete_event_source_mapping.feature",
			"../../../../lang/specification/core/informal/lambda/activate_function.feature",
			"../../../../lang/specification/core/informal/lambda/finish_delete_function.feature",
			"../../../../lang/specification/core/informal/lambda/invoke_function_async.feature",
			"../../../../lang/specification/core/informal/lambda/invoke_function_sync.feature",
			"../../../../lang/specification/core/informal/lambda/invoke_function_sync_with_concurrency.feature",
			"../../../../lang/specification/core/informal/lambda/finish_invoke_function_sync.feature",
			"../../../../lang/specification/core/informal/lambda/process_async_success.feature",
			"../../../../lang/specification/core/informal/lambda/process_async_retry.feature",
			"../../../../lang/specification/core/informal/lambda/process_async_exhausted.feature",
			// API Gateway service feature files
			"../../../../lang/specification/core/informal/apigateway/create_rest_api.feature",
			"../../../../lang/specification/core/informal/apigateway/delete_rest_api.feature",
			"../../../../lang/specification/core/informal/apigateway/init_root_resource.feature",
			"../../../../lang/specification/core/informal/apigateway/create_resource.feature",
			"../../../../lang/specification/core/informal/apigateway/delete_resource.feature",
			"../../../../lang/specification/core/informal/apigateway/put_method_get.feature",
			"../../../../lang/specification/core/informal/apigateway/put_method_update.feature",
			"../../../../lang/specification/core/informal/apigateway/delete_method.feature",
			"../../../../lang/specification/core/informal/apigateway/put_integration.feature",
			"../../../../lang/specification/core/informal/apigateway/delete_integration.feature",
			"../../../../lang/specification/core/informal/apigateway/put_method_response.feature",
			"../../../../lang/specification/core/informal/apigateway/put_integration_response.feature",
			"../../../../lang/specification/core/informal/apigateway/create_deployment.feature",
			"../../../../lang/specification/core/informal/apigateway/delete_deployment.feature",
			"../../../../lang/specification/core/informal/apigateway/create_stage_dev.feature",
			"../../../../lang/specification/core/informal/apigateway/delete_stage_dev.feature",
			"../../../../lang/specification/core/informal/apigateway/update_stage_dev.feature",
			"../../../../lang/specification/core/informal/apigateway/enable_stage_throttling_dev.feature",
			"../../../../lang/specification/core/informal/apigateway/disable_stage_throttling_dev.feature",
			"../../../../lang/specification/core/informal/apigateway/create_stage_prod.feature",
			"../../../../lang/specification/core/informal/apigateway/delete_stage_prod.feature",
			"../../../../lang/specification/core/informal/apigateway/update_stage_prod.feature",
			"../../../../lang/specification/core/informal/apigateway/enable_stage_throttling_prod.feature",
			"../../../../lang/specification/core/informal/apigateway/disable_stage_throttling_prod.feature",
			// Group B — Cross-service with core dependencies
			"../../../../lang/specification/core/informal/dynamodb_lambda/",
			"../../../../lang/specification/core/informal/lambda_dynamodb/",
			"../../../../lang/specification/core/informal/lambda_sqs/",
			"../../../../lang/specification/core/informal/lambda_sns/",
			"../../../../lang/specification/core/informal/lambda_s3api/",
			"../../../../lang/specification/core/informal/lambda_ssm/",
			"../../../../lang/specification/core/informal/lambda_secretsmanager/",
			"../../../../lang/specification/core/informal/lambda_stepfunctions/",
			"../../../../lang/specification/core/informal/lambda_events/",
			"../../../../lang/specification/core/informal/lambda_cognito/",
			"../../../../lang/specification/core/informal/lambda_lambda/",
			"../../../../lang/specification/core/informal/lambda_sqs_producer/",
			"../../../../lang/specification/core/informal/sns_lambda/",
			"../../../../lang/specification/core/informal/events_lambda/",
			"../../../../lang/specification/core/informal/s3api_lambda/",
			"../../../../lang/specification/core/informal/secretsmanager_lambda/",
			"../../../../lang/specification/core/informal/cognito_events/",
			"../../../../lang/specification/core/informal/cognito_lambda/",
			"../../../../lang/specification/core/informal/apigateway_lambda/",
			"../../../../lang/specification/core/informal/apigateway_sqs/",
			"../../../../lang/specification/core/informal/apigateway_sns/",
			"../../../../lang/specification/core/informal/apigateway_dynamodb/",
			"../../../../lang/specification/core/informal/apigateway_cognito/",
			"../../../../lang/specification/core/informal/apigateway_stepfunctions/",
			"../../../../lang/specification/core/informal/apigateway_s3api/",
			"../../../../lang/specification/core/informal/stepfunctions_lambda/",
			"../../../../lang/specification/core/informal/stepfunctions_cognito/",
			// Group C — Exotic services
			"../../../../lang/specification/core/informal/docdb/",
			"../../../../lang/specification/core/informal/docdb_events/",
			"../../../../lang/specification/core/informal/rds/",
			"../../../../lang/specification/core/informal/rds_events/",
			"../../../../lang/specification/core/informal/rds_lambda/",
			"../../../../lang/specification/core/informal/neptune/",
			"../../../../lang/specification/core/informal/neptune_events/",
			"../../../../lang/specification/core/informal/elasticsearch/",
			"../../../../lang/specification/core/informal/opensearch/",
			"../../../../lang/specification/core/informal/elasticache/",
			"../../../../lang/specification/core/informal/elasticache_sns/",
			"../../../../lang/specification/core/informal/memorydb/",
			"../../../../lang/specification/core/informal/glacier/",
			"../../../../lang/specification/core/informal/glacier_sns/",
			"../../../../lang/specification/core/informal/s3tables/",
			"../../../../lang/specification/core/informal/lambda_docdb/",
			"../../../../lang/specification/core/informal/lambda_elasticache/",
			"../../../../lang/specification/core/informal/lambda_elasticsearch/",
			"../../../../lang/specification/core/informal/lambda_glacier/",
			"../../../../lang/specification/core/informal/lambda_memorydb/",
			"../../../../lang/specification/core/informal/lambda_neptune/",
			"../../../../lang/specification/core/informal/lambda_opensearch/",
			"../../../../lang/specification/core/informal/lambda_rds/",
			"../../../../lang/specification/core/informal/lambda_s3tables/",
			"../../../../lang/specification/core/informal/stepfunctions_docdb/",
			"../../../../lang/specification/core/informal/stepfunctions_elasticache/",
			"../../../../lang/specification/core/informal/stepfunctions_elasticsearch/",
			"../../../../lang/specification/core/informal/stepfunctions_glacier/",
			"../../../../lang/specification/core/informal/stepfunctions_memorydb/",
			"../../../../lang/specification/core/informal/stepfunctions_neptune/",
			"../../../../lang/specification/core/informal/stepfunctions_opensearch/",
			"../../../../lang/specification/core/informal/stepfunctions_rds/",
			"../../../../lang/specification/core/informal/stepfunctions_s3tables/",
			// Group D — Misc
			"../../../../lang/specification/core/informal/aws_fake/",
			"../../../../lang/specification/core/informal/chaos/",
			// cognito_idp service feature files
			"../../../../lang/specification/core/informal/cognito_idp/create_user_pool.feature",
			"../../../../lang/specification/core/informal/cognito_idp/delete_user_pool.feature",
			"../../../../lang/specification/core/informal/cognito_idp/admin_create_user.feature",
			"../../../../lang/specification/core/informal/cognito_idp/admin_delete_user.feature",
			"../../../../lang/specification/core/informal/cognito_idp/admin_disable_user.feature",
			"../../../../lang/specification/core/informal/cognito_idp/admin_enable_user.feature",
			"../../../../lang/specification/core/informal/cognito_idp/admin_reset_user_password.feature",
			"../../../../lang/specification/core/informal/cognito_idp/admin_set_user_password.feature",
			"../../../../lang/specification/core/informal/cognito_idp/admin_update_user_attributes.feature",
			"../../../../lang/specification/core/informal/cognito_idp/admin_confirm_sign_up.feature",
			"../../../../lang/specification/core/informal/cognito_idp/admin_initiate_auth.feature",
			"../../../../lang/specification/core/informal/cognito_idp/initiate_auth.feature",
			"../../../../lang/specification/core/informal/cognito_idp/respond_to_auth_challenge.feature",
			"../../../../lang/specification/core/informal/cognito_idp/expire_auth_session.feature",
			"../../../../lang/specification/core/informal/cognito_idp/mark_user_compromised.feature",
			"../../../../lang/specification/core/informal/cognito_idp/verification_code_delivery_failure.feature",
			"../../../../lang/specification/core/informal/cognito_idp/create_group.feature",
			"../../../../lang/specification/core/informal/cognito_idp/delete_group.feature",
			"../../../../lang/specification/core/informal/cognito_idp/admin_add_user_to_group.feature",
			"../../../../lang/specification/core/informal/cognito_idp/admin_remove_user_from_group.feature",
		},
	}
	if suite := os.Getenv("GODOG_SUITE"); suite != "" {
		opts.Paths = filterPathsBySuite(opts.Paths, suite)
		if len(opts.Paths) == 0 {
			fmt.Printf("No feature paths matched suite %q — skipping\n", suite)
			sharedServer.Close()
			os.Exit(0)
		}
	}

	status := godog.TestSuite{
		Name:                "lws-go-sdk",
		ScenarioInitializer: InitializeScenario,
		Options:             &opts,
	}.Run()

	sharedServer.Close()
	os.Exit(status)
}

// filterPathsBySuite returns only the paths that belong to the given suite name.
// "sdk" matches paths under /specification/sdk/; any other name matches paths
// under /specification/core/informal/<suite>/. An empty suite returns all paths.
func filterPathsBySuite(paths []string, suite string) []string {
	var filtered []string
	if suite == "sdk" {
		for _, p := range paths {
			if strings.Contains(p, "/specification/sdk/") {
				filtered = append(filtered, p)
			}
		}
	} else {
		needle := "/specification/core/informal/" + suite + "/"
		for _, p := range paths {
			if strings.Contains(p, needle) {
				filtered = append(filtered, p)
			}
		}
	}
	return filtered
}

func awaitReady() error {
	url := fmt.Sprintf("http://127.0.0.1:%d/_ldk/status", basePort)
	deadline := time.Now().Add(10 * time.Second)
	for time.Now().Before(deadline) {
		resp, err := http.Get(url) //nolint:noctx
		if err == nil && resp.StatusCode == 200 {
			resp.Body.Close()
			return nil
		}
		if resp != nil {
			resp.Body.Close()
		}
		time.Sleep(100 * time.Millisecond)
	}
	return fmt.Errorf("server did not become ready within 10s")
}

func InitializeScenario(sc *godog.ScenarioContext) {
	world := newWorld()

	sc.Before(func(ctx context.Context, sc *godog.Scenario) (context.Context, error) {
		core.Reset(basePort) //nolint:errcheck
		world.reset()
		return ctx, nil
	})

	sc.After(func(ctx context.Context, sc *godog.Scenario, err error) (context.Context, error) {
		world.cleanup()
		return ctx, nil
	})

	registerAllSteps(sc, world)
}
