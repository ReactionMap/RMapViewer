# RMapViewer
ReactionMap viewer on Pharo Smalltalk

## Installation
Please evaluate the following on Pharo 4.0 (downloadable from Pharo [fileserver](https://files.pharo.org/platform/))

```smalltalk
Metacello new
    repository: 'github://ReactionMap/RMapViewer/repository/';
    baseline: 'RMapViewer';
    load
```

If you are Pharo developer, you can simply save the image.
If you don't need development environment, you may want to evaluate

```smalltalk
RMapMorph makeReleaseImage
```

which will save image making the Pharo system's UI dedicated to RMapViewer.
