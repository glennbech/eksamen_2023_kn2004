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
                "title": "Hourly people and images scanned"
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
                    [ ".", "facial_violations.count", { "region": "${var.metrics_region}", "color": "${var.facial_violations_color}" } ],
                    [ ".", "head_violations.count", { "region": "${var.metrics_region}", "color": "${var.head_violations_color}" } ]
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
                    [ "${var.cloudwatch_namespace}", "facial_violations.count", { "region": "${var.metrics_region}", "color": "${var.facial_violations_color}" } ],
                    [ ".", "head_violations.count", { "region": "${var.metrics_region}", "color": "${var.head_violations_color}" } ]
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
            "height": 6,
            "width": 6,
            "y": 0,
            "x": 18,
            "properties": {
                "metrics": [
                    [ "kn2004", "people_scanned.count", { "visible": false, "id": "m1", "region": "${var.metrics_region}" } ],
                    [ ".", "head_violations.count", { "visible": false, "id": "m2", "region": "${var.metrics_region}" } ],
                    [ ".", "facial_violations.count", { "visible": false, "id": "m3", "region": "${var.metrics_region}" } ],
                    [ { "expression": "(m3 / m1) * 100", "label": "no face ppe", "id": "e1", "stat": "Sum", "region": "${var.metrics_region}", "color": "${var.facial_violations_color}" } ],
                    [ { "expression": "(m2 / m1) * 100", "label": "no head ppe", "id": "e2", "stat": "Sum", "region": "${var.metrics_region}", "color": "${var.head_violations_color}" } ]
                ],
                "view": "gauge",
                "region": "${var.metrics_region}",
                "stat": "Sum",
                "period": 3600,
                "yAxis": {
                    "left": {
                        "min": 0,
                        "max": 100
                    }
                },
                "title": "Precentage of people the past hour without ppe",
                "singleValueFullPrecision": false,
                "liveData": false,
                "setPeriodToTimeRange": false,
                "sparkline": true,
                "trend": true,
                "annotations": {
                    "horizontal": [
                        {
                            "color": "#d62728",
                            "label": "25 %",
                            "value": 25
                        }
                    ]
                }
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
                    [ ".", "facial_violations.count", { "region": "${var.metrics_region}", "color": "${var.facial_violations_color}" } ],
                    [ ".", "head_violations.count", { "region": "${var.metrics_region}", "color": "${var.head_violations_color}" } ]
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
                    [ "${var.cloudwatch_namespace}", "facial_violations.count", { "region": "${var.metrics_region}", "color": "${var.facial_violations_color}" } ],
                    [ ".", "head_violations.count", { "region": "${var.metrics_region}", "color": "${var.head_violations_color}" } ]
                ],
                "view": "pie",
                "region": "${var.metrics_region}",
                "stat": "Sum",
                "period": 86400,
                "title": "Daily violation type pie chart"
            }
        },
        
        {
            "type": "alarm",
            "x": 18,
            "y": 6,
            "width": 6,
            "height": 2,
            "properties": {
                "title": "ALARM: not enough head ppe",
                "alarms": [
                    "arn:aws:cloudwatch:eu-west-1:244530008913:alarm:kn2004-not-enough-head-ppe"
                ]
            }
        }
    ]
}
DASHBOARD
}