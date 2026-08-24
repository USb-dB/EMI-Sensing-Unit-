# Portable EMI/EMC Meter

A portable, low-cost EMI/EMC measurement system developed for sensing and characterizing high-frequency electromagnetic emissions from electronic and digital switching systems.

## Overview

The system combines an analog magnetic-field sensing front-end with embedded data acquisition and digital spectral analysis to characterize electromagnetic emissions associated with high-frequency switching activity.

The project focuses on:

- High-frequency AC magnetic-field sensing
- EMI detection from digital switching circuits
- Analog front-end and signal-conditioning design
- Real-time data acquisition using ESP32
- FFT and power spectral density (PSD) analysis
- PCB design and hardware prototyping
- Experimental characterization using a coil-antenna test source

## System Architecture

```text
High-Frequency Switching Source
             │
             ▼
     Coil-Antenna Test Source
             │
             ▼
   Magnetic-Field Sensor / AFE
             │
             ▼
          ESP32
             │
             ▼
      Signal Acquisition
             │
             ▼
       FFT / PSD Analysis
             │
             ▼
    EMI Spectral Characterization
```
## Publication and Intellectual Property

This work has been **accepted for presentation/publication at IEEE PEDAS**.

The associated intellectual property is protected under:

**Indian Patent Application No. 202631013071**

The patent application is currently **pending grant**.

## Results

The prototype has been experimentally characterized using a controlled coil-antenna test source. Detailed measurement data, spectral results, and experimental characterization plots will be added to this repository **after the patent is granted**.

Further technical details will also be updated following the grant to avoid premature disclosure of patent-related information.

## Current Status

- Prototype: **Completed**
- Experimental characterization: **Completed**
- IEEE PEDAS: **Accepted**
- Patent Application: **Pending grant**
- Detailed results/data: **To be added after patent grant**
