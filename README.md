# pixelmatch

A single executable [pixelmatch](https://github.com/mapbox/pixelmatch) for Swift Package Manager. Works greate with [swift-snapshot-testing](https://github.com/pointfreeco/).

## Installation

### Swift Package Manager
```swift
dependencies: [
  // ...
  .package(url: "https://github.com/ramble-inc/pixelmatch", from: "5.2.1"),
],
```

### cURL
```sh
curl -sS -o pixelmatch -L https://github.com/ramble-inc/pixelmatch/releases/download/5.2.1/pixelmatch
```

## Usage
Same as [pixelmatch](https://github.com/mapbox/pixelmatch#command-line)
```sh
pixelmatch image1.png image2.png output.png 0.1
```

Sample script to generate diff images for [swift-snapshot-testing](https://github.com/pointfreeco/).
```sh
#!/bin/sh

GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
RESET='\033[0m'
SNAPSHOT_ROOT=MyAppSnapshotTests
SNAPSHOT_DIR=$SNAPSHOT_ROOT/__Snapshots__
SNAPSHOT_FAILURE_DIR=$SNAPSHOT_ROOT/__Snapshots_Failure__
SNAPSHOT_DIFF_DIR=$SNAPSHOT_ROOT/__Snapshots_Diff__
THRESHOLD=0.1

if [ ! -d $SNAPSHOT_FAILURE_DIR ]; then
  echo "$SNAPSHOT_FAILURE_DIR does not exist. Skip generating diff images."
  exit 0
fi

rm -rf $SNAPSHOT_DIFF_DIR

for dir in $(ls -d $SNAPSHOT_DIR/*/); do
  TEST_CASE=$(basename $dir)
  mkdir -p $SNAPSHOT_DIFF_DIR/$TEST_CASE

  for file in $(ls $SNAPSHOT_DIR/$TEST_CASE/*.png); do
    IMAGE=$(basename $file)
    echo "${BLUE}$TEST_CASE/$IMAGE${RESET}"

    swift run pixelmatch \
      $SNAPSHOT_DIR/$TEST_CASE/$IMAGE \
      $SNAPSHOT_FAILURE_DIR/$TEST_CASE/$IMAGE \
      $SNAPSHOT_DIFF_DIR/$TEST_CASE/$IMAGE \
      $THRESHOLD

    echo
  done
done

echo "${GREEN}✔${RESET} done"
```

## Disclaimer

The executable is about **70MB** because [pixelmatch](https://github.com/mapbox/pixelmatch) is packaged into a single executable with [pkg](https://github.com/vercel/pkg).
