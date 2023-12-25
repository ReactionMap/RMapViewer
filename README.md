# RMapViewer
ReactionMap viewer on Pharo Smalltalk

## Installation
Please evaluate the following on Pharo 11 (downloadable from Pharo [download page](https://pharo.org/download))

```smalltalk
[Metacello new
    onConflictUseIncoming;
    repository: 'github://tomooda/RMapViewer:pharo10/repository';
    baseline: 'RMapViewer';
    load] on: MCMergeOrLoadWarning do: [:warning | warning load ]
```

If you are Pharo developer, you can simply save the image.
If you don't need development environment, you may want to evaluate

```smalltalk
RMapMorph makeReleaseImage
```

which will save image making the Pharo system's UI dedicated to RMapViewer.
