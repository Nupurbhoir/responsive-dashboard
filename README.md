cat > README.md <<'EOF'
# 🟧 Responsive Dashboard

A modern, responsive **Flutter Dashboard** designed to adapt seamlessly across **Mobile, Tablet, and Desktop** screen sizes.

Built specifically to demonstrate responsive Flutter UI using:

`ListView` • `GridView` • `MediaQuery` • `Expanded` • `Flexible`

---

## ✨ Preview

> A clean Orange + White + Black dashboard interface with responsive layouts, statistics, sales analytics, quick actions, and recent activity.

### 🖥️ Desktop

![Responsive Dashboard Desktop](assets/dashboard-desktop.pdf)

### 📱 Responsive Views

![Responsive Dashboard](assets/dashboard-responsive.pdf)

---

## 🎯 Project Objective

The objective of this project is to create a **multi-section responsive dashboard** that automatically adapts its layout according to the available screen width.

The application demonstrates practical usage of Flutter's responsive layout widgets rather than relying on a fixed-size interface.

---

## 🚀 Key Features

- 📊 Responsive statistics dashboard
- 📈 Weekly sales overview
- 👥 User and customer statistics
- 🛒 Order management section
- 📦 Product management section
- ⚡ Quick action panel
- 📝 Recent activity feed
- 🔔 Notification button
- 👤 Profile button
- 🆘 Support section
- 📱 Mobile bottom navigation
- 📂 Mobile/tablet navigation drawer
- 🖥️ Desktop permanent sidebar
- 🎨 Orange, White & Black theme
- 📐 Fully responsive layout
- ✅ Overflow-safe UI
- 🧩 Reusable Flutter components

---

## 📱 Responsive Design

The dashboard automatically changes its layout depending on screen width.

```mermaid
flowchart LR
    A[Screen Width] --> B{MediaQuery}

    B -->|< 600px| C[📱 Mobile]
    B -->|600 - 1099px| D[📟 Tablet]
    B -->|≥ 1100px| E[🖥️ Desktop]

    C --> C1[2 Column Grid]
    C --> C2[Stacked Sections]
    C --> C3[Bottom Navigation]

    D --> D1[2 Column Grid]
    D --> D2[Expanded Content]
    D --> D3[Drawer Navigation]

    E --> E1[4 Column Grid]
    E --> E2[Sidebar Navigation]
    E --> E3[Multi-column Layout]