#!/bin/bash

# Usage:
# ./bin/analyze.sh two_fer ~/test/

/usr/bin/env perl ./bin/analyze.pl $1 $2 > $2fixtures/$1/analysis.json
