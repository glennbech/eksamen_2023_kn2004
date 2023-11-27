resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = var.dashboard_name
  dashboard_body = <<DASHBOARD

  {
    "widgets": [
        {
            "type": "metric",
            "x": 0,
            "y": 0,
            "width": 6,
            "height": 6,
            "properties": {
                "metrics": [
                    [ "${var.cloudwatch_namespace}", "people_scanned.count", { "region": "${var.metrics_region}" } ],
                    [ ".", "images_scanned.count", { "region": "${var.metrics_region}" } ]
                ],
                "sparkline": true,
                "view": "singleValue",
                "region": "${var.metrics_region}",
                "stat": "Sum",
                "period": 3600,
                "title": "Hourly people and scanned"
            }
        },
        {
            "type": "metric",
            "x": 6,
            "y": 0,
            "width": 6,
            "height": 6,
            "properties": {
                "metrics": [
                    [ "${var.cloudwatch_namespace}", "total_violations.count", { "region": "${var.metrics_region}" } ],
                    [ ".", "facial_violations.count", { "region": "${var.metrics_region}" } ],
                    [ ".", "head_violations.count", { "region": "${var.metrics_region}" } ]
                ],
                "sparkline": true,
                "view": "singleValue",
                "region": "${var.metrics_region}",
                "stat": "Sum",
                "period": 3600,
                "title": "Hourly violations"
            }
        },
        {
            "type": "metric",
            "x": 12,
            "y": 0,
            "width": 6,
            "height": 6,
            "properties": {
                "metrics": [
                    [ "${var.cloudwatch_namespace}", "facial_violations.count", { "region": "${var.metrics_region}" } ],
                    [ ".", "head_violations.count", { "region": "${var.metrics_region}" } ]
                ],
                "view": "pie",
                "region": "${var.metrics_region}",
                "stat": "Sum",
                "period": 3600,
                "title": "Hourly violation type pie chart"
            }
        },
        
        
        
        {
            "type": "metric",
            "x": 0,
            "y": 6,
            "width": 6,
            "height": 6,
            "properties": {
                "metrics": [
                    [ "${var.cloudwatch_namespace}", "people_scanned.count", { "region": "${var.metrics_region}" } ],
                    [ ".", "images_scanned.count", { "region": "${var.metrics_region}" } ]

                ],
                "sparkline": true,
                "view": "singleValue",
                "region": "${var.metrics_region}",
                "stat": "Sum",
                "period": 86400,
                "title": "Daily people and images scanned"
            }
        },
        {
            "type": "metric",
            "x": 6,
            "y": 6,
            "width": 6,
            "height": 6,
            "properties": {
                "metrics": [
                    [ "${var.cloudwatch_namespace}", "total_violations.count", { "region": "${var.metrics_region}" } ],
                    [ ".", "facial_violations.count", { "region": "${var.metrics_region}" } ],
                    [ ".", "head_violations.count", { "region": "${var.metrics_region}" } ]
                ],
                "sparkline": true,
                "view": "singleValue",
                "region": "${var.metrics_region}",
                "stat": "Sum",
                "period": 86400,
                "title": "Daily violations"
            }
        },
        {
            "type": "metric",
            "x": 12,
            "y": 6,
            "width": 6,
            "height": 6,
            "properties": {
                "metrics": [
                    [ "${var.cloudwatch_namespace}", "facial_violations.count", { "region": "${var.metrics_region}" } ],
                    [ ".", "head_violations.count", { "region": "${var.metrics_region}" } ]
                ],
                "view": "pie",
                "region": "${var.metrics_region}",
                "stat": "Sum",
                "period": 86400,
                "title": "Daily violation type pie chart"
            }
        }
    ]
}
DASHBOARD
}