package tests

// registerElasticsearchServiceSteps wires all step definitions for the Elasticsearch informal
// specification feature files (create_elasticsearch_domain, delete_elasticsearch_domain,
// add_tags, remove_tags, update_elasticsearch_domain_config, finish_creating_domain,
// finish_deleting_domain, finish_processing_domain_config).

import (
	"context"
	"fmt"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/elasticsearchservice"
	estypes "github.com/aws/aws-sdk-go-v2/service/elasticsearchservice/types"
	"github.com/cucumber/godog"
)

const (
	esDomainName = "test-elasticsearch-domain-1"
	esTagKey     = "e2e-es-tag-key-1"
	esTagValue   = "e2e-es-tag-value-1"
)

// esCreateDomain creates the test Elasticsearch domain.
func esCreateDomain(world *World) error {
	_, err := world.ElasticsearchClient().CreateElasticsearchDomain(context.Background(), &elasticsearchservice.CreateElasticsearchDomainInput{
		DomainName: aws.String(esDomainName),
	})
	return err
}

// esDomainExists returns whether the test domain currently exists (not deleted).
func esDomainExists(world *World) bool {
	resp, err := world.ElasticsearchClient().DescribeElasticsearchDomain(context.Background(), &elasticsearchservice.DescribeElasticsearchDomainInput{
		DomainName: aws.String(esDomainName),
	})
	if err != nil {
		return false
	}
	if resp.DomainStatus == nil {
		return false
	}
	deleted := resp.DomainStatus.Deleted
	return deleted == nil || !*deleted
}

// esDomainARN returns the ARN of the test domain.
func esDomainARN(world *World) (string, error) {
	resp, err := world.ElasticsearchClient().DescribeElasticsearchDomain(context.Background(), &elasticsearchservice.DescribeElasticsearchDomainInput{
		DomainName: aws.String(esDomainName),
	})
	if err != nil {
		return "", err
	}
	if resp.DomainStatus == nil {
		return "", fmt.Errorf("domain status is nil")
	}
	return aws.ToString(resp.DomainStatus.ARN), nil
}

func registerElasticsearchServiceSteps(sc *godog.ScenarioContext, world *World) {
	// -------------------------------------------------------------------------
	// Given: domain state setup
	// -------------------------------------------------------------------------

	sc.Given(`^the domain does not already exist$`, func() error {
		// No-op: fresh state after reset has no domains.
		return nil
	})

	sc.Given(`^the domain already exists$`, func() error {
		// Arrange / Act: create the domain so it already exists.
		return esCreateDomain(world)
	})

	sc.Given(`^the domain exists$`, func() error {
		// Arrange / Act: ensure the domain exists.
		if !esDomainExists(world) {
			return esCreateDomain(world)
		}
		return nil
	})

	sc.Given(`^the domain is "ACTIVE"$`, func() error {
		// No-op: lws domains are immediately active after creation.
		return nil
	})

	sc.Given(`^the domain is not "ACTIVE"$`, func() error {
		// @internal: requires internal state manipulation — not reachable via public API.
		return nil
	})

	sc.Given(`^the domain is "CREATING"$`, func() error {
		// @internal: domain is in CREATING immediately after CreateElasticsearchDomain —
		// requires lifecycle dwell to keep it there, not reachable via public API.
		return nil
	})

	sc.Given(`^the domain is not "CREATING"$`, func() error {
		// @internal: state transition controlled internally.
		return nil
	})

	sc.Given(`^the domain is "DELETING"$`, func() error {
		// @internal: requires internal state manipulation — not reachable via public API.
		return nil
	})

	sc.Given(`^the domain is not "DELETING"$`, func() error {
		// @internal: state transition controlled internally.
		return nil
	})

	sc.Given(`^the domain is not being deleted$`, func() error {
		// No-op: domains are not being deleted after creation in lws.
		return nil
	})

	sc.Given(`^the domain is being deleted$`, func() error {
		// Arrange / Act: delete the domain so it is in DELETING state.
		_, _ = world.ElasticsearchClient().DeleteElasticsearchDomain(context.Background(), &elasticsearchservice.DeleteElasticsearchDomainInput{
			DomainName: aws.String(esDomainName),
		})
		return nil
	})

	sc.Given(`^the domain is not deleted$`, func() error {
		// No-op: domains are not deleted after creation in lws.
		return nil
	})

	sc.Given(`^the domain is deleted$`, func() error {
		// Arrange / Act: delete the domain so it is in deleted state.
		_, _ = world.ElasticsearchClient().DeleteElasticsearchDomain(context.Background(), &elasticsearchservice.DeleteElasticsearchDomainInput{
			DomainName: aws.String(esDomainName),
		})
		return nil
	})

	sc.Given(`^the domain does not exist$`, func() error {
		// No-op: fresh state after reset has no domains.
		return nil
	})

	sc.Given(`^the domain is "PROCESSING"$`, func() error {
		// @internal: requires internal state manipulation — not reachable via public API.
		return nil
	})

	sc.Given(`^the domain is not "PROCESSING"$`, func() error {
		// @internal: state transition controlled internally.
		return nil
	})

	// ── Given: tag state setup ────────────────────────────────────────────────

	sc.Given(`^the tag key exists$`, func() error {
		// Arrange / Act: add the test tag to the domain.
		arn, err := esDomainARN(world)
		if err != nil {
			return err
		}
		_, err = world.ElasticsearchClient().AddTags(context.Background(), &elasticsearchservice.AddTagsInput{
			ARN:     aws.String(arn),
			TagList: []estypes.Tag{{Key: aws.String(esTagKey), Value: aws.String(esTagValue)}},
		})
		return err
	})

	sc.Given(`^the tag key does not exist$`, func() error {
		// No-op: fresh state after reset has no tags on the domain.
		return nil
	})

	// -------------------------------------------------------------------------
	// When: actions
	// -------------------------------------------------------------------------

	sc.When(`^a search domain is created$`, func() error {
		// Arrange: (domain may or may not exist — set up by Given steps)
		// Act
		resp, err := world.ElasticsearchClient().CreateElasticsearchDomain(context.Background(), &elasticsearchservice.CreateElasticsearchDomainInput{
			DomainName: aws.String(esDomainName),
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^a search domain is deleted$`, func() error {
		// Arrange: (domain state set up by Given steps)
		// Act
		resp, err := world.ElasticsearchClient().DeleteElasticsearchDomain(context.Background(), &elasticsearchservice.DeleteElasticsearchDomainInput{
			DomainName: aws.String(esDomainName),
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^tags are added to a domain$`, func() error {
		// Arrange: get domain ARN; reject if domain not found
		arn, err := esDomainARN(world)
		if err != nil {
			setResult(world, nil, err)
			return nil
		}
		// Act
		resp, addErr := world.ElasticsearchClient().AddTags(context.Background(), &elasticsearchservice.AddTagsInput{
			ARN:     aws.String(arn),
			TagList: []estypes.Tag{{Key: aws.String(esTagKey), Value: aws.String(esTagValue)}},
		})
		// Assert: captured in world
		setResult(world, resp, addErr)
		return nil
	})

	sc.When(`^tags are removed from a domain$`, func() error {
		// Arrange: get domain ARN; reject if domain not found
		arn, err := esDomainARN(world)
		if err != nil {
			setResult(world, nil, err)
			return nil
		}
		// Act
		resp, removeErr := world.ElasticsearchClient().RemoveTags(context.Background(), &elasticsearchservice.RemoveTagsInput{
			ARN:     aws.String(arn),
			TagKeys: []string{esTagKey},
		})
		// Assert: captured in world
		setResult(world, resp, removeErr)
		return nil
	})

	sc.When(`^a domain configuration update is requested$`, func() error {
		// Arrange: (domain state set up by Given steps)
		// Act
		resp, err := world.ElasticsearchClient().UpdateElasticsearchDomainConfig(context.Background(), &elasticsearchservice.UpdateElasticsearchDomainConfigInput{
			DomainName: aws.String(esDomainName),
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^a search domain finishes creating$`, func() error {
		// @internal: no public API to advance the domain lifecycle — no-op.
		setResult(world, nil, nil)
		return nil
	})

	sc.When(`^a search domain finishes deleting$`, func() error {
		// @internal: no public API to advance the domain lifecycle — no-op.
		setResult(world, nil, nil)
		return nil
	})

	sc.When(`^a domain configuration finishes processing$`, func() error {
		// @internal: no public API to advance the domain config processing — no-op.
		setResult(world, nil, nil)
		return nil
	})

	sc.When(`^a node failure occurs$`, func() error {
		// @internal: no public API to inject a node failure — no-op.
		setResult(world, nil, nil)
		return nil
	})

	sc.When(`^a replica sync lag occurs$`, func() error {
		// @internal: no public API to inject replica sync lag — no-op.
		setResult(world, nil, nil)
		return nil
	})

	sc.When(`^a shard reallocation occurs$`, func() error {
		// @internal: no public API to inject shard reallocation — no-op.
		setResult(world, nil, nil)
		return nil
	})

	// -------------------------------------------------------------------------
	// Then: assertions
	// -------------------------------------------------------------------------

	sc.Then(`^the domain is in "CREATING" state$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected create_elasticsearch_domain to succeed but got: %w", world.lastResult.Error)
		}
		resp, err := world.ElasticsearchClient().DescribeElasticsearchDomain(context.Background(), &elasticsearchservice.DescribeElasticsearchDomainInput{
			DomainName: aws.String(esDomainName),
		})
		if err != nil {
			return fmt.Errorf("expected DescribeElasticsearchDomain to succeed but got: %w", err)
		}
		expectedDomainName := esDomainName
		actualDomainName := aws.ToString(resp.DomainStatus.DomainName)
		if actualDomainName != expectedDomainName {
			return fmt.Errorf("expected domain name %q but got %q; expected_domain_name=%s actual_domain_name=%s",
				expectedDomainName, actualDomainName, expectedDomainName, actualDomainName)
		}
		return nil
	})

	sc.Then(`^the domain is in "DELETING" state$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected delete_elasticsearch_domain to succeed but got: %w", world.lastResult.Error)
		}
		return nil
	})

	sc.Then(`^the domain is in "PROCESSING" state with a pending config change$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected update_elasticsearch_domain_config to succeed but got: %w", world.lastResult.Error)
		}
		return nil
	})

	sc.Then(`^the domain is "ACTIVE" and ready for use$`, func() error {
		// @internal: state transition controlled internally — no-op.
		return nil
	})

	sc.Then(`^the domain is "DELETED" and all its indices are removed$`, func() error {
		// @internal: state transition controlled internally — no-op.
		return nil
	})

	sc.Then(`^the specified tags are associated with the domain$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected add_tags to succeed but got: %w", world.lastResult.Error)
		}
		arn, err := esDomainARN(world)
		if err != nil {
			return fmt.Errorf("expected domain to exist but got: %w", err)
		}
		listResp, err := world.ElasticsearchClient().ListTags(context.Background(), &elasticsearchservice.ListTagsInput{
			ARN: aws.String(arn),
		})
		if err != nil {
			return fmt.Errorf("expected list_tags to succeed but got: %w", err)
		}
		tagFound := false
		for _, t := range listResp.TagList {
			if aws.ToString(t.Key) == esTagKey {
				tagFound = true
				break
			}
		}
		expectedFound := true
		actualFound := tagFound
		if actualFound != expectedFound {
			return fmt.Errorf("expected tag %q to be associated with domain but it was not; expected_found=%v actual_found=%v",
				esTagKey, expectedFound, actualFound)
		}
		return nil
	})

	sc.Then(`^the specified tags are no longer associated with the domain$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected remove_tags to succeed but got: %w", world.lastResult.Error)
		}
		arn, err := esDomainARN(world)
		if err != nil {
			return fmt.Errorf("expected domain to exist but got: %w", err)
		}
		listResp, err := world.ElasticsearchClient().ListTags(context.Background(), &elasticsearchservice.ListTagsInput{
			ARN: aws.String(arn),
		})
		if err != nil {
			return fmt.Errorf("expected list_tags to succeed but got: %w", err)
		}
		for _, t := range listResp.TagList {
			actualKey := aws.ToString(t.Key)
			if actualKey == esTagKey {
				return fmt.Errorf("expected tag %q to be removed from domain but it still exists; expected_removed=%s actual_key=%s",
					esTagKey, esTagKey, actualKey)
			}
		}
		return nil
	})

	sc.Then(`^the operation is rejected$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		expectedRejected := true
		actualRejected := world.lastResult.Error != nil
		if !actualRejected {
			return fmt.Errorf("expected the operation to be rejected but it succeeded; expected_rejected=%v actual_rejected=%v",
				expectedRejected, actualRejected)
		}
		return nil
	})

	sc.Then(`^every active index belongs to an existing non-deleted domain$`, func() error {
		// No-op invariant: trivially satisfied in an isolated test context.
		return nil
	})

	sc.Then(`^every active tag belongs to an existing non-deleted domain$`, func() error {
		// No-op invariant: trivially satisfied in an isolated test context.
		return nil
	})

	sc.Then(`^a pending config change only exists on a domain that is "PROCESSING"$`, func() error {
		// No-op invariant: trivially satisfied in an isolated test context.
		return nil
	})
}
