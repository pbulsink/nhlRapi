# NHL API for R

[![Travis build status](https://travis-ci.org/pbulsink/nhlRapi.svg?branch=master)](https://travis-ci.org/pbulsink/nhlRapi) [![Coverage status](https://codecov.io/gh/pbulsink/nhlRapi/branch/master/graph/badge.svg)](https://codecov.io/github/pbulsink/nhlRapi?branch=master)

## Introduction

The NHL has a poorly documented API that has a lot of information available in it for absolutely free. There are statistics and records available, focusing on teams, players, games, drafts, prospects, and awards. This package aims to provide a basic API wrapper for use in R. Significant information required for the development of this package comes from [https://gitlab.com/dword4/nhlapi](https://gitlab.com/dword4/nhlapi).

## Usage
Initially this API will be a dumb wrapper only, calling the API and returning the data as a json object as recieved. Future versions may initiate data cleaning or other manipulations. 

## API Coverage

The following items are / will be covered by this API:

### STATS

- [x] Teams
- [x] Divisions
- [x] Conferences
- [x] People
- [ ] Game-IDs
- [ ] Schedule
- [x] Standings
- [x] ~~Standings Types~~
- [x] ~~Stats Types~~
- [ ] Team Stats
- [x] Draft
- [x] Prospects
- [x] Awards

*Stats Types and Standings Types are modifiers for People and Standings and Team Stats and won't be public facing*

### RECORDS

- [ ] Attendance
- [ ] Draft
- [ ] Records
- [ ] Franchise
- [ ] Player
- [ ] Playoffs
- [ ] Trophy
- [ ] Milestones
- [ ] Officials

## Copyright
All data, teams, logos, and information is copyright NHL and its teams, with compliance to the copyright statement recieved from each API call. 

