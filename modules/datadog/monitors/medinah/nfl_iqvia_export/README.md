# Medinah

## NFL IQVIA Export

These Datadog monitors track events and errors in the daily NFL IQVIA export. This is a step function that calls medinah's
export_migratable_csv task for all NFL data, combines these files into a single file per-data type and then uploads these
files to an IQVIA S3 bucket.

