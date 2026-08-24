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
