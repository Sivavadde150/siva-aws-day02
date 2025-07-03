#write complete notes about cloud watch in aws and eplaining each point with aws management console steps and aws cli explanation with example
# CloudWatch Overview and Usage in AWS  
# Amazon CloudWatch is a monitoring and observability service that provides data and actionable insights for AWS, hybrid, and on-premises applications and infrastructure. It helps you monitor your applications, understand and respond to system-wide performance changes, optimize resource utilization, and get a unified view of operational health.  
# Key Features of CloudWatch:
## 1. Metrics:
#   - Collects and tracks metrics for AWS services and custom applications.
#   - Provides real-time visibility into resource utilization, application performance, and operational health.
#   - AWS Management Console Steps:
#     1. Open the CloudWatch console at https://console.aws.amazon.com/cloudwatch/
#     2. In the navigation pane, choose "Metrics".
#     3. Select a namespace (e.g., AWS/EC2, AWS/S3) to view metrics.
#     4. Use the search bar to find specific metrics or filter by dimensions.
#     5. Click on a metric to view its graph and statistics.
#   - AWS CLI Explanation:          
#     - Use `aws cloudwatch list-metrics` to list available metrics.
#     - Use `aws cloudwatch get-metric-statistics` to retrieve statistics for a specific metric.
#     - Example:
#         aws cloudwatch get-metric-statistics --namespace AWS/EC2 --metric-name CPUUtilization --start-time 2023-10-01T00:00:00Z           
#         --end-time 2023-10-01T01:00:00Z --period 300 --statistics Average
#         --dimensions Name=InstanceId,Value=i-1234567890abcdef0        
## 2. Alarms:
#   - Monitors metrics and triggers actions based on defined thresholds.
#   - Can send notifications via Amazon SNS, execute Auto Scaling policies, or perform custom actions.
#   - AWS Management Console Steps:
#     1. Open the CloudWatch console.           
#     2. In the navigation pane, choose "Alarms".
#     3. Click "Create alarm".      
#     4. Select a metric to monitor and click "Select metric".      
#     5. Define the alarm conditions (e.g., threshold, period).
#     6. Configure actions (e.g., send notification, trigger Auto Scaling). 
#     7. Review and create the alarm.
#   - AWS CLI Explanation:
#     - Use `aws cloudwatch put-metric-alarm` to create or update an    alarm.
#     - Use `aws cloudwatch describe-alarms` to list existing alarms.
#     - Example:
#         aws cloudwatch put-metric-alarm --alarm-name HighCPUUtilization \
#         --metric-name CPUUtilization --namespace AWS/EC2 --statistic Average \
#         --period 300 --threshold 80 --comparison-operator GreaterThanOrEqualTo            
#         --evaluation-periods 2 --alarm-actions arn:aws:sns:us-east-1:123456789012:MyTopic \           
#         --dimensions Name=InstanceId,Value=i-1234567890abcdef0    
## 3. Logs:
#   - Collects and monitors log files from AWS services and custom applications.
#   - Provides real-time log data and allows you to search, filter, and analyze logs.
#   - AWS Management Console Steps:
#     1. Open the CloudWatch console.
#     2. In the navigation pane, choose "Logs".     
#     3. Select a log group to view its log streams.
#     4. Click on a log stream to view its log events.
#     5. Use the search bar to filter log events or create metric filters.
#   - AWS CLI Explanation:      
#     - Use `aws logs describe-log-groups` to list log groups.
#     - Use `aws logs describe-log-streams` to list log streams in a log group.
#     - Use `aws logs filter-log-events` to search for specific log events.
#     - Example:
#         aws logs filter-log-events --log-group-name /aws/lambda/my-function \
#         --filter-pattern "ERROR" --start-time 1700000000000 --end-time 1700003600000
#         --limit 100
#         aws logs create-log-group --log-group-name my-log-group           
#         aws logs create-log-stream --log-group-name my-log-group --log-stream-name my-log-stream
#         aws logs put-log-events --log-group-name my-log-group --log-stream-name my-log-stream \
#         --log-events timestamp=$(date +%s%3N),message="This is a log message"
#
## 4. Events:
#   - Monitors and responds to changes in your AWS environment.
#   - Can trigger actions based on specific events, such as resource state changes or scheduled events      
#   - AWS Management Console Steps:
#     1. Open the CloudWatch console.   
#     2. In the navigation pane, choose "Events".
#     3. Click "Create rule".
#     4. Define the event pattern (e.g., EC2 instance state change,
#        scheduled events).
#     5. Configure targets (e.g., Lambda function, SNS topic).
#     6. Review and create the rule.
#   - AWS CLI Explanation:
#     - Use `aws events put-rule` to create or update an event rule.
#     - Use `aws events put-targets` to specify targets for the rule.
#     - Example:
#         aws events put-rule --name MyRule --event-pattern '{"source": ["aws.ec2"], "detail-type": ["EC2 Instance State-change Notification"], "detail": {"state": ["running"]}}' \
#         --description "Trigger when EC2 instance state changes to running"
#         aws events put-targets --rule MyRule --targets '[{"Id": "1", "Arn": "arn:aws:lambda:us-east-1:123456789012:function:MyFunction"}]'
#         aws events put-rule --schedule-expression "rate(5 minutes)" --name MyScheduledRule \
#         --description "Trigger every 5 minutes"
#         aws events put-targets --rule MyScheduledRule --targets '[{"Id": "1", "Arn": "arn:aws:sns:us-east-1:123456789012:MyTopic"}]'
#
## 5. Dashboards:
#   - Provides customizable dashboards to visualize metrics and logs.
#   - Allows you to create graphs, charts, and widgets to monitor your applications and infrastructure          
#   - AWS Management Console Steps:
#     1. Open the CloudWatch console.
#     2. In the navigation pane, choose "Dashboards".
#     3. Click "Create dashboard".
#     4. Enter a name for the dashboard and click "Create".
#     5. Add widgets (e.g., metric graphs, log queries) to the dashboard.
#     6. Configure each widget with the desired metrics or log queries.
#     7. Save the dashboard.
#   - AWS CLI Explanation:
#     - Use `aws cloudwatch create-dashboard` to create a new dashboard.
#     - Use `aws cloudwatch get-dashboard` to retrieve an existing dashboard.
#     - Use `aws cloudwatch put-dashboard` to update an existing dashboard.
#     - Example:
#         aws cloudwatch create-dashboard --dashboard-name MyDashboard --dashboard-body '{
#         "widgets": [
#             {
#                 "type": "metric",
#                 "properties": {
#                     "metrics": [
#                         ["AWS/EC2", "CPUUtilization", "InstanceId", "i-1234567890abcdef0"]
#                     ],
#                     "period": 300,
#                     "stat": "Average",        
#                     "title": "EC2 CPU Utilization"
#                 }
#             },
#             {
#                 "type": "log",
#                 "properties": {
#                     "query": "fields @timestamp, @message | sort @timestamp desc | limit 20",
#                     "logGroupNames": ["/aws/lambda/my-function"],
#                     "title": "Recent Lambda Logs"
#                 }
#             }
#         ]
#     }'
#         aws cloudwatch put-dashboard --dashboard-name MyDashboard --dashboard-body '{
#         "widgets": [
#             {
#                 "type": "metric",
#                 "properties": {
#                     "metrics": [
#                         ["AWS/EC2", "CPUUtilization", "InstanceId", "i-1234567890abcdef0"]
#                     ],
#                     "period": 300,
#                     "stat": "Average",
#                     "title": "EC2 CPU Utilization"        
#                 }
#             },
#             {
#                 "type": "log",
#                 "properties": {
#                     "query": "fields @timestamp, @message | sort @timestamp desc | limit 20",
#                     "logGroupNames": ["/aws/lambda/my-function"],     
#                     "title": "Recent Lambda Logs"
#                 }
#             }
#         ]
#     }'        
## ## 6. Contributor Insights:
#   - Analyzes log data to provide insights into the top contributors to your system's performance and behavior.
#   - Helps identify patterns and trends in log data, such as high request rates or error rates.
#   - AWS Management Console Steps:
#     1. Open the CloudWatch console.
#     2. In the navigation pane, choose "Contributor Insights".
#     3. Click "Create rule".
#     4. Define the rule pattern (e.g., log group, filter pattern).
#     5. Configure the rule to analyze log data and generate insights.
#     6. Review and create the rule.
#   - AWS CLI Explanation:
#     - Use `aws cloudwatch put-contributor-insights-rule` to create or update a Contributor Insights rule.
#     - Use `aws cloudwatch describe-contributor-insights` to list existing Contributor Insights rules.
#     - Example:    
#         aws cloudwatch put-contributor-insights-rule --rule-name MyContributorInsightsRule \
#         --rule-pattern '{"source": ["aws.ec2"], "detail-type": ["EC2 Instance State-change Notification"], "detail": {"state": ["running"]}}' \
#         --log-group-name /aws/lambda/my-function --rule-state ENABLED
#         aws       
# cloudwatch describe-contributor-insights --rule-name MyContributorInsightsRule
#         aws cloudwatch put-contributor-insights-rule --rule-name MyContributorInsightsRule \
#         --rule-pattern '{"source": ["aws.ec2"], "detail-type": ["EC2 Instance State-change Notification"], "detail": {"state": ["running"]}}' \
#      --log-group-name /aws/lambda/my-function --rule-state ENABLED
#         aws cloudwatch describe-contributor-insights --rule-name MyContributorInsightsRule            
#         aws cloudwatch put-contributor-insights-rule --rule-name MyContributorInsightsRule \
#         --rule-pattern '{"source": ["aws.ec2"], "detail-type": ["EC2 Instance State-change Notification"], "detail": {"state": ["running"]}}' \
#         --log-group-name /aws/lambda/my-function --rule-state ENABLED
#         aws cloudwatch describe-contributor-insights --rule-name MyContributorInsightsRule        
#         aws cloudwatch put-contributor-insights-rule --rule-name MyContributorInsightsRule \
#         --rule-pattern '{"source": ["aws.ec2"], "detail-type": ["EC2 Instance State-change Notification"], "detail": {"state": ["running"]}}' \
#       --log-group-name /aws/lambda/my-function --rule-state ENABLED
#         aws cloudwatch describe-contributor-insights --rule-name MyContributorInsightsRule        
## 7. Anomaly Detection:
#   - Uses machine learning to detect anomalies in metrics and logs.        
#   - Automatically identifies unusual patterns and deviations from expected behavior.
#   - AWS Management Console Steps:     
#     1. Open the CloudWatch console.
#     2. In the navigation pane, choose "Anomaly Detection".
#     3. Click "Create anomaly detection model".
#     4. Select a metric to analyze and click "Select metric".      
#     5. Configure the model settings (e.g., sensitivity, time range).      
#     6. Review and create the anomaly detection model.
#   - AWS CLI Explanation:
#     - Use `aws cloudwatch put-anomaly-detector` to create or update an anomaly detection model.
#     - Use `aws cloudwatch describe-anomaly-detectors` to list existing anomaly detection models.
#     - Example:
#         aws cloudwatch put-anomaly-detector --namespace AWS/EC2 --metric-name CPUUtilization \
#         --statistic Average --dimensions Name=InstanceId,Value=i-1234567890abcdef0 \
#         --configuration '{"ExcludedTimeRanges": [{"StartTime": "2023-10-01T00:00:00Z", "EndTime": "2023-10-01T01:00:00Z"}], "Sensitivity": 90}'        
#         aws cloudwatch describe-anomaly-detectors --namespace AWS/EC2 --metric-name CPUUtilization \
#         --dimensions Name=InstanceId,Value=i-1234567890abcdef0
#         aws cloudwatch put-anomaly-detector --namespace AWS/EC2 --metric-name CPUUtilization \
#         --statistic Average --dimensions Name=InstanceId,Value=i-1234567890abcdef0 \
#         --configuration '{"ExcludedTimeRanges": [{"StartTime": "2023-10-01T00:00:00Z", "EndTime": "2023-10-01T01:00:00Z"}], "Sensitivity": 90}'        
#         aws cloudwatch describe-anomaly-detectors --namespace AWS/EC2 --metric-name CPUUtilization \
#         --dimensions Name=InstanceId,Value=i-1234567890abcdef0
#         aws cloudwatch put-anomaly-detector --namespace AWS/EC2 --metric-name CPUUtilization \
#         --statistic Average --dimensions Name=InstanceId,Value=i-1234567890abcdef0 \
#         --configuration '{"ExcludedTimeRanges": [{"StartTime": "2023-10-01T00:00:00Z", "EndTime": "2023-10-01T01:00:00Z"}, "Sensitivity": 90}'        
#         aws cloudwatch describe-anomaly-detectors --namespace AWS/EC2 --metric-name CPUUtilization \
#         --dimensions Name=InstanceId,     
# Value=i-1234567890abcdef0
#         aws cloudwatch put-anomaly-detector --namespace AWS/EC2 --metric-name CPUUtilization \
#         --statistic Average --dimensions Name=InstanceId,Value=i-1234567890abcdef0 \
#         --configuration '{"ExcludedTimeRanges": [{"StartTime": "2023-10-01T00:00:00Z", "EndTime": "2023-10-01T01:00:00Z"}], "Sensitivity": 90     
# }'
#         aws cloudwatch describe-anomaly-detectors --namespace AWS/EC2 --metric-name CPUUtilization \
#         --dimensions Name=InstanceId,Value=i-1234567890abcdef0
#         aws cloudwatch put-anomaly-detector --namespace AWS/EC2 --metric-name CPUUtilization \
#         --statistic Average --dimensions Name=InstanceId,Value=i-1234567890abcdef0 \
#         --configuration '{"ExcludedTimeRanges": [{"StartTime": "2023-10-01T00:00:00Z", "EndTime": "2023-10-01T01:00:00Z"}], "Sensitivity": 90}'        
#         aws cloudwatch describe-anomaly-detectors --namespace AWS/EC2 --metric-name CPUUtilization \
#         --dimensions Name=InstanceId,Value=i-1234567890abcdef0
# ## 8. Custom Metrics:
#   - Allows you to publish custom metrics from your applications or services.
#   - Enables you to monitor application-specific metrics that are not provided by default.
#   - AWS Management Console Steps:
#     1. Open the CloudWatch console.
#     2. In the navigation pane, choose "Metrics".
#     3. Click "Create metric".
#     4. Select "Custom metrics" and click "Next".                  
#     5. Enter the metric name, namespace, and dimensions.
#     6. Click "Create metric" to publish the custom metric.
#   - AWS CLI Explanation:
#     - Use `aws cloudwatch put-metric-data` to publish custom metrics.
#     - Use `aws cloudwatch list-metrics` to list custom metrics.
#     - Example:
#         aws cloudwatch put-metric-data --namespace MyCustomNamespace --metric-name MyCustomMetric \
#         --value 100 --unit Count --dimensions InstanceId=i-1234567890abcdef0
#     aws cloudwatch list-metrics --namespace MyCustomNamespace --metric-name MyCustomMetric    
#         aws cloudwatch put-metric-data --namespace MyCustomNamespace --metric-name MyCustomMetric \
#         --value 100 --unit Count --dimensions InstanceId=i-1234567890abcdef0
#         aws cloudwatch list-metrics --namespace MyCustomNamespace --metric-name MyCustomMetric
#         aws cloudwatch put-metric-data --namespace MyCustomNamespace --metric-name MyCustomMetric \
#         --value 100 --unit Count --dimensions InstanceId=i-1234567890abcdef0
#         aws cloudwatch list-metrics --namespace MyCustomNamespace --metric-name MyCustomMetric
#         aws cloudwatch put-metric-data --namespace MyCustomNamespace --metric-name MyCustomMetric \
#         --value 100 --unit Count --dimensions InstanceId=i-1234567890abcdef0
#         aws cloudwatch list-metrics --namespace My