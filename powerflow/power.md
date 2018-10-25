# The little power board

This power board controls the switching of a high-drain circuit with a low-drain circuit.

## How it works

A small arduino measures the voltages of the incoming lines and turns them on/off accordingly using SSR's.

The low power circuit is measured in code and is reported externally on digital pins for inticators and also on serial port if required.

3 lines come in

### Circuit diagram

### Code example

## Refs

Per cell power range for a lipo (some info [here](https://rogershobbycenter.com/lipoguide/
))

 State | voltage |
-|-
absolutely dead | 1.5v
recoverable dead | 2.1v
empty and degrading | <3v
empty | ~3.2v
nominal | 3.7v
charged | 4.2v
