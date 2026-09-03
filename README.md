# 🟧 Responsive Dashboard

<div align="center">

### A Modern Responsive Flutter Dashboard

**Mobile • Tablet • Desktop**

Built with Flutter using  
`ListView` • `GridView` • `MediaQuery` • `Expanded` • `Flexible`

<br>

![Flutter](https://img.shields.io/badge/Flutter-3.22%2B-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.0%2B-0175C2?logo=dart)
![Material](https://img.shields.io/badge/Material%20Design-3-757575?logo=materialdesign)
![Responsive](https://img.shields.io/badge/UI-Responsive-FF6B00)
![Status](https://img.shields.io/badge/Status-Completed-22C55E)

</div>

---

## 📊 Project Overview

<div align="center">

![Dashboard Infographic](assets/dashboard-infographic.png)

</div>

---

## ✨ Preview

A clean **Orange + White + Black** dashboard designed to adapt automatically to different screen sizes.

### 🖥️ Desktop

<div align="center">

![Desktop Dashboard](assets/dashboard-desktop.png)

</div>

### 📱 Responsive Views

<div align="center">

![Responsive Dashboard](assets/dashboard-responsive.png)

</div>

---

## 🎯 Objective

The goal of this project is to build a **multi-section responsive dashboard** using Flutter's built-in responsive layout capabilities.

The interface automatically adapts according to the available screen width instead of using a fixed layout.

### Core Flutter concepts

```text
MediaQuery
     ↓
Detect Screen Width
     ↓
┌──────────────┬──────────────┬──────────────┐
│    Mobile    │    Tablet    │   Desktop    │
│   < 600px    │ 600–1099px   │  ≥ 1100px    │
└──────────────┴──────────────┴──────────────┘
     ↓
Adaptive Dashboard
