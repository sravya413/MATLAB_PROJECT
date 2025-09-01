# Real-Time Speech Enhancement in MATLAB

This project implements real-time and offline speech enhancement techniques in MATLAB, focusing on **noise reduction**, **frequency shaping**, and **amplitude compression** to improve audio clarity and intelligibility.

## 📌 Overview

Two main MATLAB programs are provided:

1. **Real-Time Voice Enhancement with Live Microphone Input**
2. **Offline Audio File Processing for `.wav` Files**

Each serves a unique purpose and is designed with practical use cases in mind.

---

## 🎤 1. Real-Time Voice Enhancement (Live Microphone Input)

This program captures audio live from the microphone, enhances the signal in real-time, and plays back the improved version. It uses:
- **Low-Pass Filtering** to reduce noise
- **Frequency Shaping** to emphasize speech bands
- **Amplitude Compression** to avoid distortion and loud bursts

### 🔧 Features:
- Real-time audio recording and playback
- Adaptive denoising and enhancement
- Spectrogram visualization
---

## 🎧 2. Offline WAV File Processing (For Pre-Recorded Audio)

This second program processes a `.wav` file instead of live input. It is particularly useful when:
- You want to test enhancement on existing audio samples
- Live microphone access is restricted (e.g., due to hardware limitations)
- You want to benchmark denoising techniques against standard datasets

MATLAB’s `audioDeviceReader` and `dsp.AudioFileWriter` objects work well for real-time streaming, but for static `.wav` files, simpler direct processing offers:
- More control over filter design
- Easier visualization of effects at each stage
- No need for buffer management
- `wav_main.mlx` Loads any `.wav` file
- Adds white Gaussian noise (for simulation)
- Applies:
  - Low-pass filtering
  - Band-pass frequency shaping
  - FFT-based amplitude compression
- Visualizes waveforms and spectrograms before and after enhancement

---

## 🧪 Dependencies

This project requires:
- MATLAB R2017a or later
- DSP System Toolbox
- Signal Processing Toolbox

---

## 🚀 Getting Started

### For Real-Time Voice Enhancement:
1. Open `real_time_voice_enhancer.m` in MATLAB.
2. Ensure your microphone is working and permitted in MATLAB.
3. Run the script. Speak into your microphone and listen to the enhanced output.

### For Offline `.wav` File Processing:
1. Replace `'clean_tone.wav'` in the script with your own `.wav` file.
2. Run `wav_main.mlx`.
3. Listen to and analyze the processed audio output.

---
