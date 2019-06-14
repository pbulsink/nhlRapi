# NHL API for R

[![CRAN](http://www.r-pkg.org/badges/version/nhlRapi)](http://cran.r-project.org/package=nhlRapi)
[![Travis build status](https://travis-ci.org/pbulsink/nhlRapi.svg?branch=master)](https://travis-ci.org/pbulsink/nhlRapi)
[![AppVeyor build status](https://ci.appveyor.com/api/projects/status/github/pbulsink/nhlRapi?branch=master&svg=true)](https://ci.appveyor.com/project/pbulsink/nhlRapi)
[![Coverage status](https://codecov.io/gh/pbulsink/nhlRapi/branch/master/graph/badge.svg)](https://codecov.io/github/pbulsink/nhlRapi?branch=master)

## Introduction

The NHL has a poorly documented API that has a lot of information available in it for absolutely free. There are statistics and records available, focusing on teams, players, games, drafts, prospects, and awards. This package aims to provide a basic API wrapper for use in `R`. Significant information required for the development of this package comes from [https://gitlab.com/dword4/nhlapi](https://gitlab.com/dword4/nhlapi).

The package is still under development and may undergo rapid changes, including breaking changes, without warning. Please test any code using this package regularly. 

The package may make it to CRAN one day, once stability is achieved. Please watch for that. 

## Installation
This package can be installed by running the following command in an `R` session:
```
devtools::install.github('pbulsink/nhlRapi')
```

Then, load the package into the R namespace:
```
library(nhlRapi)
```

## Usage
Initially this API will be a dumb wrapper only, calling the API and returning the data as a json object as recieved. Future versions may initiate data cleaning or other manipulations. 

## API Coverage

The following items are covered by this API:

### STATS

- [X] Teams
- [X] Divisions
- [X] Conferences
- [X] People
- [x] Game-IDs
- [X] Schedule
- [X] Standings
- [X] ~~Standings Types~~
- [X] ~~Stats Types~~
- [X] Team Stats
- [X] Draft
- [X] Prospects
- [X] Awards
- [X] Venues
- [ ] Tournaments (new)
- [ ] Seasons (new)

*Stats Types and Standings Types are modifiers for People Stats and Standings, respectively*

### RECORDS

- [X] Attendance
- [X] Draft
- [X] Records
- [X] Franchise
- [X] Player
- [X] Playoffs
- [X] Trophy
- [X] Milestones
- [X] Officials

### Filtering
Some functions contain introductory filter options. Further filtering can be done once data is retrieved by the API. For example, the API can get all attendance records `getAttendance()` or a specific season `getAttendance(season = 20152016)`. While the web API allows for other field filtering (e.g. a call for `playoffAttendance>1000000`), the `R` api functions do not have all of these built in. 

Instead, use `R` to perform these filters:
```r
attendance<-getAttendance()
attendance<-attendance$data[attendance$data$playoffAttendance > 1000000, ]
```

## Good API Etiquette
There are no rate limiters built into the API to prevent over-usage of the API. However, significant requests may induce the NHL to throttle or ban your IP address and prevent you from getting data. If using this API, please rate limit yourself. 

Rate limiting may be added in future versions.

## Copyright
All data, teams, logos, and information is copyright NHL and its teams, with compliance to the copyright statement recieved from the API call (from `getCopyright()`).

