# NHL API for R

[![Travis build status](https://travis-ci.org/pbulsink/nhlRapi.svg?branch=master)](https://travis-ci.org/pbulsink/nhlRapi) [![Coverage status](https://codecov.io/gh/pbulsink/nhlRapi/branch/master/graph/badge.svg)](https://codecov.io/github/pbulsink/nhlRapi?branch=master)

## Introduction

The NHL has a poorly documented API that has a lot of information available in it for absolutely free. There are statistics and records available, focusing on teams, players, games, drafts, prospects, and awards. This package aims to provide a basic API wrapper for use in `R`. Significant information required for the development of this package comes from [https://gitlab.com/dword4/nhlapi](https://gitlab.com/dword4/nhlapi).

## Installation
This package can be installed by running the following command in an `R` session:
```
devtools::install.github('pbulsink/nhlRapi')
```

The package is still under development and may undergo rapid changes, including breaking changes, without warning. Please test any code using this package regularly. 

The package may make it to CRAN one day, once stability is achieved. Please watch for that. 

## Usage
Initially this API will be a dumb wrapper only, calling the API and returning the data as a json object as recieved. Future versions may initiate data cleaning or other manipulations. 

## API Coverage

The following items are covered by this API:

### STATS

- [x] Teams
- [x] Divisions
- [x] Conferences
- [x] People
- [x] Game-IDs
- [x] Schedule
- [x] Standings
- [x] ~~Standings Types~~
- [x] ~~Stats Types~~
- [x] Team Stats
- [x] Draft
- [x] Prospects
- [x] Awards
- [x] Venues (new)

*Stats Types and Standings Types are modifiers for People Stats and Standings, respectively*

### RECORDS

- [X] Attendance
- [x] Draft
- [X] Records
- [x] Franchise
- [x] Player
- [X] Playoffs
- [x] Trophy
- [x] Milestones
- [X] Officials

### Filtering
Some functions contain introductory filter options. Further filtering can be done once data is retrieved by the API. For example, the API can get all attendance records `getAttendance()` or a specific season `getAttendance(season = 20152016)`. While the web API allows for other field filtering (e.g. a call for `playoffAttendance>1000000`), the `R` api functions do not have all of these built in. 

Instead, use `R` to perform these filters for now:
```r
attendance<-getAttendance()
attendance<-attendance$data[attendance$data$playoffAttendance > 1000000, ]
```

## Copyright
All data, teams, logos, and information is copyright NHL and its teams, with compliance to the copyright statement recieved from each API call or from `getCopyright()`.

