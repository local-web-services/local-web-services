package tests

import (
	"bytes"
	"context"
	"encoding/json"
	"fmt"
	"strings"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/s3"
	"github.com/cucumber/godog"
)

func registerS3Steps(sc *godog.ScenarioContext, world *World) {
	sc.Given(`^a bucket "([^"]*)" exists$`, func(bucketName string) error {
		_, err := world.S3Client().CreateBucket(context.Background(), &s3.CreateBucketInput{Bucket: aws.String(bucketName)})
		return err
	})

	sc.Given(`^an object "([^"]*)" with body "([^"]*)" exists in bucket "([^"]*)"$`, func(key, body, bucketName string) error {
		_, err := world.S3Client().PutObject(context.Background(), &s3.PutObjectInput{
			Bucket: aws.String(bucketName), Key: aws.String(key), Body: strings.NewReader(body),
		})
		return err
	})

	// When
	sc.When(`^I create a bucket "([^"]*)"$`, func(bucketName string) error {
		result, err := world.S3Client().CreateBucket(context.Background(), &s3.CreateBucketInput{Bucket: aws.String(bucketName)})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I delete the bucket "([^"]*)"$`, func(bucketName string) error {
		result, err := world.S3Client().DeleteBucket(context.Background(), &s3.DeleteBucketInput{Bucket: aws.String(bucketName)})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I list buckets$`, func() error {
		result, err := world.S3Client().ListBuckets(context.Background(), &s3.ListBucketsInput{})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I put object "([^"]*)" with body "([^"]*)" into bucket "([^"]*)"$`, func(key, body, bucketName string) error {
		result, err := world.S3Client().PutObject(context.Background(), &s3.PutObjectInput{
			Bucket: aws.String(bucketName), Key: aws.String(key), Body: strings.NewReader(body),
		})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I get object "([^"]*)" from bucket "([^"]*)"$`, func(key, bucketName string) error {
		result, err := world.S3Client().GetObject(context.Background(), &s3.GetObjectInput{
			Bucket: aws.String(bucketName), Key: aws.String(key),
		})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			buf := new(bytes.Buffer)
			buf.ReadFrom(result.Body)
			world.lastResult = LastResult{Success: true, Output: map[string]string{"Body": buf.String()}}
		}
		return nil
	})

	sc.When(`^I delete object "([^"]*)" from bucket "([^"]*)"$`, func(key, bucketName string) error {
		result, err := world.S3Client().DeleteObject(context.Background(), &s3.DeleteObjectInput{
			Bucket: aws.String(bucketName), Key: aws.String(key),
		})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I list objects in bucket "([^"]*)"$`, func(bucketName string) error {
		result, err := world.S3Client().ListObjectsV2(context.Background(), &s3.ListObjectsV2Input{Bucket: aws.String(bucketName)})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I head the bucket "([^"]*)"$`, func(bucketName string) error {
		result, err := world.S3Client().HeadBucket(context.Background(), &s3.HeadBucketInput{Bucket: aws.String(bucketName)})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I head object "([^"]*)" in bucket "([^"]*)"$`, func(key, bucketName string) error {
		result, err := world.S3Client().HeadObject(context.Background(), &s3.HeadObjectInput{
			Bucket: aws.String(bucketName), Key: aws.String(key),
		})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I copy object "([^"]*)" from bucket "([^"]*)" to "([^"]*)" in bucket "([^"]*)"$`, func(srcKey, srcBucket, dstKey, dstBucket string) error {
		result, err := world.S3Client().CopyObject(context.Background(), &s3.CopyObjectInput{
			Bucket:     aws.String(dstBucket),
			Key:        aws.String(dstKey),
			CopySource: aws.String(srcBucket + "/" + srcKey),
		})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I get the location of bucket "([^"]*)"$`, func(bucketName string) error {
		result, err := world.S3Client().GetBucketLocation(context.Background(), &s3.GetBucketLocationInput{Bucket: aws.String(bucketName)})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I create a multipart upload for "([^"]*)" in bucket "([^"]*)"$`, func(key, bucketName string) error {
		result, err := world.S3Client().CreateMultipartUpload(context.Background(), &s3.CreateMultipartUploadInput{
			Bucket: aws.String(bucketName), Key: aws.String(key),
		})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastUploadId = aws.ToString(result.UploadId)
			world.lastBucket = bucketName
			world.lastKey = key
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I abort the multipart upload$`, func() error {
		result, err := world.S3Client().AbortMultipartUpload(context.Background(), &s3.AbortMultipartUploadInput{
			Bucket:   aws.String(world.lastBucket),
			Key:      aws.String(world.lastKey),
			UploadId: aws.String(world.lastUploadId),
		})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	// Then
	sc.Then(`^the bucket "([^"]*)" will appear in the bucket list$`, func(bucketName string) error {
		result, err := world.S3Client().ListBuckets(context.Background(), &s3.ListBucketsInput{})
		if err != nil {
			return err
		}
		for _, b := range result.Buckets {
			if aws.ToString(b.Name) == bucketName {
				return nil
			}
		}
		return fmt.Errorf("bucket %q not found in list", bucketName)
	})

	sc.Then(`^the bucket "([^"]*)" will not appear in the bucket list$`, func(bucketName string) error {
		result, err := world.S3Client().ListBuckets(context.Background(), &s3.ListBucketsInput{})
		if err != nil {
			return err
		}
		for _, b := range result.Buckets {
			if aws.ToString(b.Name) == bucketName {
				return fmt.Errorf("bucket %q found in list but should not be", bucketName)
			}
		}
		return nil
	})

	sc.Then(`^the output will contain bucket "([^"]*)"$`, func(bucketName string) error {
		actualOutput, _ := json.Marshal(world.lastResult.Output)
		if !strings.Contains(string(actualOutput), bucketName) {
			return fmt.Errorf("expected output to contain %q but got: %s", bucketName, string(actualOutput))
		}
		return nil
	})

	sc.Then(`^bucket "([^"]*)" will contain object "([^"]*)"$`, func(bucketName, key string) error {
		result, err := world.S3Client().ListObjectsV2(context.Background(), &s3.ListObjectsV2Input{Bucket: aws.String(bucketName)})
		if err != nil {
			return err
		}
		for _, obj := range result.Contents {
			if aws.ToString(obj.Key) == key {
				return nil
			}
		}
		return fmt.Errorf("object %q not found in bucket %q", key, bucketName)
	})

	sc.Then(`^bucket "([^"]*)" will not contain object "([^"]*)"$`, func(bucketName, key string) error {
		result, err := world.S3Client().ListObjectsV2(context.Background(), &s3.ListObjectsV2Input{Bucket: aws.String(bucketName)})
		if err != nil {
			return err
		}
		for _, obj := range result.Contents {
			if aws.ToString(obj.Key) == key {
				return fmt.Errorf("object %q found in bucket %q but should not be", key, bucketName)
			}
		}
		return nil
	})

	sc.Then(`^the object body will be "([^"]*)"$`, func(expectedBody string) error {
		actualOutput, _ := json.Marshal(world.lastResult.Output)
		if !strings.Contains(string(actualOutput), expectedBody) {
			return fmt.Errorf("expected body %q but got: %s", expectedBody, string(actualOutput))
		}
		return nil
	})
}
