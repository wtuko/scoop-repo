# scoop-repo

[![Tests](https://github.com/wtuko/scoop-repo/actions/workflows/ci.yml/badge.svg)](https://github.com/wtuko/scoop-repo/actions/workflows/ci.yml) [![Excavator](https://github.com/wtuko/scoop-repo/actions/workflows/excavator.yml/badge.svg)](https://github.com/wtuko/scoop-repo/actions/workflows/excavator.yml)

Personal bucket for [Scoop](https://scoop.sh), the Windows command-line installer.

## Usage

To add this bucket, run the following command in PowerShell:

```
scoop bucket add wtuko https://github.com/wtuko/scoop-repo
```

Then install any app from this bucket:

```
scoop install wtuko/<app_name>
```
