# README

My personal field service helper

[![Build Status](https://travis-ci.org/mjacobus/field-service.svg?branch=master)](https://travis-ci.org/mjacobus/field-service)
[![Code Climate](https://codeclimate.com/github/mjacobus/field-service/badges/gpa.svg)](https://codeclimate.com/github/mjacobus/field-service)
[![Scrutinizer Code Quality](https://scrutinizer-ci.com/g/mjacobus/field-service/badges/quality-score.png?b=master)](https://scrutinizer-ci.com/g/mjacobus/field-service/?branch=master)
[![Issue Count](https://codeclimate.com/github/mjacobus/field-service/badges/issue_count.svg)](https://codeclimate.com/github/mjacobus/field-service)
[![Coverage Status](https://coveralls.io/repos/github/mjacobus/field-service/badge.svg)](https://coveralls.io/github/mjacobus/field-service)
[![Dependency Status](https://gemnasium.com/badges/github.com/mjacobus/field-service.svg)](https://gemnasium.com/github.com/mjacobus/field-service)

## Installing

Copy .env.example to .env and change accordingly.

## Importing/exporting

```bash
rake csv:householders:import     # will import CSVs inside csv/to_import
rake csv:householders:export_all # will export to csv/exports
```

### CSV columns:

- `territory_name` - required
- `street_name` - required
- `house_number` - required
- `name` - required
- `show` - (yes|no) required
- `uuid`
- `updated_at`
