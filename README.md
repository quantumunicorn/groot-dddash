# What?

Model [DataDog](https://www.datadoghq.com/) dashboard for [CF
GrootFS](https://github.com/cloudfoundry/grootfs-release)'s needs.

See [T&C](#t-c) bellow!

# How to configure?

Open `./config` and fill in the blanks.

## Meta

Self-explanatory.

* `TITLE`
* `DESCRIPTION`

## Metrics

* `PREFIX` the [Loggregator Firehose DataDog
  nozzle](https://github.com/cloudfoundry-incubator/datadog-firehose-nozzle-release)
  [prefix](https://github.com/cloudfoundry-incubator/datadog-firehose-nozzle-release/blob/master/jobs/datadog-firehose-nozzle/spec#L26).
* `BOSH_PREFIX` the [BOSH health monitor](https://bosh.io/docs/hm-config.html)
  (HM) DataDog metric prefix. No need to change that. The default will do.

## Deployment

* `QUERY` the DataDog query for metrics. Just specifying the deployment name
  (e.g.: `deployment:cf-foo-diego`) should do. Adding job names (`e.g.:
  deployment:cf-foo-diego,job:diego-cell`) is better if you care a lot for the
  CPU/memory/disk graphs (otherwise you will get CPU/memory/disk metrics from
  all the VMs, not just the cells).

## Dashboard

* `DASH_ID` leave it `0` to create a new dashboard. If set to a positive
  integer, `./import.sh` will try to update the identified dashboard.


## DataDog API

Self-explanatory. These credentials can be created an accessed from the DataDog
UI (look for API on the left bar).

* `API_KEY`
* `APP_KEY`

# How to import?

1. Correctly configure `./config`.
1. Run `./import.sh`.
1. Open the provided URL.

# T&C

## RULE NUMBER 1 OF `GROOT-DDDASH`!!!

NEVER UPDATE THE DASHBOARD MANUALLY WITHOUT ALSO UPDATING THE JSON TEMPLATE.
THIS IS WHY WE WILL NEVER MAKE IT TO MARS!

## Rule number 2 of `groot-dddash`

Please commit back any changes you make in `./dash.json.erb` so others can also
benefit from them.
