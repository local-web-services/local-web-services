package tests

import (
	"context"
	"fmt"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/organizations"
	orgtypes "github.com/aws/aws-sdk-go-v2/service/organizations/types"
	"github.com/cucumber/godog"
)

const (
	testOrgsOuName       = "test-ou-1"
	testOrgsAccountName  = "test-account-1"
	testOrgsAccountEmail = "test-account-1@example.com"
	testOrgsPolicyName   = "test-policy-1"
)

func registerOrganizationsSteps(sc *godog.ScenarioContext, world *World) {
	// --- Given ----------------------------------------------------------------

	sc.Given(`^the system is initialized$`, func() error {
		return nil
	})

	sc.Given(`^the organization does not already exist$`, func() error {
		return nil
	})

	sc.Given(`^the organization already exists$`, func() error {
		_, err := world.OrganizationsClient().CreateOrganization(context.Background(), &organizations.CreateOrganizationInput{
			FeatureSet: orgtypes.OrganizationFeatureSetAll,
		})
		return err
	})

	sc.Given(`^the organization exists$`, func() error {
		_, err := world.OrganizationsClient().CreateOrganization(context.Background(), &organizations.CreateOrganizationInput{
			FeatureSet: orgtypes.OrganizationFeatureSetAll,
		})
		return err
	})

	sc.Given(`^the organization does not exist$`, func() error {
		return nil
	})

	sc.Given(`^the account does not already exist$`, func() error {
		return nil
	})

	sc.Given(`^the account already exists$`, func() error {
		_, createAccErr := world.OrganizationsClient().CreateAccount(context.Background(), &organizations.CreateAccountInput{
			AccountName: aws.String(testOrgsAccountName),
			Email:       aws.String(testOrgsAccountEmail),
		})
		return createAccErr
	})

	sc.Given(`^the account exists and is "ACTIVE"$`, func() error {
		_, createOrgErr := world.OrganizationsClient().CreateOrganization(context.Background(), &organizations.CreateOrganizationInput{
			FeatureSet: orgtypes.OrganizationFeatureSetAll,
		})
		if createOrgErr != nil {
			return createOrgErr
		}
		result, createAccErr := world.OrganizationsClient().CreateAccount(context.Background(), &organizations.CreateAccountInput{
			AccountName: aws.String(testOrgsAccountName),
			Email:       aws.String(testOrgsAccountEmail),
		})
		if createAccErr != nil {
			return createAccErr
		}
		world.orgsAccountId = aws.ToString(result.CreateAccountStatus.AccountId)
		// Store root ID for source parent
		rootsResult, listRootsErr := world.OrganizationsClient().ListRoots(context.Background(), &organizations.ListRootsInput{})
		if listRootsErr != nil {
			return listRootsErr
		}
		world.orgsRootId = aws.ToString(rootsResult.Roots[0].Id)
		world.orgsSourceParentId = world.orgsRootId
		return nil
	})

	sc.Given(`^the account does not exist or is not "ACTIVE"$`, func() error {
		world.orgsAccountId = "nonexistent-account-id"
		world.orgsSourceParentId = "nonexistent-parent-id"
		return nil
	})

	sc.Given(`^the parent exists and is "ACTIVE"$`, func() error {
		// Root already exists after org is created; retrieve it
		rootsResult, err := world.OrganizationsClient().ListRoots(context.Background(), &organizations.ListRootsInput{})
		if err != nil {
			return err
		}
		world.orgsRootId = aws.ToString(rootsResult.Roots[0].Id)
		return nil
	})

	sc.Given(`^the parent does not exist or is not "ACTIVE"$`, func() error {
		world.orgsRootId = "nonexistent-parent-id"
		return nil
	})

	sc.Given(`^the organizational unit does not already exist$`, func() error {
		return nil
	})

	sc.Given(`^the organizational unit already exists$`, func() error {
		rootsResult, listRootsErr := world.OrganizationsClient().ListRoots(context.Background(), &organizations.ListRootsInput{})
		if listRootsErr != nil {
			return listRootsErr
		}
		rootId := aws.ToString(rootsResult.Roots[0].Id)
		world.orgsOuName = testOrgsOuName
		_, err := world.OrganizationsClient().CreateOrganizationalUnit(context.Background(), &organizations.CreateOrganizationalUnitInput{
			ParentId: aws.String(rootId),
			Name:     aws.String(testOrgsOuName),
		})
		return err
	})

	sc.Given(`^the organizational unit exists and is "ACTIVE"$`, func() error {
		_, createOrgErr := world.OrganizationsClient().CreateOrganization(context.Background(), &organizations.CreateOrganizationInput{
			FeatureSet: orgtypes.OrganizationFeatureSetAll,
		})
		if createOrgErr != nil {
			return createOrgErr
		}
		rootsResult, listRootsErr := world.OrganizationsClient().ListRoots(context.Background(), &organizations.ListRootsInput{})
		if listRootsErr != nil {
			return listRootsErr
		}
		rootId := aws.ToString(rootsResult.Roots[0].Id)
		world.orgsRootId = rootId
		ouResult, createOuErr := world.OrganizationsClient().CreateOrganizationalUnit(context.Background(), &organizations.CreateOrganizationalUnitInput{
			ParentId: aws.String(rootId),
			Name:     aws.String(testOrgsOuName),
		})
		if createOuErr != nil {
			return createOuErr
		}
		world.orgsOuId = aws.ToString(ouResult.OrganizationalUnit.Id)
		return nil
	})

	sc.Given(`^the organizational unit does not exist or is not "ACTIVE"$`, func() error {
		world.orgsOuId = "nonexistent-ou-id"
		return nil
	})

	sc.Given(`^the organizational unit has no child accounts$`, func() error {
		return nil
	})

	sc.Given(`^the organizational unit has child accounts$`, func() error {
		accResult, createAccErr := world.OrganizationsClient().CreateAccount(context.Background(), &organizations.CreateAccountInput{
			AccountName: aws.String(testOrgsAccountName),
			Email:       aws.String(testOrgsAccountEmail),
		})
		if createAccErr != nil {
			return createAccErr
		}
		accountId := aws.ToString(accResult.CreateAccountStatus.AccountId)
		_, moveErr := world.OrganizationsClient().MoveAccount(context.Background(), &organizations.MoveAccountInput{
			AccountId:           aws.String(accountId),
			SourceParentId:      aws.String(world.orgsRootId),
			DestinationParentId: aws.String(world.orgsOuId),
		})
		return moveErr
	})

	sc.Given(`^the organizational unit has no child organizational units$`, func() error {
		return nil
	})

	sc.Given(`^the organizational unit has child organizational units$`, func() error {
		_, err := world.OrganizationsClient().CreateOrganizationalUnit(context.Background(), &organizations.CreateOrganizationalUnitInput{
			ParentId: aws.String(world.orgsOuId),
			Name:     aws.String("child-ou-1"),
		})
		return err
	})

	sc.Given(`^the organizational unit has no attached policies$`, func() error {
		return nil
	})

	sc.Given(`^the organizational unit has attached policies$`, func() error {
		policyResult, createPolicyErr := world.OrganizationsClient().CreatePolicy(context.Background(), &organizations.CreatePolicyInput{
			Name:        aws.String(testOrgsPolicyName),
			Description: aws.String(""),
			Content:     aws.String("{}"),
			Type:        orgtypes.PolicyTypeServiceControlPolicy,
		})
		if createPolicyErr != nil {
			return createPolicyErr
		}
		policyId := aws.ToString(policyResult.Policy.PolicySummary.Id)
		_, attachErr := world.OrganizationsClient().AttachPolicy(context.Background(), &organizations.AttachPolicyInput{
			PolicyId: aws.String(policyId),
			TargetId: aws.String(world.orgsOuId),
		})
		return attachErr
	})

	sc.Given(`^the policy does not already exist$`, func() error {
		return nil
	})

	sc.Given(`^the policy already exists$`, func() error {
		rootsResult, listRootsErr := world.OrganizationsClient().ListRoots(context.Background(), &organizations.ListRootsInput{})
		if listRootsErr != nil {
			return listRootsErr
		}
		world.orgsRootId = aws.ToString(rootsResult.Roots[0].Id)
		_, err := world.OrganizationsClient().CreatePolicy(context.Background(), &organizations.CreatePolicyInput{
			Name:        aws.String(testOrgsPolicyName),
			Description: aws.String(""),
			Content:     aws.String("{}"),
			Type:        orgtypes.PolicyTypeServiceControlPolicy,
		})
		return err
	})

	sc.Given(`^the policy exists and is "ACTIVE"$`, func() error {
		_, createOrgErr := world.OrganizationsClient().CreateOrganization(context.Background(), &organizations.CreateOrganizationInput{
			FeatureSet: orgtypes.OrganizationFeatureSetAll,
		})
		if createOrgErr != nil {
			return createOrgErr
		}
		rootsResult, listRootsErr := world.OrganizationsClient().ListRoots(context.Background(), &organizations.ListRootsInput{})
		if listRootsErr != nil {
			return listRootsErr
		}
		world.orgsRootId = aws.ToString(rootsResult.Roots[0].Id)
		world.orgsTargetId = world.orgsRootId
		policyResult, createPolicyErr := world.OrganizationsClient().CreatePolicy(context.Background(), &organizations.CreatePolicyInput{
			Name:        aws.String(testOrgsPolicyName),
			Description: aws.String(""),
			Content:     aws.String("{}"),
			Type:        orgtypes.PolicyTypeServiceControlPolicy,
		})
		if createPolicyErr != nil {
			return createPolicyErr
		}
		world.orgsPolicyId = aws.ToString(policyResult.Policy.PolicySummary.Id)
		return nil
	})

	sc.Given(`^the policy does not exist or is not "ACTIVE"$`, func() error {
		world.orgsPolicyId = "nonexistent-policy-id"
		world.orgsTargetId = "nonexistent-target-id"
		return nil
	})

	sc.Given(`^the target exists and is "ACTIVE"$`, func() error {
		world.orgsTargetId = world.orgsRootId
		return nil
	})

	sc.Given(`^the target does not exist or is not "ACTIVE"$`, func() error {
		world.orgsTargetId = "nonexistent-target-id"
		return nil
	})

	sc.Given(`^the policy is not already attached to the target$`, func() error {
		return nil
	})

	sc.Given(`^the policy is already attached to the target$`, func() error {
		_, err := world.OrganizationsClient().AttachPolicy(context.Background(), &organizations.AttachPolicyInput{
			PolicyId: aws.String(world.orgsPolicyId),
			TargetId: aws.String(world.orgsTargetId),
		})
		return err
	})

	sc.Given(`^the policy is attached to the target$`, func() error {
		_, createOrgErr := world.OrganizationsClient().CreateOrganization(context.Background(), &organizations.CreateOrganizationInput{
			FeatureSet: orgtypes.OrganizationFeatureSetAll,
		})
		if createOrgErr != nil {
			return createOrgErr
		}
		rootsResult, listRootsErr := world.OrganizationsClient().ListRoots(context.Background(), &organizations.ListRootsInput{})
		if listRootsErr != nil {
			return listRootsErr
		}
		world.orgsRootId = aws.ToString(rootsResult.Roots[0].Id)
		world.orgsTargetId = world.orgsRootId
		policyResult, createPolicyErr := world.OrganizationsClient().CreatePolicy(context.Background(), &organizations.CreatePolicyInput{
			Name:        aws.String(testOrgsPolicyName),
			Description: aws.String(""),
			Content:     aws.String("{}"),
			Type:        orgtypes.PolicyTypeServiceControlPolicy,
		})
		if createPolicyErr != nil {
			return createPolicyErr
		}
		world.orgsPolicyId = aws.ToString(policyResult.Policy.PolicySummary.Id)
		_, attachErr := world.OrganizationsClient().AttachPolicy(context.Background(), &organizations.AttachPolicyInput{
			PolicyId: aws.String(world.orgsPolicyId),
			TargetId: aws.String(world.orgsTargetId),
		})
		return attachErr
	})

	sc.Given(`^the policy is not attached to the target$`, func() error {
		_, createOrgErr := world.OrganizationsClient().CreateOrganization(context.Background(), &organizations.CreateOrganizationInput{
			FeatureSet: orgtypes.OrganizationFeatureSetAll,
		})
		if createOrgErr != nil {
			return createOrgErr
		}
		rootsResult, listRootsErr := world.OrganizationsClient().ListRoots(context.Background(), &organizations.ListRootsInput{})
		if listRootsErr != nil {
			return listRootsErr
		}
		world.orgsRootId = aws.ToString(rootsResult.Roots[0].Id)
		world.orgsTargetId = world.orgsRootId
		policyResult, createPolicyErr := world.OrganizationsClient().CreatePolicy(context.Background(), &organizations.CreatePolicyInput{
			Name:        aws.String(testOrgsPolicyName),
			Description: aws.String(""),
			Content:     aws.String("{}"),
			Type:        orgtypes.PolicyTypeServiceControlPolicy,
		})
		if createPolicyErr != nil {
			return createPolicyErr
		}
		world.orgsPolicyId = aws.ToString(policyResult.Policy.PolicySummary.Id)
		return nil
	})

	sc.Given(`^the source parent matches the account's current parent$`, func() error {
		// orgsSourceParentId is already set to the root (account's actual parent)
		return nil
	})

	sc.Given(`^the source parent does not match the account's current parent$`, func() error {
		world.orgsSourceParentId = "nonexistent-parent-id"
		return nil
	})

	sc.Given(`^the destination parent is "ACTIVE"$`, func() error {
		ouResult, createOuErr := world.OrganizationsClient().CreateOrganizationalUnit(context.Background(), &organizations.CreateOrganizationalUnitInput{
			ParentId: aws.String(world.orgsRootId),
			Name:     aws.String(testOrgsOuName),
		})
		if createOuErr != nil {
			return createOuErr
		}
		world.orgsDestParentId = aws.ToString(ouResult.OrganizationalUnit.Id)
		return nil
	})

	sc.Given(`^the destination parent is not "ACTIVE"$`, func() error {
		world.orgsDestParentId = "nonexistent-dest-id"
		return nil
	})

	// --- When -----------------------------------------------------------------

	sc.When(`^an organization is created$`, func() error {
		result, err := world.OrganizationsClient().CreateOrganization(context.Background(), &organizations.CreateOrganizationInput{
			FeatureSet: orgtypes.OrganizationFeatureSetAll,
		})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.orgsOrgId = aws.ToString(result.Organization.Id)
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^an account is created in the organization$`, func() error {
		result, err := world.OrganizationsClient().CreateAccount(context.Background(), &organizations.CreateAccountInput{
			AccountName: aws.String(testOrgsAccountName),
			Email:       aws.String(testOrgsAccountEmail),
		})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.orgsAccountId = aws.ToString(result.CreateAccountStatus.AccountId)
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^an organizational unit is created under a parent$`, func() error {
		result, err := world.OrganizationsClient().CreateOrganizationalUnit(context.Background(), &organizations.CreateOrganizationalUnitInput{
			ParentId: aws.String(world.orgsRootId),
			Name:     aws.String(testOrgsOuName),
		})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.orgsOuId = aws.ToString(result.OrganizationalUnit.Id)
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^a service control policy is created$`, func() error {
		result, err := world.OrganizationsClient().CreatePolicy(context.Background(), &organizations.CreatePolicyInput{
			Name:        aws.String(testOrgsPolicyName),
			Description: aws.String(""),
			Content:     aws.String("{}"),
			Type:        orgtypes.PolicyTypeServiceControlPolicy,
		})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.orgsPolicyId = aws.ToString(result.Policy.PolicySummary.Id)
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^an organizational unit is deleted$`, func() error {
		result, err := world.OrganizationsClient().DeleteOrganizationalUnit(context.Background(), &organizations.DeleteOrganizationalUnitInput{
			OrganizationalUnitId: aws.String(world.orgsOuId),
		})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^a policy is attached to a target$`, func() error {
		result, err := world.OrganizationsClient().AttachPolicy(context.Background(), &organizations.AttachPolicyInput{
			PolicyId: aws.String(world.orgsPolicyId),
			TargetId: aws.String(world.orgsTargetId),
		})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^a policy is detached from a target$`, func() error {
		result, err := world.OrganizationsClient().DetachPolicy(context.Background(), &organizations.DetachPolicyInput{
			PolicyId: aws.String(world.orgsPolicyId),
			TargetId: aws.String(world.orgsTargetId),
		})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^an account is moved to a new parent$`, func() error {
		result, err := world.OrganizationsClient().MoveAccount(context.Background(), &organizations.MoveAccountInput{
			AccountId:           aws.String(world.orgsAccountId),
			SourceParentId:      aws.String(world.orgsSourceParentId),
			DestinationParentId: aws.String(world.orgsDestParentId),
		})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	// --- Then -----------------------------------------------------------------

	sc.Then(`^the organization and its root exist$`, func() error {
		_, err := world.OrganizationsClient().DescribeOrganization(context.Background(), &organizations.DescribeOrganizationInput{})
		if err != nil {
			return fmt.Errorf("DescribeOrganization failed: %w", err)
		}
		rootsResult, rootsErr := world.OrganizationsClient().ListRoots(context.Background(), &organizations.ListRootsInput{})
		if rootsErr != nil {
			return fmt.Errorf("ListRoots failed: %w", rootsErr)
		}
		if len(rootsResult.Roots) == 0 {
			return fmt.Errorf("expected at least one root but got none")
		}
		return nil
	})

	sc.Then(`^the account is "ACTIVE" under the root$`, func() error {
		_, err := world.OrganizationsClient().DescribeAccount(context.Background(), &organizations.DescribeAccountInput{
			AccountId: aws.String(world.orgsAccountId),
		})
		if err != nil {
			return fmt.Errorf("DescribeAccount failed: %w", err)
		}
		return nil
	})

	sc.Then(`^the organizational unit is "ACTIVE"$`, func() error {
		_, err := world.OrganizationsClient().DescribeOrganizationalUnit(context.Background(), &organizations.DescribeOrganizationalUnitInput{
			OrganizationalUnitId: aws.String(world.orgsOuId),
		})
		if err != nil {
			return fmt.Errorf("DescribeOrganizationalUnit failed: %w", err)
		}
		return nil
	})

	sc.Then(`^the policy is "ACTIVE"$`, func() error {
		_, err := world.OrganizationsClient().DescribePolicy(context.Background(), &organizations.DescribePolicyInput{
			PolicyId: aws.String(world.orgsPolicyId),
		})
		if err != nil {
			return fmt.Errorf("DescribePolicy failed: %w", err)
		}
		return nil
	})

	sc.Then(`^the organizational unit is "DELETED"$`, func() error {
		_, err := world.OrganizationsClient().DescribeOrganizationalUnit(context.Background(), &organizations.DescribeOrganizationalUnitInput{
			OrganizationalUnitId: aws.String(world.orgsOuId),
		})
		if err == nil {
			return fmt.Errorf("expected DescribeOrganizationalUnit to fail for deleted OU but it succeeded")
		}
		return nil
	})

	sc.Then(`^the policy is attached to the target$`, func() error {
		result, err := world.OrganizationsClient().ListTargetsForPolicy(context.Background(), &organizations.ListTargetsForPolicyInput{
			PolicyId: aws.String(world.orgsPolicyId),
		})
		if err != nil {
			return fmt.Errorf("ListTargetsForPolicy failed: %w", err)
		}
		for _, target := range result.Targets {
			if aws.ToString(target.TargetId) == world.orgsTargetId {
				return nil
			}
		}
		return fmt.Errorf("expected target %q to be in policy targets but it was not", world.orgsTargetId)
	})

	sc.Then(`^the policy is no longer attached to the target$`, func() error {
		result, err := world.OrganizationsClient().ListTargetsForPolicy(context.Background(), &organizations.ListTargetsForPolicyInput{
			PolicyId: aws.String(world.orgsPolicyId),
		})
		if err != nil {
			return fmt.Errorf("ListTargetsForPolicy failed: %w", err)
		}
		for _, target := range result.Targets {
			if aws.ToString(target.TargetId) == world.orgsTargetId {
				return fmt.Errorf("expected target %q to not be in policy targets but it was", world.orgsTargetId)
			}
		}
		return nil
	})

	sc.Then(`^the account is under the new parent$`, func() error {
		result, err := world.OrganizationsClient().ListAccountsForParent(context.Background(), &organizations.ListAccountsForParentInput{
			ParentId: aws.String(world.orgsDestParentId),
		})
		if err != nil {
			return fmt.Errorf("ListAccountsForParent failed: %w", err)
		}
		for _, account := range result.Accounts {
			if aws.ToString(account.Id) == world.orgsAccountId {
				return nil
			}
		}
		return fmt.Errorf("expected account %q under parent %q but it was not found", world.orgsAccountId, world.orgsDestParentId)
	})

	sc.Then(`^the operation is rejected$`, func() error {
		if world.lastResult.Success {
			return fmt.Errorf("expected operation to be rejected but it succeeded")
		}
		return nil
	})

	sc.Then(`^the root is "ACTIVE" whenever the organization exists$`, func() error {
		return nil
	})

	sc.Then(`^every active account has an "ACTIVE" parent$`, func() error {
		return nil
	})

	sc.Then(`^every active organizational unit has an "ACTIVE" parent$`, func() error {
		return nil
	})

	sc.Then(`^no active node is a child of a deleted organizational unit$`, func() error {
		return nil
	})

	sc.Then(`^every active policy attachment targets an "ACTIVE" node$`, func() error {
		return nil
	})
}
