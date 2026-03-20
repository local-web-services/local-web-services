#!/usr/bin/env node
import * as cdk from 'aws-cdk-lib';
import { OrderProcessingStack } from '../lib/order-processing-stack';

const app = new cdk.App();
new OrderProcessingStack(app, 'OrderProcessingStack');
