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
                    [ "kn2004", "people_scanned.count", { "region": "eu-west-1" } ]
                ],
                "sparkline": true,
                "view": "singleValue",
                "region": "eu-west-1",
                "stat": "Sum",
                "period": 3600,
                "title": "Hourly people scanned"
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
                    [ "kn2004", "total_violations.count", { "region": "eu-west-1" } ],
                    [ ".", "facial_violations.count", { "region": "eu-west-1" } ],
                    [ ".", "head_violations.count", { "region": "eu-west-1" } ]
                ],
                "sparkline": true,
                "view": "singleValue",
                "region": "eu-west-1",
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
                    [ "kn2004", "facial_violations.count", { "region": "eu-west-1" } ],
                    [ ".", "head_violations.count", { "region": "eu-west-1" } ]
                ],
                "view": "pie",
                "region": "eu-west-1",
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
                    [ "kn2004", "people_scanned.count", { "region": "eu-west-1" } ]
                ],
                "sparkline": true,
                "view": "singleValue",
                "region": "eu-west-1",
                "stat": "Sum",
                "period": 86400,
                "title": "Daily people scanned"
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
                    [ "kn2004", "total_violations.count", { "region": "eu-west-1" } ],
                    [ ".", "facial_violations.count", { "region": "eu-west-1" } ],
                    [ ".", "head_violations.count", { "region": "eu-west-1" } ]
                ],
                "sparkline": true,
                "view": "singleValue",
                "region": "eu-west-1",
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
                    [ "kn2004", "facial_violations.count", { "region": "eu-west-1" } ],
                    [ ".", "head_violations.count", { "region": "eu-west-1" } ]
                ],
                "view": "pie",
                "region": "eu-west-1",
                "stat": "Sum",
                "period": 86400,
                "title": "Daily violation type pie chart"
            }
        }
    ]
}
DASHBOARD
}